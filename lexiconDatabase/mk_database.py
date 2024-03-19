import re
import pandas
import duckdb
import sys

def lexc_to_dict_and_extras(filename):
    h = {}
    extras = []
    with open(filename) as f_in:
        sub_h = []
        header = ""
        for line in f_in:
            if line.startswith("LEXICON"):
                h[header] = sub_h
                sub_h = []
                header = re.search("(\S*)\s(\S*)", line)[2]
            else:
                std_entry = re.match('(?P<mc_dictionary_top>[^!:]*):(?P<rv_full_vowels>\S*)\s*(?P<destination>\S*)\s*(?P<definition>".*?")\s*;\s*!\s*Rand( |2)key:(?P<rv_key>n\S*n)(?P<comments>.*)', line)
                if std_entry: sub_h.append({ #you cannot loop over a Match object because they are not iterable, even though you can refer to indices. how insane is that?
                    "mc_dictionary_top":std_entry["mc_dictionary_top"],
                    "rv_full_vowels":std_entry["rv_full_vowels"],
                    "destination":std_entry["destination"],
                    "definition":std_entry["definition"],
                    "rv_key":std_entry["rv_key"],
                    "comments":std_entry["comments"],
                    })
                else: extras.append(line)
        with open(filename+".extras",'w') as f_out:
            for x in extras: f_out.write(x)
    return {x:h[x] for x in h if h[x]} #this does remove the ability to reconstruct the lexc file with the current structure of the lexc files... would be better to have them structured right and just return h

short_vowels = "(a[^a]|i[^i]|o[^o]|Va1|Vi1|Vo1|Vo2|Vv1|Bv1)"
def fix_vowels(string):
    return re.sub("Bv1", "i", re.sub("Vo2", "a", re.sub("Vo1", "wa", re.sub("Vv1", "i", re.sub("Vi1", "a", re.sub("Va1", "o", string))))))

regexen = {
        "v_init":"[aioe]",
        "left_alt":"[^aioe]*[aio][^aioe]*",
        "two_alt":"([^aioe]*[aio][^aioe]*){2}(?!$)",
        "three_alt":"([^aioe]*[aio][^aioe]*){3}(?!$)",
        }

def test(regex, string):
    return bool(re.match(regex, string))

def main(*args):
    h = []
    for a in args:
        core_words = lexc_to_dict_and_extras(a)
        for x in core_words: 
            for i in range(len(core_words[x])):
                core_words[x][i]["rv_special_vowels_translated"] = fix_vowels(core_words[x][i]["rv_full_vowels"])
                core_words[x][i]["rv_special_vowels_translated_diff"] = core_words[x][i]["rv_full_vowels"] != core_words[x][i]["rv_special_vowels_translated"]
                for z in regexen:
                    core_words[x][i][z] = test(regexen[z], core_words[x][i]["rv_special_vowels_translated"])
            h.extend(core_words[x])
    h_df = pandas.DataFrame(h)
    with duckdb.connect("lexicon.db") as cxn:
        cxn.sql("CREATE TABLE words as SELECT * FROM h_df")

if __name__ == "__main__":
    main(*sys.argv[1:])

