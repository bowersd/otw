cat morphology/root.lexc morphology/stems/adverbs.lexc morphology/stems/closedclassprotection.lexc morphology/stems/nouns.lexc morphology/stems/numerals.lexc morphology/stems/particles.lexc morphology/stems/prefixes.lexc morphology/stems/pronouns.lexc morphology/stems/punctuation.lexc morphology/stems/quantifiers.lexc morphology/stems/vaio.lexc morphology/stems/verbs.lexc morphology/affixes/nouns.lexc morphology/affixes/personprefixes.lexc morphology/affixes/verbs.lexc > tmp.lexc

#there are phonology problems in this setup (plus otw-phon.xfscript now ends with a save stack command that may screw things up)
xfst -f basic-compile.xfscript

rm tmp.lexc
