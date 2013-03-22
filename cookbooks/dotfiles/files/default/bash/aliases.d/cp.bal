# File: $DOTFILES_PATH/bash/aliases.d/cp.bal


# @@CMD: cp
#	Command: cp [OPTION]... SOURCE... DIRECTORY
#
#	Parameters:
#	  -v	explain what is being done
#	  -d	preserve link attributes but never follow symbolic links in SOURCE
#	  -p	preserves mode,ownership,timestamps
#	  -R	copy directories recursively
#	  --parents	use full source file name under DIRECTORY"
#
#	Aliases:
#	  cp[+]	  => [sudo] cp -vd
#	  cp2[+]  => [sudo] cp -vdp
#	  cpr[+]  => [sudo] cp -vdR
#	  cp2r[+] => [sudo] cp -vdpR
#	  cpf[+]  => [sudo] cp -vd --parents
# @@END

alias cp='cp -vd'
alias cp2='cp -vdp'
alias cpr='cp -vdR'
alias cp2r='cp -vdpR'
alias cpf='cp -vd --parents'

alias cp+='sudo cp -vd'
alias cp2+='sudo cp -vdp'
alias cpr+='sudo cp -vdR'
alias cp2r+='sudo cp -vdpR'
alias cpf+='sudo cp -vd --parents'

