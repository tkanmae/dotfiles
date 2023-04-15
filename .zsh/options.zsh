# General
# Combine zero-length punctuation characters (accents) with the base character.
setopt COMBINING_CHARS
# Enable comments in interactive shell.
setopt INTERACTIVE_COMMENTS
# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt RC_QUOTES
# Don't print a warning message if a mail file has been accessed.
unsetopt MAIL_WARNING

# Jobs
# List jobs in the long format by default.
setopt LONG_LIST_JOBS
# Attempt to resume existing job before creating a new process.
setopt AUTO_RESUME
# Report status of background jobs immediately.
setopt NOTIFY
# Don't run all background jobs at a lower priority.
unsetopt BG_NICE
# Don't kill jobs on shell exit.
unsetopt HUP
# Don't report on jobs when shell exit.
unsetopt CHECK_JOBS

# Directories
# Auto changes to a directory without typing cd.
setopt AUTO_CD
# Push the old directory onto the stack on cd.
setopt AUTO_PUSHD
# Do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT
# Push to home directory when no argument is given.
setopt PUSHD_TO_HOME
setopt CDABLE_VARS
# Try to expand the argument as if were preceded by a '~'.
setopt AUTO_NAME_DIRS
# Write to multiple descriptors.
setopt MULTIOS
# Enable extended globbing syntax.
setopt EXTENDED_GLOB
# Do not overwrite existing files with > and >>.
unsetopt CLOBBER

# History
HISTFILE=${HOME}/.zsh_history
# Maximum number of entries to keep in the history file.
SAVEHIST=10000
# Maximum number of entries to keep in memory.
HISTSIZE=10000
# Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write the history file in the ':start:elapsed;command' format.
setopt EXTENDED_HISTORY
# Add new command lines as soon as entered.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Expire a duplicate entry first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# Remove an old entry from the history list, when a new one being added duplicates an older one.
setopt HIST_IGNORE_ALL_DUPS
# Do not show duplicates of a commend line.
setopt HIST_FIND_NO_DUPS
# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE
# Do not write a duplicate entry to the history file.
setopt HIST_SAVE_NO_DUPS
# Do not execute immediately upon history expansion.
setopt HIST_VERIFY
# Beep when accessing non-existent history.
setopt HIST_BEEP
# Remove superfluous blanks from each entry.
setopt HIST_REDUCE_BLANKS
