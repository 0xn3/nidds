#!/usr/bin/env python

"""
Copyright (c) 2020 NIDDS developers (https://github.com/prasanthc41m/nidds/)
See the file 'LICENSE' for copying permission
"""

class AttribDict(dict):
    def __getattr__(self, name):
        return self.get(name)

    def __setattr__(self, name, value):
        self[name] = value