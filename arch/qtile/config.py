# This file will serve as the entry point and will import and combine all the other configuration files.
# Import necessary modules
import os
import subprocess
from libqtile.utils import send_notification
from libqtile import hook

from settings.groups import groups
from settings.keys import mod, keys
from settings.mouse import mouse
from settings.layouts import layouts, floating_layout
from settings.colors import colors
from settings.widgets import widget_defaults, extension_defaults, screens

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])
    pass


# Set this to false if you only want windows to be fullscreen if you ask them to be.
auto_fullscreen = True

# When clicked, should the window be brought to the front or not. If this is set to "floating_only", only floating windows will get affected.
bring_front_click = False

# If true, the cursor follows the focus as directed by the keyboard, warping to the center of the focused window.
cursor_warp = False

# A function which generates group binding hotkeys. A sample implementation is available in libqtile/dgroups.py called simple_key_binder(), which will bind groups to mod+shift+0-10 by default.
dgroups_key_binder = None

# A list of Rule objects which can send windows to various groups based on matching criteria.
dgroups_app_rules = []

# Floating windows are kept above tiled windows
floats_kept_above = True

# Behavior of the _NET_ACTIVATE_WINDOW message sent by applications
#    urgent: urgent flag is set for the window
#    focus: automatically focus the window
#    smart: automatically focus if the window is in the current group
#    never: never automatically focus any window that requests it
focus_on_window_activation = 'smart'

# Controls whether or not focus follows the mouse around as it moves across windows in a layout.
follow_mouse_focus = False

# Controls whether or not to automatically reconfigure screens when there are changes in randr output configuration.
reconfigure_screens = True

# Gasp! We're lying here. In fact, nobody really uses or cares about this string besides java UI toolkits; 
# you can see several discussions on the mailing lists, GitHub issues, and other WM documentation that suggest 
# setting this string if your java app doesn't work correctly. We may as well just lie and say that we're a 
# working one by default. We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in java that 
# happens to be on java's whitelist.
wmname = 'LG3D'

# If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
auto_minimize = True 

