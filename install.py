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
from pathlib import Path

HOME = Path.home()
HERE = Path(__file__).parent.resolve()


def is_exe(filename):
    return Path(filename).is_file() and os.access(filename, os.X_OK)


def create_symlink(src, dst):
    src_path = Path(src)
    dst_path = Path(dst)

    if not src_path.exists():
        raise ValueError("File not found: %s" % src)

    if dst_path.is_symlink():
        dst_path.unlink()
    elif dst_path.exists():
        dst_path.rename(str(dst_path) + ".orig")
    dst_path.symlink_to(src_path)


def create_symlinks(srcs, dsts, dryrun):
    num = max([len(str(Path(_).relative_to(HOME))) for _ in dsts])
    fmt = "{{0:<{0}s}} -> {{1}}".format(num + 2)

    def display(src, dst):
        print(
            fmt.format(
                "~/" + str(Path(dst).relative_to(HOME)),
                "~/" + str(Path(src).relative_to(HOME)),
            )
        )

    for src, dst in zip(srcs, dsts):
        display(src, dst)
        if not dryrun:
            create_symlink(src, dst)


def install_dotfiles(dotfiles, dryrun):
    srcs = [HERE / f for f in dotfiles]
    dsts = [HOME / Path(f).name for f in dotfiles]
    create_symlinks(srcs, dsts, dryrun)


def install_binfiles(binfiles, dryrun):
    dst_dir = HOME / ".local/bin"
    if not dst_dir.is_dir():
        dst_dir.mkdir(parents=True, exist_ok=True)
    srcs = [HERE / f for f in binfiles]
    dsts = [dst_dir / Path(f).name for f in binfiles]
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
