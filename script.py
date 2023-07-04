import sys
def eval():
	try:
		ldict = {}
		exec('''name = "asdf"''',globals(),ldict)
		return [ldict['name'], True]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))