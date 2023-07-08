import sys
def eval():
	try:
		ldict = {"id" : "not present", "keycard" : "present",  "open" : False}
		exec('''if id == "present" or keycard == "present":
	open = True''',globals(),ldict)
		if ldict["open"] == True:
			return ["Correct Condition!", True]
		else:
			return ["Incorrect Condition!", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))