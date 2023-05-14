import sys
def eval():
	try:
		ldict = {}
		return ldict['name']
	except Exception as error:
		return type(error).__name__
		# return type(error).__name__
# sys.stdout.write(eval())
print(eval())