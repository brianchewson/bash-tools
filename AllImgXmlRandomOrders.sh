#!/bin/sh -ex

rm $1

P=`pwd`

echo "<background>" >> $1
echo "   <starttime>" >> $1
echo "      <year>2009</year>" >> $1
echo "      <month>08</month>" >> $1
echo "      <day>04</day>" >> $1
echo "      <hour>00</hour>" >> $1
echo "      <minute>00</minute>" >> $1
echo "      <second>00</second>" >> $1
echo "   </starttime>" >> $1
echo "<!-- This animation will start at midnight. -->" >> $1

gore=""
SIZE=$(shuf -i 1-100 -n 1)

for (( i=0; i<$SIZE; i++ )); do
  ls -1 | grep -v xml | grep -v '\.sh' | sort -R | while read line; do
    echo "   <transition>" >> $1
    echo "      <duration>0.1</duration>" >> $1
    echo "      <from>$P/$gore</from>" >> $1
    echo "      <to>$P/$line</to>" >> $1
    echo "   </transition>" >> $1   
    echo "   <static>" >> $1
    echo "      <duration>$(shuf -i 1-100 -n 1)</duration>" >> $1
    echo "      <file>$P/$line</file>" >> $1
    echo "   </static>" >> $1 
    gore=$line  
  done
  gore=$line  
done

echo "</background>" >> $1
