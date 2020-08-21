#!/usr/bin/env python

"""
Copyright (c) 2020 NIDDS developers (https://github.com/prasanthc41m/nidds/)
See the file 'LICENSE' for copying permission
"""

import re

from core.common import retrieve_content

__url__ = "https://cybercrime-tracker.net/ccam.php"
__check__ = "Atmos Strategic Monitoring"
__info__ = "atmos (malware)"
__reference__ = "cybercrime-tracker.net"

def fetch():
    retval = {}
    content = retrieve_content(__url__)

    if __check__ in content:
        for match in re.finditer(r">([^<]+\.[a-zA-Z]+)</td>\s*<td style=\"background-color: rgb\(11, 11, 11\);\"><a href=\"ccamdetail\.php\?hash=", content):
            retval[match.group(1)] = (__info__, __reference__)

    return retval
