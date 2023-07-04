import sys
def eval():
	try:
		ldict = {}
		exec('''print(1 +3)''',globals(),ldict)
		return ["default_output", True]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))