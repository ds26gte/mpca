mpca is a Groff macro package that conservatively extends the ms
package.  Its features include:

• blank lines as paragraph separators
• index
• table of contents
• code display
• section macros
• image insertion (.svg, .jpeg, etc)
• page references both backward and forward

Place the pca*.tmac files in your home directory or somewhere on
your GROFF_TMAC_PATH.

mpca may be loaded into your groff source as

.mso pca

or invoked as the groff command-line option

-mpca

If using the index or table-of-contents features, you have to use
the -U groff command-line option for the first run, as groff
needs to be in “unsafe” mode so that mpca can create the external
auxiliary files needed.

mpca stands for “Macros for the Prevention of Cruelty to
Authors”.
