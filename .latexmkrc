$latex = 'uplatex -synctex=1';
$latex_silent = 'uplatex -synctex=1 -interaction=batchmode';
$bibtex = 'upbibtex';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';
$dvipdf ='dvipdfmx %O -o %D %S';
$dvips = 'pdvips';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode =3; # 0:-pdf-,1: -pdf,2: -pdfps,3: -pdfdvi
$OS_TYPE = $^O;
if ($OS_TYPE eq 'linux') {
  $pdf_previewer = 'evince';
} elsif ($OS_TYPE eq 'MSWin32') {
  $pdf_previewer = 'acrobat';
}
