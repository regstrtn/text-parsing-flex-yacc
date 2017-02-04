import os
import sys
import subprocess

filestodelete = os.listdir("./databaseinp")
for delete in filestodelete:
  os.remove("./databaseinp/"+delete)

fac = os.listdir('./fac')
for f in fac:
	subprocess.call(['./ex1',f])
