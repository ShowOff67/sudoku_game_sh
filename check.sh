#!/bin/bash


sudoku_check=(9 7 8 3 1 2 6 4 5
			  3 1 2 6 4 5 9 7 8
			  6 4 5 9 7 8 3 1 2
			  7 8 9 1 2 3 4 5 6
			  1 2 3 4 5 6 7 8 9
			  4 5 6 7 8 9 1 2 3
			  8 9 7 2 3 1 5 6 4
			  2 3 1 5 6 4 8 9 7
			  5 6 4 8 9 7 2 3 1)    

group=()               

count_9=0         

ok_check=0            

return_check=0         

sudoku_check=($@)     


# 9行
for i in {0..8}                           
do    
	
	for j in {0..8}                         
	do
		group[j]=${sudoku_check[$((9*i+j))]}
	done
	
	
	count_9=0
	for k in {0..8}                         
	do
		if [[ "${group[@]}" =~ $((k+1)) ]] 
		then
			((count_9++))
		else
			return_check=0                
			break
		fi
	done

	
	if [ ${count_9} -eq 9 ]
	then
		((ok_check++))    # echo "line ${i} ok"
	fi
done



for i in {0..8}                     
do
	for j in {0..8}
	do
		group[j]=${sudoku_check[$((9*j+i))]}
	done
	
	count_9=0	
	for k in {0..8}
	do
		if [[ "${group[@]}" =~ $((k+1)) ]]  
		then
			((count_9++))
		else
			return_check=0
			break
		fi
	done

	if [ ${count_9} -eq 9 ]
	then
		((ok_check++))    # echo "col ${i} ok"
	fi	
done



first=(0 3 6 27 30 33 54 57 60)
for i in {0..8}                   
do
	for m in 0 1 2
	do
		for n in 0 1 2
		do	
			group[$((3*m+n))]=${sudoku_check[$((${first[$i]}+9*m+n))]}
		done
	done
	
	count_9=0
	for k in {0..8}
	do
		if [[ "${group[@]}" =~ $((k+1)) ]]
		then
			((count_9++))
		else
			return_check=0
			break
		fi
	done

	if [ ${count_9} -eq 9 ]
	then
		((ok_check++))     # echo "part ${i} ok"
	fi	
done



if [ ${ok_check} -eq 27 ]
then
	return_check=1
fi