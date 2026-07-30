import json
from pathlib import Path
import sys

here = Path(__file__)
o = here.parent / "geysers.json"

with open(o) as f:
    j = json.load(f)

name = sys.argv[1:]
name = " ".join(name)
name = name.lower()

namelen = len(name)

l = []

for g in j["geysers"]:
    n = g["name"]
    section = n[:namelen]
    if section == name:
        l.append([n, g["id"]])

if len(l) == 0:
    print("no matches found")
    print("-1")
elif len(l) > 1:
    print("multiple matches found, please select:")
    for g in range(len(l)):
        print(f"{g + 1}: {l[g][0]}")
    x = input()
    try:
        x = int(x)
    except ValueError:
        print("not an integer")
        print("-1")
        exit()
    x = x - 1
    if x >= len(l) or x < 0:
        print("x out of range")
        print("-1")
        exit()
    #print(l[x][1])
else:
    print(l[0][1])
