# last change 2015-03-02

if test "$1" = ""
then echo needs one argument; exit
fi

texgyrefontname=$1

otf2fam.sh texgyre$texgyrefontname \
    texgyre$texgyrefontname-regular.otf \
    texgyre$texgyrefontname-italic.otf \
    texgyre$texgyrefontname-bold.otf \
    texgyre$texgyrefontname-bolditalic.otf
