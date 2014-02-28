#!/bin/bash

#fix this to pass in filename instead

#cat $fileName
cd /Users/me/git/machine_vision/hw5/html/

file=hw5.tex
cp $file /Users/me/Desktop/tmp/published/output.tex
cp *.eps /Users/me/Desktop/tmp/published/
PATTERN='usepackage{color}'

cd /Users/me/Desktop/tmp/published/

#add some stuff to preample
sed -e "/${PATTERN}/r ../codeInsert.txt" output.tex > /Users/me/Desktop/tmp/published/output.tex
rm output1.tex

#change verbatims to listings
cat output.tex | sed -e 's/begin{verbatim}/begin{lstlisting}[language=Matlab]/g' > output.tex

#change verbatim ends to listings
cat output.tex | sed -e 's/end{verbatim}/end{lstlisting}/g' > output.tex

#change *Problem to Problem
cat output.tex | sed -e 's/subsection\*{Problem/section{Problem/g' > output.tex

#change parts to 
cat output.tex | sed -e 's/subsection\*{Part/subsection{Part/g' > output.tex

#change document class
cat output.tex | sed -e 's/documentclass{article}/documentclass{IEEEtran}/g' > output.tex

#remove \vspace{1em}
cat output.tex | sed -e 's/\\vspace{1em}//g' > output.tex

#remove \begin{par}
cat output.tex | sed -e 's/\\begin{par}//g' > output.tex

#remove \end{par}
cat output.tex | sed -e 's/\\end{par}//g' > output.tex

#change picture width from 4in to 3in
cat output.tex | sed -e 's/width=4in/width=3in/g' > output.tex

#change the edited lstlisting back to verbatim (this can be fixed with regexes)
cat output.tex | sed -e 's/\\color{lightgray} \\begin{lstlisting}\[language=Matlab\]/ { \\tiny \\color{lightgray} \\begin{verbatim}/g' > output.tex

#change the edited lstlisting back to verbatim (end)
cat output.tex | sed -e 's/\\end{lstlisting} \\color{black}/\\end{verbatim} \\color{black} }/g' > output.tex

#add \maketitle
cat output.tex | sed -e 's/\\begin{document}/\\begin{document} \\maketitle /g' > output.tex






