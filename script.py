import sys
def eval():
	try:
		ldict = {}
		exec('''def topbrand(brand):
  print(brand + "Corporation")

topbrand("nestle")
topbrand("purefoods")
''',globals(),ldict)
		return["Make topbrand function.", False]
	except Exception as error:
		return [type(error).__name__ + '-' + str(error),False]
res = eval()
sys.stdout.write(res[0] + '^' + str(res[1]))