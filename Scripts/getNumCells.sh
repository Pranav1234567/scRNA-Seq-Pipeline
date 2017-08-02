#!/bin/bash

wc -l $1 > tempA.txt
awk '{print $1}' tempA.txt > tempB.txt
typeset -i NUMCELLS=$(cat tempB.txt)
 
