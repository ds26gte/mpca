# last change 2011-11-19

otfname=$1
groffname=$2

otfbasename=${otfname%.otf}

if test -n "$(which fontforge)"
then otf2pfa.sh $otfname
else 
cfftot1 -a $otfname > $otfbasename.pfa
t1rawafm $otfbasename.pfa > $otfbasename.afm
fi

afmtodit -d DESC $otfbasename.afm textmap $groffname

sed -i -e \
"s/---\t\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t\(.*\)/\4\t\1\t\2\t\3\t\4/" \
$groffname

psname=$(grep FontName $otfbasename.pfa |
sed -e 's/^\/[^ ]* *\/\([^ ]*\).*/\1/')

echo $psname $otfbasename.pfa >> download.addition
