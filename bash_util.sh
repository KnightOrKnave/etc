function randomIp(){
local array=($@)
local num=`expr 4 - ${#array[@]}`
for x in `seq 1 ${num}`;do array+=(`expr $RANDOM % 255`); done
echo ${array[*]} | sed -e 's/ /./g'
}


date --iso-8601=seconds


function getRandom(){
local arr=($@)
x=`expr $RANDOM % ${#arr[@]}`
echo $x
echo ${arr[$x]}
}

