from percol.finder import FinderMultiQueryMigemo, FinderMultiQueryRegex

# ------------------------------------------------------------------------------
# Keymap
# ------------------------------------------------------------------------------
# Emacs like
percol.import_keymap({
    "C-h": lambda percol: percol.command.delete_backward_char(),
    "C-d": lambda percol: percol.command.delete_forward_char(),
    "C-k": lambda percol: percol.command.kill_end_of_line(),
    "C-y": lambda percol: percol.command.yank(),
    "C-t": lambda percol: percol.command.transpose_chars(),
    "C-a": lambda percol: percol.command.beginning_of_line(),
    "C-e": lambda percol: percol.command.end_of_line(),
    "C-b": lambda percol: percol.command.backward_char(),
    "C-f": lambda percol: percol.command.forward_char(),
    "C-n": lambda percol: percol.command.select_next(),
    "C-p": lambda percol: percol.command.select_previous(),
    "C-v": lambda percol: percol.command.select_next_page(),
    "M-v": lambda percol: percol.command.select_previous_page(),
    "M-<": lambda percol: percol.command.select_top(),
    "M->": lambda percol: percol.command.select_bottom(),
    "C-m": lambda percol: percol.finish(),
    "C-j": lambda percol: percol.finish(),
    "C-c": lambda percol: percol.cancel(),
    "C-g": lambda percol: percol.command.toggle_case_sensitive(),
    "C-r": lambda percol: percol.command.toggle_finder(FinderMultiQueryRegex)
})

# ------------------------------------------------------------------------------
# View
# ------------------------------------------------------------------------------
def dynamic_prompt():
    prompt = ur""
    if percol.model.finder.__class__ == FinderMultiQueryMigemo:
        prompt += "[Migemo]"
    elif percol.model.finder.__class__ == FinderMultiQueryRegex:
        prompt += "[Regexp]"
    else:
        prompt += "[String]"
    if percol.model.finder.case_insensitive:
        prompt += "[a]"
    else:
        prompt += "[A]"
    prompt += "> %q"
    return prompt

percol.view.__class__.PROMPT = property(lambda self: dynamic_prompt())

percol.view.CANDIDATES_LINE_BASIC     =  ("on_default", "default")
percol.view.CANDIDATES_LINE_SELECTED  =  ("underline", "on_yellow", "white")
percol.view.CANDIDATES_LINE_QUERY     =  ("yellow", "bold")
