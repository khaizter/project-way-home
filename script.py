import sys
def eval():
	try:
		ldict = {"s" : 10, "difference" : 0}
		exec('''difference = s - 3''',globals(),ldict)
		if ldict["difference"] == 7:
			return ["Correct Calculation!", True]
		else:
			return ["Incorrect Calculation!", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))