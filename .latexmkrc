#!/usr/bin/perl
$latex = 'platex -synctex=1 %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O %S';
$pdf_mode = 3; # use dvipdf
$pdf_update_command = 'open -a Preview %S'; 
