.mso pca.tmac
.\" Last modified: 2017-08-24
.SH 1
Adding OpenType Fonts to groff

The following is summarized from
\*[url \
https://lists.gnu.org/archive/html/groff/2010-09/msg00000.html]posts
by Pierre-Jean Fichet in 2010 in the groff mailing list\&.

groff comes with a set of fonts in its default font directory,
which is something like \fC/usr/share/groff/current/font\fP.  This
contains subdirectories \fCdevps\fP, \fCdevdvi\fP &c.  In order to add
your own fonts, it is best to create your own font directory on
this model, e.g., create a directory \fCgroffonts\fP somewhere in
your space, and in it make a subdirectory \fCdevps\fP.  To inform
groff of this addition, set the environment variable
\fCGROFF_FONT_PATH\fP:

.EX
  export GROFF_FONT_PATH=~/groffonts
.EE

As an example, let us now add the Baskervald OpenType font (OTF)
to groff.  Baskervald is a Baskerville-like free font available
from \*[url http://arkandis.tuxfamily.org/adffonts.html]\&.  Unpack the
provided zip file and add four of the OTF files, viz.

.EX
  BaskervaldADFStd.otf
  BaskervaldADFStd-Italic.otf
  BaskervaldADFStd-Bold.otf
  BaskervaldADFStd-BoldItalic.otf
.EE

to your \fCgroffonts/devps\fP directory.  These are now to be
transformed into a four-element \fIfont family\fP that is suitable
for groff.  For this, use the provided script \fCotf2groff.sh\fP,
which takes two arguments: the name of the OTF font and the name
preferred for the corresponding groff font.  E.g.,

.EX
  otf2groff.sh BaskervaldADFStd.otf baskervaldR
.EE

This creates the groff font \fCbaskervaldR\fP and adds a line to a
file \fCdownload.addition\fP, creating it if it doesn’t exist.  Here,
the prefix \fCbaskervald\fP identifies the family name that will be
used by groff, and the suffix \fCR\fP denotes that it is the
“regular” (default, normal, upright, roman) style.

Similarly, convert the other Baskervald OTFs, taking care to use
the same prefix (\fCbaskervald\fP) and the suffixes \fCI\fP, \fCB\fP, and
\fCBI\fP for the italic, bold and bold-italic styles. I.e.,

.EX
  otf2groff.sh BaskervaldADFStd-Italic.otf baskervaldI
  otf2groff.sh BaskervaldADFStd-Bold.otf baskervaldB
  otf2groff.sh BaskervaldADFStd-BoldItalic.otf baskervaldBI
.EE

The \fCdownload.addition\fP file should now contain

.EX
  BaskervaldADFStd BaskervaldADFStd.pfa
  BaskervaldADFStd-Bold BaskervaldADFStd-Bold.pfa
  BaskervaldADFStd-Italic BaskervaldADFStd-Italic.pfa
  BaskervaldADFStd-BoldItalic BaskervaldADFStd-BoldItalic.pfa
.EE

Add these lines to \fCgroffonts/devps/download\fP (creating this
file if it doesn’t already exist).

You’re now ready to use the \fCbaskervald\fP font in groff.  Call groff
with the option \fC-f baskervald\fP on your document, say \fCdoc.ms\fP.

.EX
  groff -f baskervald -ms doc.ms > doc.ps
  ps2pdf doc.ps doc.pdf
.EE

\fCdoc.pdf\fP should now be in Baskervald rather than groff’s default
Times.

It is also possible to set the font family within the groff
document, using the command

.EX
  .fam baskervald
.EE

.SH 2
Using single-style fonts

You may prefer to use just one style of an OTF, perhaps because
the OTF comes in only one style.  Let’s say we want to set the
body text in EB Garamond, obtainable from
http://fontsquirrel.com/fonts/eb-garamond.  As above, copy the
\fCEBGaramond.otf\fP to \fCgroffonts/devps\fP and convert it to the groff
font \fCebgaramondR\fP:

.EX
  otf2groff.sh EBGaramond.otf ebgaramondR
.EE

and add the \fCdownload.addition\fP line to \fCdevps/download\fP.

In your document, have

.EX
  .fp 1 ebgaramondR
.EE

Sometimes, the single style you want is the bold, possibly for
section headers.  Thus, to use the bold from TeX Gyre Pagella,
(available at
\*[url http://www.gust.org.pl/projects/e-foundry/tex-gyre/pagella]\&), call

.EX
  otf2groff.sh texgyrepagella-bold.otf pagellaB
.EE

add the corresponding line from \fCdownload.addition\fP to
\fCdevps/download\fP, and in your document, call

.EX
  .ftr B pagellaB
.EE 
