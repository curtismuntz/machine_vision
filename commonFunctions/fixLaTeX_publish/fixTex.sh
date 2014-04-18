#!/bin/bash

#fix this to pass in filename instead

#cat $fileName
#cd /Users/me/git/machine_vision/hw8/html/

cd /Users/me/Dropbox/School/188/hw8/html

file=hw8.tex
#file=eee188_hw7.tex
cp /Users/me/git/machine_vision/commonFunctions/fixLaTeX_publish/codeInsert.txt /Users/me/Desktop/tmp/published/codeInsert.txt
cp $file /Users/me/Desktop/tmp/published/output1.tex
cp *.eps /Users/me/Desktop/tmp/published/
PATTERN='usepackage{color}'



cd /Users/me/Desktop/tmp/published/
sed -e "/${PATTERN}/r ./codeInsert.txt" output1.tex > /Users/me/Desktop/tmp/published/output.tex
rm output1.tex

#change verbatims to listings
cat output.tex | sed -e 's/begin{verbatim}/begin{lstlisting}[language=Matlab]/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/end{verbatim}/end{lstlisting}/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/subsection\*{Problem/section{Problem/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex


cat output.tex | sed -e 's/subsection\*{Part/subsection{Part/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/documentclass{article}/documentclass{IEEEtran}/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\vspace{1em}//g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\begin{par}//g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\end{par}//g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/width=4in/width=3in/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\color{lightgray} \\begin{lstlisting}\[language=Matlab\]/ { \\small \\color{lightgray} \\begin{verbatim}/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\end{lstlisting} \\color{black}/\\end{verbatim} \\color{black} }/g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\begin{document}/\\begin{document} \\maketitle /g' > output1.tex
cat output1.tex > output.tex
rm output1.tex

cat output.tex | sed -e 's/\\includegraphics /\\includegraphics /g' > output1.tex
cat output1.tex > output.tex
rm output1.tex
