#!/bin/sh -e

XML=$1
rm $XML
RANDOM_ORDER_FILE=t.rand

P=`pwd`

echo "<background>" >> $XML
echo "   <starttime>" >> $XML
echo "      <year>2009</year>" >> $XML
echo "      <month>08</month>" >> $XML
echo "      <day>04</day>" >> $XML
echo "      <hour>00</hour>" >> $XML
echo "      <minute>00</minute>" >> $XML
echo "      <second>00</second>" >> $XML
echo "   </starttime>" >> $XML
echo "<!-- This animation will start at midnight. -->" >> $XML

gore=""
SIZE=$(shuf -i 1-100 -n 1)

for (( i=0; i<$SIZE; i++ )); do
  ls -1 > ${RANDOM_ORDER_FILE}
  for FILE in xml \.sh ${RANDOM_ORDER_FILE}; do 
    sed -i "/${FILE}/d" ${RANDOM_ORDER_FILE}
  done
  sort -R ${RANDOM_ORDER_FILE} -o ${RANDOM_ORDER_FILE}

  while read line; do
    echo "   <transition>" >> $XML
    echo "      <duration>0.1</duration>" >> $XML
    echo "      <from>$P/$gore</from>" >> $XML
    echo "      <to>$P/$line</to>" >> $XML
    echo "   </transition>" >> $XML   
    echo "   <static>" >> $XML
    echo "      <duration>$(shuf -i 1-100 -n 1)</duration>" >> $XML
    echo "      <file>$P/$line</file>" >> $XML
    echo "   </static>" >> $XML 
    gore=$line  
  done < ${RANDOM_ORDER_FILE}
done
echo "</background>" >> $XML

sed -i "s#/<#/$gore<#" ${XML}
