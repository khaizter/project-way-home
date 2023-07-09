import sys
def eval():
	try:
		ldict = {"researchers": {
		  "both": "Glenn",
		  "leadprog": "Khaizter",
		  "docu": "Joy"
		}}
		exec('''print(researchers["leadprog"])''',globals(),ldict)
		return ['Wrong value', False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))