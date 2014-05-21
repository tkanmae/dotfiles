#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Add the top directory of a git-managed project to `sys.path`."""
import os
import shlex
import subprocess
import sys


cmd = 'git rev-parse --show-toplevel'

with open(os.devnull, 'wb') as DEVNULL:
    proc = subprocess.Popen(shlex.split(cmd), stderr=DEVNULL,
                            stdout=subprocess.PIPE)
    stdout, _ = proc.communicate()
    if proc.returncode == 0:
        sys.path.insert(0, stdout.strip())
