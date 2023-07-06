import sys
def eval():
	try:
		ldict = {}
		exec('''def upload():
	print("malware")''',globals(),ldict)
		ldict['upload']()
		return ["Make an upload function.", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))