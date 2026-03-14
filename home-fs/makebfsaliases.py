import os

chars = ["h", "r", "f", "t", "i", "s", "d"]
list = []

for c1 in chars:
    list.append(f'alias bfs{c1}="source bfs_base -{c1}"')
    for c2 in chars:
        if c2 == c1: continue
        list.append(f'alias bfs{c1}{c2}="source bfs_base -{c1}{c2}"')
        for c3 in chars:
            if c3 == c1 or c3 == c2: continue
            list.append(f'alias bfs{c1}{c2}{c3}="source bfs_base -{c1}{c2}{c3}"')
#            for c4 in chars:
#                if c4 == c1 or c4 == c2 or c4 == c3: continue
#                list.append(f'alias bfs{c1}{c2}{c3}{c4}="source bfs_base -{c1}{c2}{c3}{c4}"')
#                for c5 in chars:
#                    if c5 == c1 or c5 == c2 or c5 == c3 or c5 == c4: continue
#                    list.append(f'alias bfs{c1}{c2}{c3}{c4}{c5}="source bfs_base -{c1}{c2}{c3}{c4}{c5}"')
#                    for c6 in chars:
#                        if c6 == c1 or c6 == c2 or c6 == c3 or c6 == c4 or c6 == c5: continue
#                        list.append(f'alias bfs{c1}{c2}{c3}{c4}{c5}{c6}="source bfs_base -{c1}{c2}{c3}{c4}{c5}{c6}"')
                        
list.sort(key=len)

with open(".aliases_bfs.sh", "w") as file:
    file.write('alias dfs="source dfs_base"\n')
    file.write('alias bfs="source bfs_base"\n')
    for l in list:
        file.write(l+"\n")

