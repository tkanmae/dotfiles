#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Install all the dotfiles.

Create symlinks in `HOME` pointing to dotfiles in `TOP`.  Files and directories
with names starting with '.' are considered to be dotfiles.  Any dotfiles to be
ignored must be listed in a global variable `EXCLUDE`.  If any dotfiles already
exist in `HOME` and are not symlinks, they will be saved as their file names
appended with a ".orig".
"""
import argparse
import glob
import os

HOME = os.path.expandvars("$HOME")
HERE = os.path.abspath(os.path.dirname(__file__))


def is_exe(filename):
    return os.path.isfile(filename) and os.access(filename, os.X_OK)


def create_symlink(src, dst):
    if not os.path.exists(src):
        raise ValueError("File not found: %s" % src)

    if os.path.islink(dst):
        os.remove(dst)
    elif os.path.exists(dst):
        os.rename(dst, dst + ".orig")
    os.symlink(src, dst)


def create_symlinks(srcs, dsts, dryrun):
    num = max([len(os.path.relpath(_, HOME)) for _ in dsts])
    fmt = "{{0:<{0}s}} -> {{1}}".format(num + 2)

    def display(src, dst):
        print(
            fmt.format(
                "~/" + os.path.relpath(dst, HOME), "~/" + os.path.relpath(src, HOME)
            )
        )

    for src, dst in zip(srcs, dsts):
        display(src, dst)
        if not dryrun:
            create_symlink(src, dst)


def install_dotfiles(dotfiles, dryrun):
    srcs = [os.path.join(HERE, f) for f in dotfiles]
    dsts = [os.path.join(HOME, os.path.basename(f)) for f in dotfiles]
    create_symlinks(srcs, dsts, dryrun)


def install_binfiles(binfiles, dryrun):
    dst_dir = os.path.join(HOME, ".local/bin")
    if not os.path.isdir(dst_dir):
        os.makedirs(dst_dir)
    srcs = [os.path.join(HERE, f) for f in binfiles]
    dsts = [os.path.join(dst_dir, os.path.basename(f)) for f in binfiles]
    create_symlinks(srcs, dsts, dryrun)


def setup_argparser():
    parser = argparse.ArgumentParser()

    # Optional arguments
    parser.add_argument(
        "-n",
        "--dry-run",
        dest="dryrun",
        action="store_true",
        default=False,
        help="perform a trial run",
    )
    return parser


def main(args):
    excludes = [".git", ".gitignore", ".gitmodules", ".DS_Store"]
    dotfiles = sorted(glob.glob(".*"))
    dotfiles = sorted(list(set(dotfiles) - set(excludes)))

    print("dotfiles:")
    install_dotfiles(dotfiles, args.dryrun)
    print("")

    binfiles = [_ for _ in glob.glob("bin/*") if is_exe(_)]
    binfiles = sorted(binfiles)

    print("binfiles:")
    install_binfiles(binfiles, args.dryrun)


if __name__ == "__main__":
    parser = setup_argparser()
    main(parser.parse_args())
