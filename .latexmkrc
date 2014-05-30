# --------------------------------------------------------------------------------
# Simply start:
#
#     $ latexmk -silent -pvc -pdf <filename>
#
# --------------------------------------------------------------------------------
$latex = 'latex -src-specials -parse-first-line';
$pdflatex = 'pdflatex -synctex=1 %O %S';
$bibtex = 'bibtex';
$makeindex = 'mendex';

if ($^O eq 'linux') {
    $dvi_previewer = 'start xdvi';
    $pdf_previewer = 'start evince';
    $pdf_update_method = 0;
}
elsif ($^O eq 'darwin') {
    $dvi_previewer = 'open -a Skim.app';
    $pdf_previewer = 'open -a Skim.app';
    $pdf_update_method = 0;
}


# vim: ft=perl
