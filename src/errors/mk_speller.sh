#not bothering to take the upper projection
#the result of doing that is that fst2fst throws and error
#hfst-project --project=upper 
hfst-xfst -F errormodel.default.xfscript
hfst-invert -i errormodel.hfst -o errormodel.default.hfst
hfst-fst2fst -i errormodel.default.hfst -o errmodel.default.hfst -f olw
hfst-fst2fst -i ../morphophonologyclitics_analyze.hfst -o acceptor.default.hfst -f olw

rm spellchecker.zhfst
zip spellchecker.zhfst index.xml acceptor.default.hfst errmodel.default.hfst
rm acceptor.default.hfst
rm errormodel.hfst
rm errormodel.default.hfst

