import re

with open("../src/morphology/lexicon.lexc.tmp") as file_in:
    keyed = {}
    for line in file_in:
        key = re.search("key: n[^ ]*", line)
        if key and key[0] not in keyed: keyed[key[0]] = [line]
        elif key and key[0] in keyed: keyed[key[0]].append(line)


