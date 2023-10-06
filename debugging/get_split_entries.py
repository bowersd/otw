import re

with open("../src/morphology/lexicon.tmp.lexc") as file_in:
    keyed = {}
    for line in file_in:
        key = re.search("key:n[^ ]*", line)
        if key and key[0] not in keyed: keyed[key[0]] = [line]
        elif key and key[0] in keyed: keyed[key[0]].append(line)
    cnt = 0
    for key in keyed:
        if len(keyed[key]) > 1:
            cnt += 1
            print()
            for s in keyed[key]:
                print(s.strip())
    print(cnt)
