
#! /bin/bash

merge(){
	git checkout $2
	git merge --no-ff $1
	git push origin $2
	echo "Merged $1 to $2 successfully!"
	echo ""
	echo "............................."
	read -p "Do you want to merge with the master? (y/n) _" -n 1 -r
	echo
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			git checkout master
			git merge --no-ff $2
			git push origin master
			echo "Operation Complete!"
			echo ""
			echo "..................."
		fi
	echo "Job done, exiting!"
	exit 0
}

check_branch() {
	echo "Input branches are $1 and $2"
	echo "Work dir is `pwd`"
	git checkout $1
	git checkout $2
	if [ git branch --list $1 ]; then
		echo "Merging $1 with $2 ..."
		merge $1 and $2
	else
		echo "Branch ($1) doesn't exist. Exiting now..."
		exit 1
	fi
	
}

for arg in "$@"

do
	if [ $arg = "-h" ] || [ $arg = "-help" ]; then
		echo "# ---> User Interactive"
		echo "Usage: ./git_merge.sh"
		echo "OR"
		echo "# ---> Direct input"
		echo "Usage: ./git_merge.sh <Source branch> <Destination branch> <Repo URL>"
		exit 0
	fi
done

check_branch()
	
