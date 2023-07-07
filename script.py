import sys
def eval():
	try:
		ldict = {}
		exec('''def download():
	return "files"''',globals(),ldict)
		if ldict['download']() == 'files':
			return ["Files retrieved.", True]
		else:
			return ["Make a download function.", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))