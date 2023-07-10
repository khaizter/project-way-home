import sys
def eval():
	try:
		ldict= {"bookdict": {
		  "pages": 69,
		  "quality": "mint",
		  "price": 420
		}}
		exec('''print(bookdict["quality"])''',globals(),ldict)
		return ['Wrong value', False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))