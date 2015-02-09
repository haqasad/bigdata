import multiprocessing.dummy
p = multiprocessing.dummy.Pool(6)

f = open("alice.txt","r")
x = f.read()
x = x.strip().split('\n')

def mapper(s): # string -> [(key value)]
	pairs = []
	for w in s.split(" "):
                w = w.lower().strip()
                if not w == '':
		    pairs.append((w,1))
	return pairs

def combiner(pairs):
	index = {}
	for (key,value) in pairs:
		if not index.has_key(key):
			index[key] = value
		else:
			index[key] = index[key] + value
	pairs = []
	for key in index:
		pairs.append((key,index[key]))
	return pairs

def reducer(data):
	index = {}
	for pairs in data:
		for (key,value) in pairs:
			if not index.has_key(key):
				index[key] = value
			else:
				index[key] = index[key] + value
	pairs = []
	for key in index:
		pairs.append((key,index[key]))
	return pairs

#pairs = mapper(x[0])
#print pairs

#pairs = combiner(pairs)
#print pairs

#pairs = reducer([pairs,pairs])
#print pairs

data = p.map(mapper,x)

data = p.map(combiner,data)

print reducer(data)
