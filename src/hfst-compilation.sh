cat morphology/root.lexc morphology/stems/adverbs.lexc morphology/stems/closedclassprotection.lexc morphology/stems/nouns.lexc morphology/stems/numerals.lexc morphology/stems/particles.lexc morphology/stems/prefixes.lexc morphology/stems/pronouns.lexc morphology/stems/punctuation.lexc morphology/stems/quantifiers.lexc morphology/stems/vaio.lexc morphology/stems/verbs.lexc morphology/affixes/nouns.lexc morphology/affixes/personprefixes.lexc morphology/affixes/verbs.lexc morphology/affixes/derivation.lexc morphology/affixes/compounding.lexc > tmp.lexc


hfst-lexc tmp.lexc -o morphology.hfst
hfst-xfst -F phonology/otw-phon.xfscript
hfst-compose-intersect -1 morphology.hfst -2 phonology.hfst -o morphophonology.hfst
hfst-lexc clitics/clitics.lexc -o clitics.hfst
hfst-concatenate -1 morphophonology.hfst -2 clitics.hfst -o morphophonologyclitics_generate.hfst
hfst-fst2fst -O -i morphophonologyclitics_generate.hfst -o morphophonologyclitics_generate.hfstol
hfst-invert -i morphophonologyclitics_generate.hfst -o morphophonologyclitics_analyze.hfst
hfst-fst2fst -O -i morphophonologyclitics_analyze.hfst -o morphophonologyclitics_analyze.hfstol

hfst-xfst -F orthography/fiero2corbiere.xfscript
hfst-compose-intersect -1 morphophonologyclitics_generate.hfst -2 fiero2corbiere.hfst -o morphophonologyclitics_generate_mcor_spelling.hfst
hfst-invert -i morphophonologyclitics_generate_mcor_spelling.hfst -o morphophonologyclitics_analyze_mcor_spelling.hfst
hfst-fst2fst -O -i morphophonologyclitics_generate_mcor_spelling.hfst -o morphophonologyclitics_generate_mcor_spelling.hfstol
hfst-fst2fst -O -i morphophonologyclitics_analyze_mcor_spelling.hfst -o morphophonologyclitics_analyze_mcor_spelling.hfstol

hfst-xfst -F errors/errorModel.xfscript

#hfst-xfst -F orthography/spellrelax_acorbiere.xfscript
#hfst-compose-intersect -1 morphophonologyclitics_generate.hfst -2 spellrelaxAcorbiere.hfst -o spellrelaxclitics_generate.hfst
#hfst-invert -i spellrelaxclitics_generate.hfst -o spellrelaxclitics_analyze.hfst
#hfst-fst2fst -O -i spellrelaxclitics_analyze.hfst -o spellrelaxclitics_analyze.hfstol

#hfst-xfst -F orthography/spellrelax_valentine.xfscript
#hfst-compose-intersect -1 morphophonologyclitics_generate.hfst -2 spellrelaxValentine.hfst -o spellrelaxclitics_valentine_generate.hfst
#hfst-invert -i spellrelaxclitics_generate.hfst -o spellrelaxclitics_valentine_analyze.hfst
#hfst-fst2fst -O -i spellrelaxclitics_analyze.hfst -o spellrelaxclitics_valentine_analyze.hfstol

#rm tmp.lexc
rm morphology.hfst
rm phonology.hfst
rm morphophonology.hfst
rm clitics.hfst
rm fiero2corbiere.hfst
rm spellrelaxAcorbiere.hfst
rm spellrelaxValentine.hfst
rm spellrelaxclitics_generate.hfst
