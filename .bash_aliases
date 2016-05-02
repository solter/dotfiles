alias pdb='python3.4 -m pdb'
alias gitrc='git --git-dir=/home/solter/.configGit --work-tree=/home/solter/'
alias dirTree="find . -maxdepth 4 -name '\.[^.]*' -prune -o -print | sed -e 's/\.\///' -e 's/[^/^|]*\// --- /g' -e 's/---  / |  /g '"
