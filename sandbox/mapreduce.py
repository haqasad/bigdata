import multiprocessing.dummy
p = multiprocessing.dummy.Pool(6)

x="""
adksfjdhglrtawjdfkslj
dfsdsgafgdgwwwdvs
jfsdjkughsdksjhfkljdh
fkjsdkfjwlghblkdjhsdf
jksdfhkjfkldjfhl
akjhalkjswfwrwfwggfsgf
lkdfjgoksdjsfhskjdf
jkdkbvsfwffjwwiueiw
ldkflnornnfowanejb
apajgjegrjrgfgfasgas
sdfdfgfdgfdgdfgsg
sdfdfsdf
sgghgfhddhdhdhfjarwffgd
ddhggehefhdfhdh
dgdhedfsfgdhdhgh
dhsgsfeshtdfdbhsghsdhsdhg
dfgdfgeefdgfdhdghdsh
dhdhshsergefhghsfh
"""

x = x.strip().split()

def mapper(s): # string -> [(key value)]
	pairs = []
	for c in s:
		pairs.append((c,1))
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
