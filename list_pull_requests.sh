#! /bin/bash

# Manheim Logistics Coding Exercises: Exercise #1
#
# Organization = SKschoolOfDevOps (I am sorry, I don't know how to query the name of the organizations that a user has access to)
# This script lists all open pull requests for all repositories
# Assuming the values are provided as in the three lines below.
#
GH_HOST=https://github.com/SKschoolOfDevOps/newphpg.git
GH_PAT=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
USER_NAME=SK-GHacctG

# Installing gawk; this should be installed in the docker file if awk/gawk does not come in Ubuntu load in the container
# sudo apt-get update
# sudo apt-get install gawk

# Enabling credential helper (if needed)
# Adding PAT to the credential (This has a security concern; for prod repo, it's not recommended)
#
#git config credential.helper store --global
#echo "https://$USER_NAME:$GH_PAT@github.com" > ~/.git-credentials


# List all repos in an organization 
# using GitHub API
#
curl -L -u "$USER_NAME:$GH_PAT" https://api.github.com/users/SKschoolOfDevOps/repos | grep full_name |\
        awk '/full_name/ {print $2}' |\
        awk '{split($1, arr, "/"); print arr[2]}' |\
        awk '{split($1, arr1, "\""); print arr1[1]}' > /tmp/gh_repos.txt


# list the open pull requests (default state = Open) in the organization
# using GitHub API
#
echo -e "\nThe repositories are, with open pull request : " > /tmp/gh_pulls.txt
while read repo; do
        pr=$(curl -L -u "$USER_NAME:$GH_PAT" https://api.github.com/repos/$USER_NAME/$repo/pulls | grep title)
        if [[ -n "$pr" ]]; then
                echo "Repository = " $repo >> /tmp/gh_pulls.txt
                echo "Pull Request = " $pr >> /tmp/gh_pulls.txt
        fi
done < /tmp/gh_repos.txt

cat /tmp/gh_pulls.txt

echo -e "\n End of the script."
