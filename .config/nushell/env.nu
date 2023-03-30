# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

if (path("/etc/os-release").exists) {
  $OS = (path("/etc/os-release").lines | grep "^NAME=" | str trim "\"" | str split "=" | get 1).text
  $OS_VER = (path("/etc/os-release").lines | grep "^VERSION_ID=" | str trim "\"" | str split "=" | get 1).text
} else if (which lsb_release > /dev/null) {
  $OS = (lsb_release -si).out
  $OS_VER = (lsb_release -sr).out
} else if (path("/etc/lsb-release").exists) {
  echo "/etc/lsb-release"
  $OS = (path("/etc/lsb-release").lines | grep "^DISTRIB_ID=" | str trim "\"" | str split "=" | get 1).text
  $OS_VER = (path("/etc/lsb-release").lines | grep "^DISTRIB_RELEASE=" | str trim "\"" | str split "=" | get 1).text
} else if (path("/etc/debian_version").exists) {
  $OS = "Debian"
  $OS_VER = (path("/etc/debian_version").read).text
} else if (path("/etc/SuSe-release").exists) {
  echo "should not enter here v1"
  exit
} else if (path("/etc/redhat-release").exists) {
  echo "should not enter here v2"
  exit
} else {
  #FreeBSD branches here.
  $OS = (uname -s).out
  $OS_VER = (uname -r).out
}

$env:OS = $OS
$env:OS_VER = $OS_VER

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
