cat morphology/root.lexc morphology/stems/adverbs.lexc morphology/stems/closedclassprotection.lexc morphology/stems/nouns.lexc morphology/stems/numerals.lexc morphology/stems/particles.lexc morphology/stems/prefixes.lexc morphology/stems/pronouns.lexc morphology/stems/punctuation.lexc morphology/stems/quantifiers.lexc morphology/stems/vaio.lexc morphology/stems/verbs.lexc morphology/affixes/nouns.lexc morphology/affixes/personprefixes.lexc morphology/affixes/verbs.lexc > tmp.lexc

xfst -f basic_compile.xfscript

rm tmp.lexc
