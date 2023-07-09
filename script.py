import sys
def eval():
	try:
		ldict = {"grocery" : ["depression", "adhd", "anxiety", "bipolar", "ptsd", "schizophrenia", "neurodevelopmental"]}
		exec('''print(grocery[2:6])''',globals(),ldict)
		return ["Wrong value", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))