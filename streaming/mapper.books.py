#!/usr/bin/env python
 
import sys
 
for line in sys.stdin:
   line = line.strip()
   items = line.split(';')
   print( "%s\t%d" % (items[3], 1) )

