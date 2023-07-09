import sys
def eval():
	try:
		ldict = {}
		exec('''mynameis = "khasd"''',globals(),ldict)
		return [ldict['mynameis'], True]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))