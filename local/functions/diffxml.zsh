## Diff two XML documents
## - diffxml doc1.xml doc2.xml
function diffxml() { diff -wb <(xmllint --format "$1") <(xmllint --format "$2"); }