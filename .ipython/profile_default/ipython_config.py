c = get_config()

c.InteractiveShellApp.exec_lines = [
    'from __future__ import division',
]
c.InteractiveShellApp.extensions = ['autoreload']
c.TerminalInteractiveShell.colors = 'Linux'
c.PromptManager.in_template = '{color.Yellow}\Y5\n{color.Green}In [\\#]: '
c.TerminalInteractiveShell.multiline_history = True
