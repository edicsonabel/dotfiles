# Copyright (c) 2010 Aldo Cortesi
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

##### IMPORTS #####
import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401

##### DEFINING SOME VARIABLES #####
mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
editorCode="subl"
fileManager="nemo"
videoPlayer="vlc"
browser="google-chrome-stable"
appsManager="rofi -show drun"
myTerm = "gnome-terminal"                                 # My terminal of choice
myConfig = "/home/edicsonabel/.config/qtile/config.py"    # The Qtile config file location

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(myTerm)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),

    # Personal
    Key([mod], "e", lazy.spawn(fileManager)),
    Key([mod, "control"], "Return", lazy.spawn(editorCode)),
    Key([mod, "control"], "g", lazy.spawn(browser)),
    Key([mod, "control"], "v", lazy.spawn(videoPlayer)),
    Key([mod, "control"], "space", lazy.spawn(appsManager)),

    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),

    # Screen
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    Key([], "Print", lazy.spawn("gnome-screenshot")),
    Key(["shift"], "Print", lazy.spawn("gnome-screenshot -a")),
    Key(["mod1", "shift"], "space", lazy.spawn("togglekb")),

]

##### GROUPS #####
group_names = [("WEB", {'layout': 'max'}),
               ("DEV", {'layout': 'monadtall'}),
               ("DOC", {'layout': 'max'}),
               ("VID", {'layout': 'max'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

##### COLORS #####
colors = [["#222222", "#222222"], # 0 panel background
          ["#BBBBBB", "#BBBBBB"], # 1 background for current screen tab
          ["#ffffff", "#ffffff"], # 2 font color for group names
          ["#444444", "#444444"], # 3 background color for layout widget
          ["#BF0000", "#BF0000"], # 4 dark gradiant for other screen tabs
          ["#FFFF00", "#FFFF00"]] # 5 background color for pacman widget

##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {"border_width": 2,
                "margin": 5,
                "border_focus": "#BF0000",
                "border_normal": "#222222"
                }          

##### THE LAYOUTS #####
layouts = [
    # layout.Stack(num_stacks=2),
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    #layout.Floating(**layout_theme)
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.TreeTab(
         # font = "Ubuntu",
         fontsize = 12,
         sections = ["Primero", "Segundo"],
         section_fontsize = 12,
         bg_color = colors[0],
         active_bg = colors[4],
         active_fg = colors[2],
         inactive_bg = colors[3],
         inactive_fg = colors[2],
         padding_y = 5,
         section_top = 10,
         panel_width = 320
         )
]          

##### PROMPT #####
prompt = "{0}: ".format(os.environ["USER"])
  
##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="sans",
    # font="DejaVu Sans Mono",
    # font="Ubuntu Mono",
    fontsize = 12,
    padding = 0,
    background = colors[2]
)
extension_defaults = widget_defaults.copy()

##### WIDGETS #####

def init_widgets_list():
    widgets_list = [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.GroupBox(
                        font="sans",
                        fontsize = 10,
                        # font="DejaVu Sans Mono for Powerline Bold",
                        # margin_y = 0,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 1,
                        active = colors[2],
                        inactive = colors[1],
                        rounded = False,
                        highlight_method = "block",
                        this_current_screen_border = colors[3],
                        this_screen_border = colors [4],
                        other_current_screen_border = colors[0],
                        other_screen_border = colors[0],
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="sans",
                        # font="DejaVu Sans Mono for Powerline",
                        padding=5,
                        foreground = colors[5],
                        background = colors[0]
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.WindowName(
                        foreground = colors[2],
                        background = colors[0],
                        padding=10,
                        ),
               widget.TextBox(
                        text="",
                        background = colors[3],
                        foreground = colors[0],
                        fontsize=20
                        ),
               widget.TextBox(
                        text="🤔 ",
                        foreground=colors[2],
                        background=colors[3],
                        fontsize=14
                        ),
               widget.Memory(
                        foreground = colors[2],
                        background = colors[3],
                        update_interval=0.5,
                        format='{MemUsed}M'
                        ),
               widget.TextBox(
                        text="",
                        background = colors[4],
                        foreground = colors[3],
                        fontsize=20
                        ),
               widget.TextBox(
                        text="🌎 ",
                        foreground=colors[2],
                        background=colors[4],
                        fontsize=14
                        ),
               widget.Net(
                        interface = "wlp7s0",
                        foreground = colors[2],
                        background = colors[4],
                        update_interval=0.5,
                        format='{up} ↑↓ {down}'
                        ),
               widget.TextBox(
                        text="",
                        background = colors[3],
                        foreground = colors[4],
                        fontsize=20
                        ),
               widget.TextBox(
                        text="💡",
                        foreground=colors[2],
                        background=colors[3],
                        fontsize=14
                        ),
               widget.Backlight(
                        # backlight_name="intel_backlight",
                        backlight_name="acpi_video0",
                        foreground=colors[2],
                        background=colors[3]
                        ),
               widget.Cmus(
                        max_chars = 40,
                        update_interval = 0.5,
                        background=colors[3],
                        play_color = colors[2],
                        noplay_color = colors[2]
                        ),    
           widget.TextBox(
                        text="",
                        background = colors[4],
                        foreground = colors[3],
                        padding=0,
                        fontsize=20
                        ),
               widget.TextBox(
                        text="🔊",
                        foreground=colors[2],
                        background=colors[4],
                        fontsize=14
                        ),
               widget.Volume(
                        foreground = colors[2],
                        background = colors[4],
                        volume_app="pavucontrol",
                        step=1
                        ),
           widget.TextBox(
                        text="",
                        background = colors[3],
                        foreground = colors[4],
                        fontsize=20
                        ),
               widget.TextBox(
                        text="🔍 ",
                        foreground=colors[2],
                        background=colors[3],
                        fontsize=14
                        ),
               widget.CurrentLayout(
                        foreground = colors[2],
                        background = colors[3],
                        ),
               widget.TextBox(
                        text="",
                        background = colors[4],
                        foreground = colors[3],
                        fontsize=20
                        ),
               widget.TextBox(
                        text="🕒 ",
                        foreground=colors[2],
                        background=colors[4],
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[4],
                        format="%a, %d de %B %H:%M:%S"
                        ),
               widget.TextBox(
                        text="",
                        background = colors[0],
                        foreground = colors[4],
                        fontsize=20
                        ),
               widget.Systray(
                        background=colors[0],
                        )
              ]
    return widgets_list

##### SCREENS ##### (TRIPLE MONITOR SETUP)

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.95, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

##### STARTUP APPLICATIONS #####
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
