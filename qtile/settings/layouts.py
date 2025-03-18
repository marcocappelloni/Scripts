# Define the layouts configurations in this file

from libqtile import layout
from libqtile.config import Match
from .colors import colors

layout_theme = {"border_width": 3,
                "margin": 8,
                "border_focus": colors["color4"],
                "border_normal": colors["color0"]
                }

layouts = [
    layout.Max(
        border_width = 0,
         margin = 0,
        ),
    layout.MonadTall(**layout_theme),
    layout.Stack(num_stacks=2),
    # Add more layouts if needed
]

# The default floating layout to use. See the configuration file for the default float_rules.
floating_layout = layout.Floating(
	border_focus=colors["color4"],
    border_width=2,
	float_rules=[
		# Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),   # gitk
        Match(wm_class="dialog"),         # dialog boxes
        Match(wm_class="download"),       # downloads
        Match(wm_class="error"),          # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class='kdenlive'),       # kdenlive
        Match(wm_class="makebranch"),     # gitk
        Match(wm_class="maketag"),        # gitk
        Match(wm_class="notification"),   # notifications
        Match(wm_class='pinentry-gtk-2'), # GPG key password entry
        Match(wm_class="ssh-askpass"),    # ssh-askpass
        Match(wm_class="toolbar"),        # toolbars
        Match(wm_class="Yad"),            # yad boxes
        Match(title="branchdialog"),      # gitk
        Match(wm_class='Galculator'),
        Match(wm_class='Arandr'),
        Match(wm_class='feh'),
        Match(wm_class='Arcolinux-welcome-app.py'),
        Match(wm_class='confirm'),
        #Match(title='Confirmation'),      # tastyworks exit box
        #Match(title='Qalculate!'),        # qalculate-gtk
        Match(title="pinentry"),          # GPG key password entry
        #Match(title="tastycharts"),       # tastytrade pop-out charts
        #Match(title="tastytrade"),        # tastytrade pop-out side gutter
        #Match(title="tastytrade - Portfolio Report"), # tastytrade pop-out allocation
        #Match(wm_class="tasty.javafx.launcher.LauncherFxApp"), # tastytrade settings
	])
