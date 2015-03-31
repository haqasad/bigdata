def countup(n):
	for i in range(0,n):
		yield i
		
print list(countup(10))


