if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
else
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#source('file/rec', 'matchers',
      \ ['matcher/fruzzy', 'matcher_ignore_globs'])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#map('normal', '<C-j>',
      \ '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-k>',
      \ '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-j>',
      \ '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>',
      \ '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<BS>',
      \ '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-h>',
      \ '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-s>',
      \ '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 's',
      \ '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-v>',
      \ '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'v',
      \ '<denite:do_action:vsplit>', 'noremap')

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', [
      \ '.git/', '.svn/', '.hg/',
      \ '*.bmp', '*.gif', '*.jpeg', '*.jpg', '*.png', '*.tif', '*.webp',
      \ '*.o', '*.a', '*.exe', 'build/', '*.bak', '*~', 'tags',
      \ '__pycache__/', '.pytest_cache/', '*.pyc', '*.pyo',
      \ '.DS_Store'
      \ ])
