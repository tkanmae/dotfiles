c = get_config()

c.InteractiveShellApp.exec_lines = [
    'from __future__ import division',
]
c.InteractiveShellApp.extensions = ['autoreload']
c.TerminalInteractiveShell.colors = 'Linux'
c.PromptManager.in_template = '{color.Yellow}\Y5\n{color.Green}In [\\#]: '

try:
    import msgpack
except ImportError:
    pass
else:
    c.Session.packer = 'msgpack.packb'
    c.Session.unpacker = 'msgpack.unpackb'
