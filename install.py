#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Install all the dotfiles.

Create symlinks in `HOME` pointing to dotfiles in `TOP`.  Files/directories that
have names starting with '.' are considered to be dotfiles.  Any dotfiles to be
ignored from the installation must be listed in a global variable `EXCLUDE`.  If
any of the dotfiles already exist in `HOME` and they are not symlinks, they will
be saved as their file names appended with a ".orig".
"""
import argparse
import glob
import os


TOP  = '.'
HOME = os.path.expandvars('$HOME')
CWD  = os.path.dirname(__file__)


EXCLUDE = ['.git', '.gitmodules', '.DS_Store']


class Installer(object):

    def __init__(self, dotfiles, excludes=None):
        if not isinstance(excludes, (list, set, tuple)):
            excludes = set(EXCLUDE)
        else:
            excludes = set(excludes) | EXCLUDE
        self._dotfiles = set(dotfiles) - excludes
        self._init_print_symlink()

    def run(self, is_dryrun):
        try:
            for f in self._dotfiles:
                self._create_symlink(f, is_dryrun)
        except ValueError, e:
            print e

    def _create_symlink(self, target, is_dryrun):
        src = os.path.join(TOP, target)
        if not os.path.exists(src):
            raise ValueError("File not found: {0}".format(src))
        dst = os.path.join(HOME, os.path.basename(src))

        self._print_symlink(src, dst)

        if not is_dryrun:
            if os.path.islink(dst):
                os.remove(dst)
            elif os.path.exists(dst):
                os.rename(dst, dst + '.orig')
            # Use a relative path for a symlink.
            os.symlink(os.path.relpath(src, HOME), dst)

    def _init_print_symlink(self):
        n = max([len(item) for item in self._dotfiles])
        fmt = "{{0:<{0}s}} -> {{1}}".format(n + 2)

        def _print(src, dst):
            print(fmt.format('~/' + os.path.relpath(dst, HOME),
                             '~/' + os.path.relpath(src, HOME)))

        self._print_symlink = _print


def setup_argparser():
    parser = argparse.ArgumentParser()

    # Optional arguments
    parser.add_argument('-n', '--dry-run', dest='dryrun',
                        action='store_true', default=False,
                        help="perform a trial run")
    return parser


def main():
    parser = setup_argparser()
    args = parser.parse_args()

    dotfiles = sorted(glob.glob('.*'))

    installer = Installer(dotfiles)
    installer.run(args.dryrun)


if __name__ == '__main__':
    main()
