# qute://help/img/cheatsheet-big.png
config.load_autoconfig()

# configuration
config.set ("window.hide_decoration", True)

# https://www.qutebrowser.org/doc/help/settings.html#bindings.commands
config.bind('H', 'tab-prev')
config.bind('L', 'tab-next')

config.bind('m', 'hint')
config.bind('M', 'hint all tab')

config.bind('<alt+Left>', 'back')
config.bind('<alt+Right>', 'forward')

config.bind('<ctrl+h>', ':history')
config.bind('<ctrl+shift+n>', ':open --private')