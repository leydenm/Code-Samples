# Code-Samples
Examples of programs I created for myself

Compress jpeg
a simple Windows front-end for MozJpeg.  The setup is complex enough to outweigh the convenience of having file dialog.  I set it up for somebody who would be deterred by a command line interface.

Setup:

Download and build MozJpeg. https://github.com/mozilla/mozjpeg

you will probably want to copy compress_jpeg.ps1 in to the folder with the cjpeg binary or set up some environment variables for the path to mozjpeg.

run:

  powershell -ExecutionPolicy UnRestricted -File [path to compress_jpeg.ps1]

Palindrome Search
A PERL progam for searching for all possible palindromes in a text file.

run:

  perl palindromes.pl [path to text file]
