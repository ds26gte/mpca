.SH mpca

mpca is a Groff macro package that conservatively extends the ms
package.  Its features include:

• blank lines as paragraph separators

• indexing

• table of contents

• code display

• image insertion (.svg, .jpeg, &c)

• page references both backward and forward

Place the pca*.tmac files in your home directory or somewhere in
your GROFF_TMAC_PATH. mpca may be loaded into your groff source
as

  .mso pca

or invoked as a groff command-line option:

  groff -mpca ...

If using the indexing or table-of-contents features, you have to
use the -U groff command-line option for the first run, as groff
needs to be in “unsafe” mode so that mpca can create the external
auxiliary files needed.

You can use just the indexing or ToC facilities in pca.tmac
without committing to the rest of it. See

  pca-ix.README
  pca-toc.README

for info on how to do this.

mpca stands for “Macros for the Prevention of Cruelty to
Authors”.
