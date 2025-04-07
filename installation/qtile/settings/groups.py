# Define the groups (workspaces) in this file.

from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, keys


groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]

group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]
#group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX",]
#group_labels = ["", "", "", "", "", "", "", "", "",]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

group_screen_affinity = [0,1,0,1,0,1,0,1,0,]

def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        if name in '13579':
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.current_window.togroup(name, switch_group=True)
            return

        if name in "13579":
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
            screen_affinity=group_screen_affinity[i],
            init=True,
            persist=True,
        )
    )

for g in groups:
    keys.extend(
        [
            # variables.mod + letter of group = switch to group
            Key(
                [mod],
                g.name,
#                lazy.group[g.name].toscreen(),
                lazy.function(go_to_group(g.name)),
                desc="Switch to group {}".format(g.name),
            ),
            # variables.mod + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                g.name,
 #               lazy.window.togroup(g.name, switch_group=False),
                lazy.function(go_to_group_and_move_window(g.name)),
                desc="Move focused window to group {}".format(g.name),
            ),
        ]
    )
