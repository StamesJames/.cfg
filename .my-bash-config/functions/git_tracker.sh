git_tracker () {
    if [ ! -d ~/.git_tracker/ ] 
    then 
        echo "~/.git_tracker/ dictionary does not exist so I create it"
        mkdir ~/.git_tracker
    fi

    if [ ! -f ~/.git_tracker/repos_to_track ] 
    then 
        echo "~/.git_tracker/repos_to_track does not exists so I create it"
        touch ~/.git_tracker/repos_to_track
        echo "\n\n" >> ~/.git_tracker/repos_to_track
    fi

    if [ "$1" == "track" ]
    then
        p=`realpath ${2}`
        echo "$p"
        if [ ! -d $p ]
        then 
            echo "path is no dictionary"
            return
        elif ! git -C "${p}" status &>/dev/null 
        then 
            echo "path is no git repo"
            return
        elif git -C "${p}" status &>/dev/null
        then
            echo "writing $p to tracked repos"
            echo ${p} >> ~/.git_tracker/repos_to_track
        fi
    fi 
    if [ "$1" == "check" ]
    then
        count=0

        while IFS= read -r p; do
            if [ ! -z "${p}" ] 
            then
                echo "############"
                p=`realpath $p`
                echo "${p}"
                if [[ ! -d $p ]]
                then 
                    echo "${p} is no dictionary"
                    return
                elif ! git -C ${p} status &>/dev/null
                then
                    echo "$p is not an git repo"
                    returns
                elif git -C "${p}" status &>/dev/null
                then 
                    echo "found repo $p"
                    let "count += 1"
                fi
            fi
        done < ~/.git_tracker/repos_to_track
        echo "############"

        file="~/testotest/"
        if [ -d $file ]
        then
            echo "testotest is a dict"
        fi

        file="~/testotest/"
        if echo $file | git status &>/dev/null
        then
            echo "testotest is a repo"
        fi

        echo "tracked $count repos"
    fi
}