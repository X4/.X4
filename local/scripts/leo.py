#!/usr/bin/python
"""
Copyright (c) 2012 Christian Schick

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

"""
================================================================================
               leo - a german<->english language translation script
================================================================================
"""


################################################################################
# AUTHORSHIP INFORMATION
################################################################################
__author__     = "Christian Schick"
__copyright__  = "Copyright 2013, Christian Schick"
__license__    = "MIT"
__version__    = "1.2"
__maintainer__ = "Christian Schick"
__email__      = "github@simperium.de"

################################################################################

from BeautifulSoup import BeautifulSoup, Tag
from urllib2 import urlopen
import sys
from cgi import escape
from HTMLParser import HTMLParser

def getlang(td):
    """Returns the language attribute of a td tag."""
    lang = None
    for attr, value in td.attrs:
        if attr == "lang":
            lang = value
            break
    return lang

def istag(obj):
    """Tests if an object is an instance of BeautifulSoup.Tag."""
    return isinstance(obj, Tag)

def nospans(tag):
    """Checks that the given tag contains no <span> subtags."""
    spans = False
    for subtag in tag.contents:
        if istag(subtag):
            spans = subtag.name == "span"
        if spans:
            break
    return not spans

def get(search):
    mask = "http://dict.leo.org/ende?search=%s&lang=de"
    url = urlopen(mask % search.replace(" ", "+"))
    content = BeautifulSoup(url)
    p = HTMLParser()
    # all <td> tags with class="text" are results
    result = content.findAll("td", attrs={"class": "text"})
    outlines = []
    left = None
    right = None
    widest = 0
    # buffer hits in list for later string formatting
    for i in range(0, len(result), 2):
        # hits are already organized in a left/right manner
        # drop lines containing <span> tags - they are for orthographic similar
        # words - we don't want them
        # also don't process line on out of bouns error
        if nospans(result[i]) and nospans(result[i + 1]) and i < len(result)-1:
            c = result[i].contents
            left = "".join(p.unescape(x.text if istag(x) else x) for x in c)
            c = result[i + 1].contents
            right = "".join(p.unescape(x.text if istag(x) else x ) for x in c)
            left = left.strip()
            right = right.strip()
            if len(left) > widest:
                widest = len(left)
            outlines.append((left, right))
    widest = max(len(x[0]) for x in outlines)

    print "\n".join(
            x + (" " * (widest - len(x))) + " -- " + y for x, y in outlines)

################################################################################

def main_entry():
    if len(sys.argv) < 2:
        print "Missing keywords"
        sys.exit(255)
    get("+".join(
        escape(x).encode('ascii', 'xmlcharrefreplace') for x in sys.argv[1:]))

################################################################################

if __name__ == "__main__":
    sys.exit(main_entry())
