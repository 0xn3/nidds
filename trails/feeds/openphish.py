#!/usr/bin/env python

"""
Copyright (c) 2020 NIDDS developers (https://github.com/prasanthc41m/nidds/)
See the file 'LICENSE' for copying permission
"""

import re

from core.common import retrieve_content

__url__ = "https://openphish.com/feed.txt"
__check__ = "http://"
__info__ = "phishing"
__reference__ = "openphish.com"

def fetch():
    retval = {}
    content = retrieve_content(__url__)

    if __check__ in content:
        for line in content.split('\n'):
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '://' in line:
                line = re.search(r"://(.*)", line).group(1)
            line = line.rstrip('/')
            retval[line] = (__info__, __reference__)

    return retval
