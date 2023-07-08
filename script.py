import sys
def eval():
	try:
		ldict= {"name" : ""}
		exec('''name = "input-field"''',globals(),ldict)
		if ldict["name"] == "input-field":
			return ["Complete Form!", True]
		else:
			return ["Incomplete Form!", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))