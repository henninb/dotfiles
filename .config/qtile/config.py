from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, hook, bar, widget

mod = 'mod1'
color_alert = '#ee9900'
color_frame = '#808080'

# kick a window to another screen (handy during presentations)
def kick_to_next_screen(qtile, direction=1):
    other_scr_index = (qtile.screens.index(qtile.currentScreen) + direction) % len(qtile.screens)
    othergroup = None
    for group in qtile.cmd_groups().values():
        if group['screen'] == other_scr_index:
            othergroup = group['name']
            break
    if othergroup:
        qtile.moveToGroup(othergroup)

# see http://docs.qtile.org/en/latest/manual/config/keys.html
keys = [
    # Switch between windows in current stack pane
    Key([mod], 'Tab', lazy.layout.down()),
    Key([mod, 'shift'], 'Tab', lazy.layout.up()),
    # Move windows up or down in current stack
    # Switch window focus to other pane(s) of stack
    Key([mod, 'control'], 'Tab', lazy.layout.next()),
    Key([mod, 'control', 'shift'], 'Tab', lazy.layout.prev()),
    # Swap panes of split stack
    #Key([mod, 'shift'], 'space', lazy.layout.rotate()),
    # Change ratios
    Key([mod, 'shift'], 'p', lazy.spawn('dmenu')),
    #Key([mod], 'j', lazy.layout.decrease_ratio()),
    # kick to next/prev screen
    Key([mod], "o", lazy.function(kick_to_next_screen)),
    Key([mod, 'shift'], 'o', lazy.function(kick_to_next_screen, -1)),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    #Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),
    Key([mod, 'shift'], 'i', lazy.spawn('firefox')),
    Key([mod, 'shift'], 'Return', lazy.spawn('urxvt')),
    Key([mod], 'Return', lazy.spawn('termite')),
    Key([mod], 'l', lazy.spawn('xlock')),
    Key([], 'XF86Launch1', lazy.spawn('xlock')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer -D pulse set Master toggle')),
    #Key([], 'XF86AudioMicMute', lazy.spawn('amixer -D pulse set Master toggle')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer -c 0 -q set Master 2dB+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer -c 0 -q set Master 2dB-')),
    # Switch groups
    Key([], 'XF86Back', lazy.screen.prev_group(skip_managed=True, )),
    Key([], 'XF86Forward', lazy.screen.next_group(skip_managed=True, )),
    Key([mod], 'XF86Back', lazy.screen.prev_group(skip_managed=True, )),
    Key([mod], 'XF86Forward', lazy.screen.next_group(skip_managed=True, )),
    Key([mod], 'Left', lazy.screen.prev_group(skip_managed=True, )),
    Key([mod], 'Right', lazy.screen.next_group(skip_managed=True, )),
    Key([mod], 'Escape', lazy.screen.togglegroup()),
    # Toggle between different layouts as defined below
    Key([mod], 'space', lazy.next_layout()),
    Key([mod, 'shift'], 'space', lazy.prev_layout()),
    # lazy.group.setlayout('...
    Key([mod, 'shift'], 'BackSpace', lazy.window.kill()),
    # qtile maintenence
    Key([mod, 'shift'], 'r', lazy.restart()), # default is control! ;)
    Key([mod, 'shift'], 'q', lazy.shutdown()),
    #Key([mod], "d", lazy.spawn("rofi -show drun")),
    Key([mod], 'r', lazy.spawncmd()),
    ]

# create groups
groups = [Group(i) for i in '1234567890']
for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, 'shift'], i.name, lazy.window.togroup(i.name))
    )

# see http://docs.qtile.org/en/latest/manual/ref/layouts.html
layouts = [
    layout.Max(),
    layout.Floating(border_focus=color_alert, border_normal=color_frame, ),
    #layout.Matrix(),
    #layout.MonadTall(),
    #layout.RatioTile(),
    #layout.Slice(),
    #layout.Stack(num_stacks=2),
    layout.Tile(border_focus=color_alert, border_normal=color_frame, ),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
    ]

widget_defaults = dict(
    font='Sans',
    fontsize=16,
    )

