#!/usr/bin/env python
 
import sys
 
for line in sys.stdin:
   line = line.strip()
   keys = line.split()
   for key in keys:
       value = 1
       k = key.lower()
       for c in "\".#,():;-_?!":
           k = k.replace(str(c),"")
       if (len(k) > 0):
           print( "%s\t%d" % (k, value) )

