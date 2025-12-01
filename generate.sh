#!/bin/bash


sudoku_generate=()      



sudoku1=(6 8 5 4 9 3 2 7 1
		 3 4 9 7 1 2 8 6 5
		 2 7 1 8 6 5 3 4 9
		 9 2 6 5 4 1 7 8 3
		 4 1 7 9 3 8 5 2 6
		 8 5 3 2 7 6 9 1 4
		 7 6 8 1 5 9 4 3 2
		 5 3 4 6 2 7 1 9 8
		 1 9 2 3 8 4 6 5 7)
		 
sudoku2=(8 1 2 7 5 3 6 4 9
		 9 4 3 6 8 2 1 7 5
		 6 7 5 4 9 1 2 8 3
		 1 5 4 2 3 7 8 9 6
		 3 6 9 8 4 5 7 2 1
		 2 8 7 1 6 9 5 3 4
		 5 2 1 9 7 4 3 6 8
		 4 3 8 5 2 6 9 1 7
		 7 9 6 3 1 8 4 5 2)
		 
sudoku3=(1 4 5 3 2 7 6 9 8
		 8 3 9 6 5 4 1 2 7
		 6 7 2 9 1 8 5 4 3
		 4 9 6 1 8 5 3 7 2
		 2 1 8 4 7 3 9 5 6
		 7 5 3 2 9 6 4 8 1
		 3 6 7 5 4 2 8 1 9
		 9 8 4 7 6 1 2 3 5 
		 5 2 1 8 3 9 7 6 4)		 
	

case $(($RANDOM%3+1)) in		        
	"1")           
		sudoku_generate=(${sudoku1[*]})
		;;
	"2")	        
		sudoku_generate=(${sudoku2[*]})
		;;
	"3")             		    
		sudoku_generate=(${sudoku3[*]})
		;;
	*)     
		sudoku_generate=(${sudoku1[*]})
		#continue
		;;
esac					 



# figure_swap 2 8
figure_swap(){
	if [ ${1} -ne ${2} ]	
	then
		for i in {0..80}
		do
			if [ ${sudoku_generate[i]} -eq ${1} ]
			then
				sudoku_generate[i]=0
			fi
		done
		
		for i in {0..80}
		do
			if [ ${sudoku_generate[i]} -eq ${2} ]
			then
				sudoku_generate[i]=${1}
			fi
		done
		
		for i in {0..80}
		do
			if [ ${sudoku_generate[i]} -eq "0" ]
			then
				sudoku_generate[i]=${2}
			fi
		done	
	fi
}



# line_swap 2 3
line_swap(){                
	suduku_line=()          # 9
	if [ ${1} -ne ${2} ]	
	then
		for i in {0..8}
		do
			suduku_line[${i}]=${sudoku_generate[$(((${1}-1)*9+${i}))]}
		done
		
		for i in {0..8}
		do
			sudoku_generate[$(((${1}-1)*9+${i}))]=${sudoku_generate[$(((${2}-1)*9+${i}))]}
		done
		
		for i in {0..8}
		do
			sudoku_generate[$(((${2}-1)*9+${i}))]=${suduku_line[${i}]}
		done
	fi
}


# col_swap 2 3
col_swap(){
	suduku_col=()          # 9
	if [ ${1} -ne ${2} ]	
	then
		for i in {0..8}
		do
			suduku_col[${i}]=${sudoku_generate[$((9*${i}+${1}-1))]}
		done
		
		for i in {0..8}
		do
			sudoku_generate[$((9*${i}+${1}-1))]=${sudoku_generate[$((9*${i}+${2}-1))]}
		done
		
		for i in {0..8}
		do
			sudoku_generate[$((9*${i}+${2}-1))]=${suduku_col[${i}]}
		done
	fi
}



# sudoku_extract 50
sudoku_extract(){
	number=${1}     
	random81=0
	
	if [ ${number} -gt "64" ]	
	then
		number=64
	fi
	
	for((i=1;i<${number};i++))
	do
		random81=$(($RANDOM%81))
		while [ ${sudoku_generate[${random81}]} == "0" ]
		do
			random81=$(($RANDOM%81))
		done
		
		sudoku_generate[${random81}]=0
	done
}



for i in {0..8}
do
	random1=$(($RANDOM%3))
	random2=$(($RANDOM%3))
	random3=$(($RANDOM%3))	
	line_swap $((3*${random1}+${random2}+1)) $((3*${random1}+${random3}+1))

	
	random1=$(($RANDOM%3))
	random2=$(($RANDOM%3))
	random3=$(($RANDOM%3))	
	col_swap $((3*${random1}+${random2}+1)) $((3*${random1}+${random3}+1))

		
	random1=$(($RANDOM%3))
	random2=$(($RANDOM%3))	
	line_swap $((3*${random1}+1)) $((3*${random2}+1))
	line_swap $((3*${random1}+2)) $((3*${random2}+2))
	line_swap $((3*${random1}+3)) $((3*${random2}+3))

	random1=$(($RANDOM%3))
	random2=$(($RANDOM%3))	
	col_swap $((3*${random1}+1)) $((3*${random2}+1))
	col_swap $((3*${random1}+2)) $((3*${random2}+2))
	col_swap $((3*${random1}+3)) $((3*${random2}+3))

		
	random1=$(($RANDOM%9+1))
	random2=$(($RANDOM%9+1))
	figure_swap ${random1} ${random2}  
done

 
sudoku_extract $((32+4*$1))                 

 