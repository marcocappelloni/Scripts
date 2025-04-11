# Define the widget configurations in this file

from libqtile import widget, bar
from libqtile.config import Screen
from .colors import colors
from .keys import my_terminal


def my_separator():
    return widget.Sep(
            foreground = colors["color7"],
            linewidth = 2,
            padding = 10,
            size_percent = 70
    )

def my_spacer():
    return widget.Spacer(length = 10)



def my_groupBox(screenNum):
    mybox=widget.GroupBox(
         highlight_method = "border",
         hide_unused = False,
         margin_y = 5,
         margin_x = 5,
         padding_y = 0,
         padding_x = 1,
         borderwidth = 2,
         active = colors["color2"],
         inactive = colors["color8"],
         rounded = False,
         this_current_screen_border = colors["color4"],
         this_screen_border = colors["color7"],
         other_current_screen_border = colors["color4"],
         other_screen_border = colors["color15"],
    )
    if screenNum == 0:
        mybox.visible_groups=['1','3','5','7','9']
    else:
        mybox.visible_groups=['2','4','6','8']
        
    return mybox


widget_defaults = dict(
    font='sans',
    fontsize=14,
    padding=3,
    background=colors["background"]
)

extension_defaults = widget_defaults.copy()

def init_widgets_list(screenNum):
    widgets_list = [
        widget.Image(
                 filename = "~/.config/conky/images/arcolinux-64x64.png",
                 scale = "False",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_terminal)},
        ),
        widget.Prompt(
                 font = "Ubuntu Mono",
                 foreground = colors["color1"]
        ),
        my_groupBox(screenNum),
        my_separator(),
        widget.CurrentLayoutIcon(
                 # custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                 foreground = colors["color1"],
                 padding = 4,
                 scale = 0.6
        ),
        widget.CurrentLayout(
                 foreground = colors["color1"],
                 padding = 5
        ),
        my_separator(),
        widget.CurrentScreen(
                active_color = colors["color2"],
                inactive_color = colors["color1"]
        ),
        my_separator(),
        widget.Spacer(),
        widget.WindowName(
                 foreground = colors["color6"],
                 max_chars = 40
        ),
        widget.Spacer(),
        widget.CPU(
                 format = '▓  Cpu: {load_percent}%',
                 foreground = colors["color4"],
        ),
        my_spacer(),
        widget.Memory(
                 foreground = colors["color5"],
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_terminal + ' -e htop')},
                 format = '{MemUsed: .0f}{mm}',
                 fmt = '🖥  Mem: {} used',
        ),
        my_spacer(),
        widget.DF(
                 update_interval = 60,
                 foreground = colors["color4"],
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_terminal + ' -e df')},
                 partition = '/',
                 format = '{uf}{m} free',
                 fmt = '🖴  Disk: {}',
                 visible_on_warn = False,
        ),
        my_spacer(),
        widget.Volume(
                 foreground = colors["color5"],
                 fmt = '🕫  Vol: {}',
        ),
        my_spacer(),
        widget.Clock(
                 foreground = colors["color4"],
                 format = "⏱  %a, %b %d - %H:%M",
        ),
        my_spacer(),
        widget.Systray(padding = 3),
        my_spacer(),
        ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list(0)
    del widgets_screen1[11:23]
    widgets_screen1.append(widget.Spacer(length = 750))
    return widgets_screen1 


# All other monitors' bars will display everything but widgets 22 (systray) and 23 (spacer).
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list(1)
    return widgets_screen2


screens = [
    Screen(
        top=bar.Bar(
            widgets=init_widgets_screen1(),
            size=24,  # Adjust this value according to your preference
            border_width=1,
            margin=[5, 10, 0, 10],
            border_color=colors["color7"],
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=init_widgets_screen2(),
            size=24,  # Adjust this value according to your preference
            border_width=1,
            margin=[5, 10, 0, 10],
            border_color=colors["color7"],
        ),
    )
]

