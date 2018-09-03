USR="users" && USERN="brute4s99" && PAGE=1
curl "https://api.github.com/$USR/$USERN/repos?page=$PAGE&per_page=100" | grep -e "git_url*" | cut -d \" -f 4 |cut -c 4- | xargs -i git clone "https"{}
