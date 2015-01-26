import urllib
import multiprocessing.dummy

p = multiprocessing.dummy.Pool(5)

def f(post):
    return urllib.urlopen('http://stackoverflow.com/questions/%u' % post)

def double(x):
    return x + x

#print p.map(f, range(3329361, 3329361 + 5))
print p.map(double,[1,2,3,4])
