import sys
def eval():
	try:
		ldict = { "name" : "get_name"}
		exec('''print(name)''',globals(),ldict)
		return ["You need to print your name!", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))