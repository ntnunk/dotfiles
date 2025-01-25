
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

from colors import Nord

mod = "mod1"
terminal = "kitty"

floating_layout = layout.Floating(
    border_focus=Nord[8],
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='confirmreset'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(title='branchdialog'),
        Match(title='pinentry'),
        Match(wm_class='ssh-askpass'),
        Match(title='Xephyr on :1.0 (ctrl+shift grabs mouse and keyboard)'),
        Match(title='Bitwarden'),
        Match(wm_class='nextcloud'),
        Match(wm_class='system-config-printer'),
        Match(wm_class='gnome-calculator'),
    ]
)

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_screen(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer sset Master,0 5%-')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer sset Master,0 5%+')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer sset Master,0 toggle')),
    Key([], 'XF86AudioPlay',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 '
            'org.mpris.MediaPlayer2.Player.PlayPause')),
    Key([], 'XF86AudioStop',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop')),
    Key([], 'XF86AudioNext',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next')),
    Key([], 'XF86AudioPrev',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous')),
    Key([mod], 'b', lazy.spawn('firefox')),
    Key([mod], 'd', lazy.spawn('rofi -show combi')),
    Key([mod], 'e', lazy.spawn('nautilus')),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(
                func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = []
group_names = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
group_labels = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
group_layouts = [
    'monadtall', 'monadtall', 'monadtall', 'monadtall', 'monadtall',
    'monadtall', 'monadtall', 'monadtall', 'monadtall', 'monadtall'
]
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i], layout=group_layouts[i].lower(),
            label=group_labels[i]
        )
    )

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

groups.append(
    ScratchPad(
        'scratchpad',
        [
            DropDown('term', 'kitty', width=0.6, height=0.6, x=0.2, y=0.15,
                     opacity=1),
            DropDown('mixer', 'pavucontrol', width=0.4, height=0.6, x=0.3,
                     y=0.1, opacity=1),
            DropDown('calc', 'gnome-calculator', width=0.2, height=0.6, x=0.3,
                     y=0.1, opacity=1)
        ]
    )
)
keys.extend([
    Key(['control'], '1', lazy.group['scratchpad'].dropdown_toggle('term')),
    Key(['control'], '2', lazy.group['scratchpad'].dropdown_toggle('mixer')),
    Key(['control'], '3', lazy.group['scratchpad'].dropdown_toggle('calc')),
])

layout_theme = {
    'border_width': 3,
    'margin': 10,
    'border_focus': Nord[8],
    'border_normal': Nord[7],
    'grow_amount': 4,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(border_focus_stack=[
                   "#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    layout.Floating(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=10,
    padding=3,
    background=Nord[0]
)
extension_defaults = widget_defaults.copy()

group_box_settings = {
    'padding': 5,
    'borderwidth': 3,
    'active': Nord[2],
    'inactive': Nord[1],
    'disable_drag': True,
    'rounded': True,
    'highlight_color': Nord[3],
    'block_highlight_text_color': Nord[3],
    'this_current_screen_border': Nord[5],
    'this_screen_border': Nord[0],
    'other_current_screen_border': Nord[6],
    'other_screen_border': Nord[6],
    'foreground': Nord[2],
    'background': Nord[6],
    'urgent_border': Nord[3],
    'on_mouse_wheel': False
}

powerline = {
    'decorations': [PowerLineDecoration(path='back_slash')]
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(
                    background=Nord[4], foreground=Nord[2], **powerline
                ),
                widget.GroupBox(**group_box_settings, **powerline),
                widget.WindowName(background=Nord[0], fontsize=16,
                                  **powerline),
                widget.Chord(
                    chords_color={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                    **powerline
                ),
                widget.CPU(background=Nord[4], **powerline),
                widget.Memory(background=Nord[6], measure_mem='G', **powerline),
                widget.Systray(background=Nord[7], **powerline),
                widget.Clock(foreground=Nord[0], background=Nord[8],
                             format="%Y-%m-%d %a %I:%M %p", **powerline),
                widget.QuickExit(),
            ],
            24,
            border_color=Nord[8],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,

    ),
    #Screen(
    #    top=bar.Bar(
    #        [
    #            widget.CurrentLayout(background=Nord[4],
    #                                 foreground=Nord[2]),
    #            widget.GroupBox(**group_box_settings),
    #            widget.Prompt(),
    #            widget.WindowName(foreground='e5b567', fontsize=16),
    #            widget.Chord(
    #                chords_color={
    #                    "launch": ("#ff0000", "#ffffff"),
    #                },
    #                name_transform=lambda name: name.upper(),
    #            ),
    #            widget.Clock(foreground='#d6d6d6',
    #                         format="%Y-%m-%d %a %I:%M %p"),
    #            widget.QuickExit(),
    #        ],
    #        24,
    #        border_color=Nord[8]
    #    )
    #)
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
