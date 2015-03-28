# last modified 2014-12-16

fam=$1
reg=$2
ital=$3
bold=$4
boldital=$5

test -f "$reg" && otf2groff.sh $reg ${fam}R
test -f "$ital" && otf2groff.sh $ital ${fam}I
test -f "$bold" && otf2groff.sh $bold ${fam}B
test -f "$boldital" && otf2groff.sh $boldital ${fam}BI