class Backlight(widget.Backlight):
    def poll(self):
        info = self._get_info()
        if info is False:
            return '---'
        no = int(info['brightness'] / info['max'] * 9.999)
        char = '☼'
        #self.layout.colour = color_alert
        return '{}{}{}'.format(char, no, 'L')#chr(0x1F50B))

class Battery(widget.Battery):
    def _get_text(self):
        info = self._get_info()
        if info is False:
            return '---'
        if info['full']:
            no = int(info['now'] / info['full'] * 9.999)
        else:
            no = 0
        if info['stat'] == 'Discharging':
            char = self.discharge_char
            if no < 2:
                self.layout.colour = self.low_foreground
            else:
                self.layout.colour = self.foreground
        elif info['stat'] == 'Charging':
            char = self.charge_char
        #elif info['stat'] == 'Unknown':
        else:
            char = '■'
        return '{}{}{}'.format(char, no, 'B')#chr(0x1F506))

class ThermalSensor(widget.ThermalSensor):
    def poll(self):
        temp_values = self.get_temp_sensors()
        if temp_values is None:
            return '---'
        no = int(float(temp_values.get(self.tag_sensor, [0])[0]))
        return '{}{}'.format(no, '°')#chr(0x1F321))

class Volume(widget.Volume):
    def update(self):
        vol = self.get_volume()
        if vol != self.volume:
            self.volume = vol
            if vol < 0:
                no = '0'
            else:
                no = int(vol / 100 * 9.999)
            char = '♬'
            self.text = '{}{}{}'.format(char, no, 'V')#chr(0x1F508))

# see http://docs.qtile.org/en/latest/manual/ref/widgets.html
screens = [Screen(top=bar.Bar([
    widget.GroupBox(
        disable_drag=True,
        this_current_screen_border=color_frame,
        this_screen_border=color_frame,
        urgent_text=color_alert,
        ),
    widget.CurrentLayout(),
    widget.Prompt(),
    widget.TaskList(
        font='Nimbus Sans L',
        border=color_frame,
        highlight_method='block',
        max_title_width=800,
        urgent_border=color_alert,
        ),
    widget.Systray(),
    Backlight(),
    Battery(
        charge_char = u'▲',
        discharge_char = u'▼',
        low_foreground = color_alert,
        ),
    ThermalSensor(),
    Volume(),
    widget.CPUGraph(
        graph_color=color_alert,
        fill_color='{}.5'.format(color_alert),
        border_color=color_frame,
        line_width=2,
        border_width=1,
        samples=60,
        ),
    widget.MemoryGraph(
        graph_color=color_alert,
        fill_color='{}.5'.format(color_alert),
        border_color=color_frame,
        line_width=2,
        border_width=1,
        samples=60,
        ),
    widget.NetGraph(
        graph_color=color_alert,
        fill_color='{}.5'.format(color_alert),
        border_color=color_frame,
        line_width=2,
        border_width=1,
        samples=60,
        ),
    widget.Clock(
        format='%Y-%m-%d %H:%M %p',
        ),
    ], 32, ), ), ]

def detect_screens(qtile):
    while len(screens) < len(qtile.conn.pseudoscreens):
        screens.append(Screen(
        top=bar.Bar([
            widget.GroupBox(
                disable_drag=True,
                this_current_screen_border=color_frame,
                this_screen_border=color_frame,
                ),
            widget.CurrentLayout(),
            widget.TaskList(
                font='Nimbus Sans L',
                border=color_frame,
                highlight_method='block',
                max_title_width=800,
                urgent_border=color_alert,
                ),
            ], 32, ), ))

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
    ]

# subscribe for change of screen setup, just restart if called
@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    # TODO only if numbers of screens changed
    qtile.cmd_restart()

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=color_alert,
    border_normal=color_frame,
    float_rules=[dict(role='buddy_list', ), ],
    )
auto_fullscreen = True
# java app don't work correctly if the wmname isn't set to a name that happens to
# be on java's whitelist (LG3D is a 3D non-reparenting WM written in java).
wmname = 'LG3D'

def main(qtile):
    detect_screens(qtile)
