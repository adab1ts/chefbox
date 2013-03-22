# File: $DOTFILES_PATH/bash/aliases.d/misc.bal


alias reloadb='source ~/.bashrc'
alias reloadz='source ~/.zshrc'
alias %='zsh'

# Open files
alias opn='xdg-open'        # opn file

# Env variables
alias env='env | sort'

# Env aliases
alias als='alias -p'

# Memory load
alias mem='free -m'

# Disk use
alias dsk="df -h | grep --color=never '^\/dev\/.*' | sort"

# Manual Pages
alias sman='apropos -l -r'    # sman search_pattern

# Software Management
alias pfb='sudo find /* -regextype posix-egrep -regex "^/(proc|dev|sys|tmp|media|mnt)" -prune -o -print | tee ~/files_before.txt'
alias pfa='sudo find /* -regextype posix-egrep -regex "^/(proc|dev|sys|tmp|media|mnt)" -prune -o -print | tee ~/files_after.txt'
alias ifl='diff ~/files_before.txt ~/files_after.txt | sed "/files_after[.]txt/d" | sed "/^[\w-]/d" | sed "/^</d" | sed "s/> //" | sort | tee ~/installed_files.list ; rm ~/files_before.txt ~/files_after.txt'
alias ufl='diff ~/files_before.txt ~/files_after.txt | sed "/files_after[.]txt/d" | sed "/^[\w-]/d" | sed "/^>/d" | sed "s/< //" | sort | tee ~/uninstalled_files.list ; rm ~/files_before.txt ~/files_after.txt'

# System Information
alias ski='uname -a'
alias svi='lsb_release -a'

# File System
# Use 'blkid -o value -s UUID' to print the universally unique identifier for a device;
alias bid+='sudo blkid'       # blkid dev
alias fu+='sudo fuser -vcu'   # fuser dev
alias fuk+='sudo fuser -vki'  # fuser file
alias du+='sudo du -sh'       # du file|folder

