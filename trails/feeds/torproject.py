#!/usr/bin/env python

"""
Copyright (c) 2020 NIDDS developers (https://github.com/prasanthc41m/nidds/)
See the file 'LICENSE' for copying permission
"""

from core.common import retrieve_content

__url__ = "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1"
__check__ = "185.220."
__info__ = "tor exit node (suspicious)"
__reference__ = "torproject.org"

def fetch():
    retval = {}
    content = retrieve_content(__url__)

    if __check__ in content:
        for line in content.split('\n'):
            line = line.strip()
            if not line or line.startswith('#') or '.' not in line:
                continue
            retval[line] = (__info__, __reference__)

    return retval
