cat morphology/new_root.lexc morphology/stems/new_adverbs.lexc morphology/stems/closedclassprotection.lexc morphology/stems/new_nouns.lexc morphology/stems/prefixes.lexc morphology/stems/punctuation.lexc morphology/stems/new_verbs.lexc morphology/affixes/nouns.lexc morphology/affixes/personprefixes.lexc morphology/affixes/verbs.lexc morphology/affixes/derivation.lexc morphology/affixes/compounding.lexc morphology/affixes/adverbs.lexc morphology/affixes/numerals.lexc > new_words.lexc


hfst-lexc new_words.lexc -o urGuessing/morphology.hfst
hfst-xfst -F phonology/add_in_vowels.xfscript
hfst-compose-intersect -1 urGuessing/morphology.hfst -2 urCandidates.hfst -o urGuessing/urGuesser.hfst
#hfst-xfst -F phonology/otw-phon.xfscript #this is usually already compiled by hfst-compilation
hfst-compose-intersect -1 urGuessing/urGuesser.hfst -2 phonology.hfst -o urGuessing/morphophonology.hfst
hfst-lexc clitics/clitics.lexc -o clitics.hfst
hfst-concatenate -1 urGuessing/morphophonology.hfst -2 clitics.hfst -o urGuessing/morphophonologyclitics_generate.hfst
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_generate.hfst -o urGuessing/morphophonologyclitics_generate.hfstol
hfst-invert -i urGuessing/morphophonologyclitics_generate.hfst -o urGuessing/morphophonologyclitics_analyze.hfst
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_analyze.hfst -o urGuessing/morphophonologyclitics_analyze.hfstol

hfst-xfst -F orthography/fiero2corbiere.xfscript
hfst-compose-intersect -1 urGuessing/morphophonologyclitics_generate.hfst -2 fiero2corbiere.hfst -o urGuessing/morphophonologyclitics_generate_mcor_spelling.hfst
hfst-invert -i urGuessing/morphophonologyclitics_generate_mcor_spelling.hfst -o urGuessing/morphophonologyclitics_analyze_mcor_spelling.hfst
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_generate_mcor_spelling.hfst -o urGuessing/morphophonologyclitics_generate_mcor_spelling.hfstol
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_analyze_mcor_spelling.hfst -o urGuessing/morphophonologyclitics_analyze_mcor_spelling.hfstol

hfst-xfst -F errors/errormodel.default.xfscript
hfst-fst2fst -w -i errormodel.hfst -o errormodel.hfstol
hfst-compose -1 urGuessing/morphophonologyclitics_generate.hfst -2  errormodel.hfst -o urGuessing/morphophonologyclitics_generate_relaxed.hfst -F
hfst-invert -i urGuessing/morphophonologyclitics_generate_relaxed.hfst -o urGuessing/morphophonologyclitics_analyze_relaxed.hfst
#hfst-compose -1 urGuessing/morphophonologyclitics_generate_mcor_spelling.hfst -2  errormodel_corbiere.hfst -o urGuessing/morphophonologyclitics_generate_mcor_spelling_relaxed.hfst -F
#hfst-invert -i urGuessing/morphophonologyclitics_generate_mcor_spelling_relaxed.hfst -o urGuessing/morphophonologyclitics_analyze_mcor_spelling_relaxed.hfst
#hfst-fst2fst -w -i urGuessing/morphophonologyclitics_analyze_mcor_spelling_relaxed.hfst -o urGuessing/morphophonologyclitics_analyze_mcor_spelling_relaxed.hfstol
#hfst-fst2fst -w -i urGuessing/morphophonologyclitics_generate_mcor_spelling_relaxed.hfst -o urGuessing/morphophonologyclitics_generate_mcor_spelling_relaxed.hfstol
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_analyze_relaxed.hfst -o urGuessing/morphophonologyclitics_analyze_relaxed.hfstol
hfst-fst2fst -w -i urGuessing/morphophonologyclitics_generate_relaxed.hfst -o urGuessing/morphophonologyclitics_generate_relaxed.hfstol

#rm tmp.lexc
#rm morphology.hfst
rm phonology.hfst
#rm morphophonology.hfst
rm clitics.hfst
rm fiero2corbiere.hfst
rm errormodel.hfst
#rm spellrelaxAcorbiere.hfst
#rm spellrelaxValentine.hfst
#rm spellrelaxclitics_generate.hfst
