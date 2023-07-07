import sys
def eval():
	try:
		ldict = {}
		exec('''for i in range(5):
	print(i)''',globals(),ldict)
		return ["You need to print 0-4", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))