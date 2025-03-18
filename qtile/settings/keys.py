# Define the key bindings in this file
from libqtile.lazy import lazy
from libqtile.config import Key, KeyChord
#from groups import groups
#from variables import variables

my_terminal = 'kitty'
my_browser1 = 'brave'
my_browser2 = 'chromium'
my_browser3 = 'firefox'
my_file_manager = 'thunar'
my_mail_client = 'thunderbird'
mod = 'mod4'

keys = [
    # The essentials
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    Key([mod], "n", lazy.screen.next_group(), desc="Change focused group to the next one"),
    Key([mod], "b", lazy.screen.prev_group(), desc="Change focused group to the prev one"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating window"),
    Key([mod], "m", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen window"),
    
    # Switch between windows
    # Some layouts like 'monadtall' only need to use j/k to move
    # through the stack, but other layouts like 'columns' will
    # require all four directions h/j/k/l to move around.
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        lazy.layout.move_left().when(layout=["treetab"]),
        desc="Move window to the left/move tab left in treetab"),

    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        lazy.layout.move_right().when(layout=["treetab"]),
        desc="Move window to the right/move tab right in treetab"),

    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down().when(layout=["treetab"]),
        desc="Move window down/move down a section in treetab"
    ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up().when(layout=["treetab"]),
        desc="Move window downup/move up a section in treetab"
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Treetab prompt
    # Key([variables.mod, "shift"], "a", add_treetab_section, desc='Prompt to add new section in treetab'),

    # Grow/shrink windows left/right. 
    # This is mainly for the 'monadtall' and 'monadwide' layouts
    # although it does also work in the 'bsp' and 'columns' layouts.
    Key([mod], "equal",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),
    Key([mod], "minus",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"
    ),

    # Grow windows up, down, left, right.  Only works in certain layouts.
    # Works in 'bsp' and 'columns' layout.
    #Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    #Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    #Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    #Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    #Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    #Key([mod], "m", lazy.layout.maximize(), desc='Toggle between min and max sizes'),
    #Key([mod], "t", lazy.window.toggle_floating(), desc='toggle floating'),

    # Switch focus of monitors
    Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),
    Key([mod], "Left", 
        lazy.window.toscreen(0),
        lazy.to_screen(0),
        desc="Send group to screen 0 and focus on that"
    ),
    Key([mod], "Right", 
        lazy.window.toscreen(1),
        lazy.to_screen(1),
        desc="Send group to screen 1 and focus on that"
    ),

  # Dmenu/rofi scripts launched using the key chord SUPER+p followed by 'key'
  #  KeyChord([mod], "p", [
  #      Key([], "h", lazy.spawn("dm-hub -r"), desc='List all dmscripts'),
  #      Key([], "a", lazy.spawn("dm-sounds -r"), desc='Choose ambient sound'),
  #      Key([], "b", lazy.spawn("dm-setbg -r"), desc='Set background'),
  #      Key([], "c", lazy.spawn("dtos-colorscheme -r"), desc='Choose color scheme'),
  #      Key([], "e", lazy.spawn("dm-confedit -r"), desc='Choose a config file to edit'),
  #      Key([], "i", lazy.spawn("dm-maim -r"), desc='Take a screenshot'),
  #      Key([], "k", lazy.spawn("dm-kill -r"), desc='Kill processes '),
  #      Key([], "m", lazy.spawn("dm-man -r"), desc='View manpages'),
  #      Key([], "n", lazy.spawn("dm-note -r"), desc='Store and copy notes'),
  #      Key([], "o", lazy.spawn("dm-bookman -r"), desc='Browser bookmarks'),
  #      Key([], "p", lazy.spawn("rofi-pass"), desc='Logout menu'),
  #      Key([], "q", lazy.spawn("dm-logout -r"), desc='Logout menu'),
  #      Key([], "r", lazy.spawn("dm-radio -r"), desc='Listen to online radio'),
  #      Key([], "s", lazy.spawn("dm-websearch -r"), desc='Search various engines'),
  #      Key([], "t", lazy.spawn("dm-translate -r"), desc='Translate text')
  #  ])
]
