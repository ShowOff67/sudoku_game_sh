
#!/bin/bash


clear                     

COLOR_BLACK="\033[30m"     
COLOR_RED="\033[31m"      
COLOR_GREEN="\033[32m"    
COLOR_YELLOW="\033[33m"    
COLOR_BLUE="\033[34m"      
COLOR_MAGENTA="\033[35m"   
COLOR_CYAN="\033[36m"      
COLOR_DEFAULT="\033[37m"  

LINE_GRREEN="${COLOR_GREEN}|${COLOR_DEFAULT}"   
CROSS_GRREEN="${COLOR_GREEN}+${COLOR_DEFAULT}"  

LAST_LINE=`tput lines`         
LAST_COL=`tput cols`            
#echo "${LAST_LINE}"
#echo "${LAST_COL}"

CURSOR_X=0   
CURSOR_Y=0   

KEY=()       

if [ ! -n "$1" ]       
then
	LEVEL=1
else
	if [ $1 -lt 1 ]  
	then
		LEVEL=1
	elif [ $1 -gt 8 ]  
	then
		LEVEL=8
	else
		LEVEL=$1
	fi
fi


sudoku=()	

source ./generate.sh ${LEVEL}   
sudoku=(${sudoku_generate[*]})	
sudoku_buf=(${sudoku[*]})	   

	

echo -e "   ********************************************************************"
echo -e "   *  ${COLOR_DEFAULT}-------------------------------------                           *"              
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |                           *"              
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|                           *"              
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |                           *"             
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|                           *"            
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |                           *"             
echo -e "   *  |${COLOR_GREEN}---+---+---+---+---+---+---+---+---${COLOR_DEFAULT}|                           *"              
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       * * * * * * * * * * *"              
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|       *                   *"              
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       * Level:    ${LEVEL}/8     *"              
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|       *                   *"             
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       * * * * * * * * * * *"              
echo -e "   *  |${COLOR_GREEN}---+---+---+---+---+---+---+---+---${COLOR_DEFAULT}|       *                   *"              
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       * Timer:            *"            
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|       *                   *"             
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       * * * * * * * * * * *"             
echo -e "   *  ${COLOR_DEFAULT}|---+---+---${CROSS_GRREEN}---+---+---${CROSS_GRREEN}---+---+---|       *                   *"            
echo -e "   *  ${COLOR_DEFAULT}|   |   |   ${LINE_GRREEN}   |   |   ${LINE_GRREEN}   |   |   |       *                   *"           
echo -e "   *  ${COLOR_DEFAULT}-------------------------------------       *                   *"
echo -e "   ********************************************************************"

echo -ne "\033[$((${LAST_LINE}));1H"                            
echo -ne "\033[0m"
echo -ne "\033[7mPress f for finish or q to quit!\033[0m" 



echo -ne "\033[3;9H"        
echo -ne "${COLOR_RED}"
for i in {0..8}             
do
	for j in {0..8}
	do
		echo -ne "\033[$[ $i * 2 + 3 ];$[ $j * 4 + 9 ]H"   	
		if [ ${sudoku[$[ $i * 9 + $j ]]} -ne 0 ]         
		then
			echo -n "${sudoku[$[ $i * 9 + $j ]]}"
		fi								
	done
done
echo -ne "${COLOR_DEFAULT}"
echo -ne "\033[3;9H"       


start=$(date "+%s")  



while :                    
do			
	#read -s -t 1 -n 1 KEY    
	read -s -n 1 KEY    
	case ${KEY[0]} in		   
		"A")           
			CURSOR_X=`expr ${CURSOR_X} - 1`     
			if [ ${CURSOR_X} -lt 0 ]
			then
				CURSOR_X=8
				echo -ne "\033[16B"  
			else
				echo -ne "\033[2A"   
			fi
			;;
		"B")	        
			CURSOR_X=`expr ${CURSOR_X} + 1`  	
			if [ ${CURSOR_X} -gt 8 ]
			then
				CURSOR_X=0
				echo -ne "\033[16A"   
			else
				echo -ne "\033[2B"   
			fi
			;;
		"C")            
			CURSOR_Y=`expr ${CURSOR_Y} + 1`   
			if [ ${CURSOR_Y} -gt 8 ]
			then
				CURSOR_Y=0
				echo -ne "\033[32D"   
			else
				echo -ne "\033[4C"   
			fi
			;;
		"D")            
			CURSOR_Y=`expr ${CURSOR_Y} - 1`   
			if [ ${CURSOR_Y} -lt 0 ]
			then
				CURSOR_Y=8
				echo -ne "\033[32C"  
			else
				echo -ne "\033[4D"   
			fi
			;;
		[0-9])          
			if [ ${sudoku[$[ ${CURSOR_X} * 9 + ${CURSOR_Y} ]]} -eq 0 ]  
			then
				sudoku_buf[$[ ${CURSOR_X} * 9 + ${CURSOR_Y} ]]=${KEY[0]} 
				if [ ${KEY[0]} -eq 0 ]
				then
