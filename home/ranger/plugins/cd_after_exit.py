# This plugin reads dir from /tmp/picked and cd into that location
# https://github.com/ranger/ranger/issues/1554#issuecomment-491841267

from __future__ import absolute_import, division, print_function

import os
# import subprocess

import ranger.api
from ranger.ext.spawn import check_output


HOOK_INIT_OLD = ranger.api.hook_init


def hook_init(fm):
    def cd_after_eixt(signal):
        input_file='/tmp/picked'
        result=''
        # read the file directly, cause Popen doesn't spawn shells
        # No env vars could be expanded.
        if os.path.isfile(input_file):
            with open(input_file, 'r') as f:
                result = f.read().rstrip("\n")
            os.remove(input_file)

            if result and os.path.isdir(result):
                signal.origin.cd(result)

    fm.signal_bind("runner.execute.after", cd_after_eixt)
    return HOOK_INIT_OLD(fm)


ranger.api.hook_init = hook_init
