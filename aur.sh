#/bin/bash

folder="/home/$USER/AUR"



while getopts ":huc" opt; do
	case $opt in
	h)
		echo "usage:"
		echo "  main [options]"
		echo 
		echo "options:"
		echo "  -u         update packages"
		echo "  -c         create folder AUR"

		echo
		;;
	
	u)
		if [ -d "$folder" ]; then
			for dir in $folder/*/; do
				echo "-----------------------------------"
				echo "Atualizando pacote: $dir"
				echo "-----------------------------------"
				echo
				cd "$dir"
				makepkg -si
				cd ..
			done

		else
			echo the folder does not exist!
			exit 1
		fi
		;;
	
	c)	
		if [ -d "$folder" ]; then
			echo the folder exists

		else
			echo Creating folder...
			mkdir $folder

		fi
		;;
	
	# :)
	# 	echo "invalid option! -$OPTARG add argumenets"
	# 	;;

	\?)
		echo "invalid arguments"
		;;
	esac
done
