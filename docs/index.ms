.mso pca.tmac
.
.ND 2017-08-19 \" last modified
.
.TL
mpca
.AU
\*[url https://ds26gte.github.io]Dorai Sitaram\&
\*[url https://github.com/ds26gte/mpca]Download\&
.RT

.SH 1
Introduction

The venerable typesetter groff is ubiquitous. It lets you
create documents in plain text with your favorite text editor.
However, there are other factors that chip away at these core
advantages.

To wit: Source documents look very busy, even when one isn’t
using any special features, most notably because markup is
required for paragraph separation. Basic features like cross
references, table of contents and index are not immediately
available. Writing even relatively simple macros can be
forbidding.

The \fCmpca\fP macro package is an extension of the
standard \fCms\fP package that lets you write fairly clean source
documents, and provides workable defaults for basic needs that
can be overridden as needed.

\fCmpca\fP is an \fIunobtrusive\fP extension to \fCms\fP. You only need to
use features as you need them.

\fCmpca\fP may stand for “Macros for the Prevention of Cruelty to
Authors”.

.SH 1
Installation

Get the \fCmpca\fP package from GitHub:

.EX
  git clone https://github.com/ds26gte/mpca
.EE

The directory \fCmpca\fP contains the macro file \fCpca.tmac\fP and
several subfiles \fCpca-*.tmac\fP. Copy all of them to a directory in
your \fCGROFF_TMAC_PATH\fP. (If you’re just experimenting,
you could just copy them to your home directory.)

.SH 2
troff2page

The macro files with prefix \fCpca-t2p-\fP are automatically
loaded when the typesetter is \*[url
https://github.com/ds26gte/troff2page]troff2page\& rather than
\fCgroff\fP proper. They provide troff2page-specific alterations
to the \fCmpca\fP macros that make the translation efficient
and/or HTML-relevant. E.g., the ToC, cross-references, and index
are converted into hyperlinks.

\fITip:\fP If you don't intend to use troff2page to convert
your documents to HTML, you may ignore the \fCpca-t2p-*.tmac\fP
macro files. I.e., you don't need to put them in
\fCGROFF_TMAC_PATH\fP.

.SH 1
Invocation

To use \fCmpca\fP, you can simply source \fCpca.tmac\fP in your document:

.EX
  .mso pca.tmac
.EE

Alternatively, you can use the \fCgroff\fP command-line option \fC-m\fP,
e.g.,

.EX
  % groff -mpca doc.ms > doc.ps
.EE

Other \fCgroff\fP options can be added as usual.

Let’s now go into the \fCmpca\fP features that you can use in your document.

.SH 1
Init file

\fCmpca\fP will source a macro file \fC.groffrc\fP if it can find it in
your \fCGROFF_TMAC_PATH\fP or home directory.

\fC~/.groffrc\fP is a good place to put minor customizations that are
relevant only to your system. (I find I need to slightly tweak
the page-offset register (\fCPO\fP) to suit my printer — this tweak needn’t
or shouldn’t be enshrined in my document.)

.SH 1
Blank lines

Stop using \fC.PP\fP and \fC.LP\fP (unless you really want to)!  Simply
separate your paragraphs by a blank line.

\fCmpca\fP takes care to indent paragraphs only when needed. Thus,
the first paragraph after a sectioning macro is not indented.
Also blank lines within code displays don’t cause indentation.

.SH 1
Verbatim display

Use \fC.EX\fP to start and \fC.EE\fP to end a verbatim display, typically
used for program listings. Inside the listing, you can use
the backslash (\fC\fP\e\fC\fP) without triggering a troff escape. The
only restriction is you can’t use a period (\fC\fP.\fC\fP) in the first
column of any line in the display. E.g.,

.EX
  .EX
    (defun fact (n)
      (if (= n 0) 1
          (* n (fact (- n 1)))))
  .EE
.EE

You can turn the troff escape on and again off within your display with
calls to \fC.ec\fP and \fC.eo\fP respectively. The lines containing these
calls must of course have \fC.\fP in the first column and will not be
displayed.

.SH 1
Image

The \fC.IMG\fP macro can be used to insert image files. The syntax
follows that of the \fC.IMG\fP macro in the \fCwww.tmac\fP, but (a) isn’t
restricted to HTML output. E.g.,

.EX
  .IMG t2p.png
.EE

sources the image \fCt2p.png\fP.
You can specify the image alignment with an optional first argument: \fC-L\fP
for left, \fC-R\fP for right, \fC-C\fP for centered. If no alignment is
specified, \fC-C\fP is assumed.

\fC.IMG\fP relies on the external programs \fCconvert\fP (from
ImageMagick) and \fCinkscape\fP. (\fCinkscape\fP is needed for SVG
images.)

.SH 1
Page cross-references

The \fC.TAG\fP macro manages cross-references. E.g.,

.EX
  .TAG sec_grofflua
.EE

associates the label \fCTAG:sec_grofflua\fP with the number of the
current page. The \fIstring\fP \fC\*[TAG:sec_grofflua]\fP is defined to
typeset as that page number. Thus, in a hand-crafted table of
contents, you could use

.EX
  Extending groff using Lua, \*[TAG:sec_grofflua]
.EE

\fC.TAG\fP takes an optional second argument. The label is then
associated with the text of the second argument instead of the
current page number.

\fINote:\fP \fC\fPmpca\fC\fP’s \fC.TAG\fP overrides a similarly named macro in
the file \fCwww.tmac\fP in the groff distribution, which only
allows backward references.

\fIImportant:\fP \fC.TAG\fP requires two runs of \fCgroff\fP. Please see the
section on aux files.

.SH 1
Table of contents

The \fC.TOC\fP macro inserts a table of contents (ToC). Add your own header
(e.g., “Contents”, or “Table of Contents”).

\fC.TOC\fP does not require
you to modify how you use your sectioning macros — it automatically
draws its
information from the distribution of the \fC.NH\fP
and \fC.SH\fP macros within your document. It is thus a solution to
the following statement from the groff manual:

[quote]
Altering the ‘NH’ macro to automatically build the table of contents
is perhaps initially more difficult, but would save a great deal of time
in the long run if you use ‘ms’ regularly.

ToC entries are generated for the usual \fCms\fP section headers (\fC.SH\fP,
\fC.NH\fP). The \fIdepth\fP of the ToC is governed by the number register
\fCGROWPS\fP: Only those \fC.SH\fP/\fC.NH\fP headers at a level less than or
equal to \fCGROWPS\fP will go into the ToC.

.SH 1
Index

The \fC.IX\fP macro is used to generate index entries:

.EX
  .IX item to be indexed
.EE

marks the text “item to be indexed” as an indexable item. The sorted index made
from these entries can be sourced into the input document via

.EX
  .so \*[AUXF].ind
.EE

Adding a section header on top is up to you.

The sorted index is constructed using the external program
\fCmakeindex\fP.  \fCmakeindex\fP is included in TeX distributions, but
you can also obtain it as
\*[url http://stuff.mit.edu/afs/sipb/project/tex-dev/src/tar/makeindex.tar.gz]a
standalone package\&.

The syntax for \fC.IX\fP calls is essentially the same
as for LaTeX,
except that in groff we use

.EX
  .IX item
.EE

where in LaTeX one would use

.EX
  \index{item}
.EE

The metacharacters \fC@\fP, \fC!\fP, \fC"\fP, and \fC|\fP can be used
to respectively specify

1. alternate alphabetization,

2. subitems,

3. literal metacharacters, and

4. encapsulation of the page number.

E.g.,

.EX
  .IX m@-m, groff option
.EE

identifies an index entry for “-m, groff option” but alphabetizes
it as though it were “m” rather than something that starts with a
hyphen.

For full details on the other metacharacters, consult the
\*[url http://tex.loria.fr/bibdex/makeindex.pdf]makeindex documentation\&.

.SH 1
Eval

The macro \fC.eval\fP allows you to insert Common Lisp, JavaScript,
or Lua code in your document to guide its transformation via
groff. In other words, it lets you you use Lua, CL, or JS to
extend groff instead of relying purely on groff macros. We will
first describe the Lua version of \fC.eval\fP.

.SH 2
Lua

\fC.eval\fP does only one thing: It allows you to place arbitrary
Lisp code until the following \fC.endeval\fP, and the text written to
standard output by this Lua code is substituted for the `.eval ...
.endeval`. The usefulness of this tactic will be apparent from an
example. Consider the following document, \fCtau.ms\fP:

.EX
  The ratio of the circumference of a circle to
  its radius is \(*t \(~=
  .eval
  // following prints tau, because cos(tau/2) = -1
  io.write(2*math.acos(-1), '.\n')
  .endeval
.EE

Run it through \fCmpca\fP:

.EX
  groff -z -U -mpca tau.ms
.EE

The \fC-z\fP avoids generating ouput, because we’re not ready for it
yet. The \fC-U\fP runs \fCgroff\fP in “unsafe” mode, i.e., it allows the
writing of aux files.

You will find that the \fCgroff\fP call produces the following
message:

.EX
  Rerun groff with -U
.EE

Call \fCgroff\fP again as folows:

.EX
  groff -U -mpca tau.ms > tau.ps
.EE

\fCtau.ps\fP will now look like:

.RS
The ratio of the circumference of a circle to
its radius is τ ≈ 6.2831855.
.RE

Here’s how it works. The first \fCgroff\fP call produces a Lua file
\fC\*[AUXF].lua\fP that collects all the \fC.eval\fP code in the
document. The second \fCgroff\fP call invokes Lua to create an aux
file for each \fC.eval\fP and sources it back into the document.

It should be clear that Lua code via \fC.eval\fP can serve as a very
powerful \fIsecond extension language\fP for groff.  
For a more substantial example of \fC.eval\fP’s use see 
\*[url ds26gte.github.io/troff2page]the troff2page manual\&.

.SH 2
Common Lisp

To use Common Lisp inside \fC.eval\fP, set

.EX
  .ds pca-eval-lang lisp
.EE

in your document before the first use of \fC.eval\fP.  Thus, the
\fCtau.ms\fP file, translated to Common Lisp, will now read:

.EX
  .ds pca-eval-lang lisp
  The ratio of the circumference of a circle to
  its radius is \(*t \(~=
  .eval
  ;following prints tau, because cos(tau/2) = -1
  (princ (* 2 (acos -1)))
  (princ ".")
  (terpri)
  .endeval
.EE

.SH 2
JavaScript

To use JavaScript inside \fC.eval\fP, set

.EX
  .ds pca-eval-lang js
.EE

in your document before the first use of \fC.eval\fP.  Thus, the
\fCtau.ms\fP file, translated to JavaScript, will now read:

.EX
  .ds pca-eval-lang js
  The ratio of the circumference of a circle to
  its radius is \(*t \(~=
  .eval
  // following prints tau, because cos(tau/2) = -1
  troff.write('' + 2*Math.acos(-1));
  troff.write('.\n');
  .endeval
.EE

\fINote:\fP For the JavaScript \fC.eval\fP, we write to the stream \fCtroff\fP
rather than to standard output.

.SH 1
Aux files

\fCmpca\fP uses auxiliary (aux) files to implement its
cross-referencing, ToC, indexing,
and eval features.

The troff string \fC\*[AUXF]\fP is used to construct the names of
these auxiliary files. By default this is quietly set to \fC.trofftemp\fP.
You can change it to something else (provided it satisfies
file-naming conventions) in your document before the first use of
any macros that use or write aux files.

Aux files are created in one run of \fCgroff\fP and slurped back in
during a second run. Thus \fCgroff\fP needs to be run twice for the
defined feature to take effect. Furthermore, the first run of
\fCgroff\fP must be run in “unsafe” mode (\fCgroff\fP option \fC-U\fP) as
\fCgroff\fP won’t create external files in “safe” mode.

.SH 1
Using only some of mpca’s features

\fITip:\fP You may ignore this section if you don’t mind loading all of
the \fCmpca\fP features.

You may pick and choose individual features of \fCmpca\fP
without committing to the rest of it.
To do this source one or more of the following
macro files: \fCpca-img.tmac\fP (for images), \fCpca-tag.tmac\fP (cross-references),
\fCpca-toc.tmac\fP (ToC), \fCpca-ix.tmac\fP (index), and
\fCpca-eval.tmac\fP (eval).  E.g.,

.EX
  .mso pca-eval.tmac
.EE

If the feature uses aux files, you will need to run \fCgroff\fP
twice, once in unsafe mode,
as described in the section on aux files.

.SH 1 
Adding OpenType Fonts to groff

For tips on this, see \*[url ./otfgroff.html]\&.

