with open("ruikeys", "r") as j:
	with open("ruikeys2", "w") as j2:
		for line in j.readlines():
			if len(line) < len("keycode  33 = p P p"):
				continue
			j2.write(line[:line.index('=')+2])
			line = line[line.index('=')+2:]
			print(line)
			j2.write(line[:line.index(' ')+1])
			line = line[line.index(' ')+1:]
			print(line)
			j2.write(line[:line.index(' ')+1])
			j2.write("\n")
			
