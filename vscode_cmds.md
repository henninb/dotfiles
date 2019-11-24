# vscode commands
## show white space
* View -> Toggle Render Whitespace

editor.renderWhitespace: "all"

https://stackoverflow.com/questions/36814642/convert-spaces-to-tabs

## To convert existing indentation from spaces to tabs
```
Ctrl+Shift+P
>Convert indentation to Tabs
```

## config file settings in vscode
```shell
$ vi $HOME/.config/Code/User/settings.json
{
  "editor.renderControlCharacters": true,
  "editor.minimap.enabled": false,
  "editor.renderWhitespace": "all",
  "workbench.editor.showTabs": false,
  "editor.suggestSelection": "first",
  "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
  "team.showWelcomeMessage": false,
  "editor.wordWrap": "wordWrapColumn",
  "editor.renderWhiteSpace": "all",
  "editor.insertSpaces": false
}
```

code --list-extentions
code --show-versions
code --install-extention
