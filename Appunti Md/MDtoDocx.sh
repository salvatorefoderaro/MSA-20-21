#!/bin/bash

for i in *.md;
do pandoc -s -o "Docx/$i".docx "$i";
done