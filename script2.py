import sys

def eval():
  
  try:
    # insert user code here
    

    # insert code check here
    passed = False
    if name != '':
      passed = True
    return str(passed)
  except:
    return "Invalid Syntax"

sys.stdout.write(eval())