# Profile
#
# Designed to be shared among different shells and computers
#
# All things should mostly go in .shenv, but sadly some
# setting such as umask cant
#
# Author: David Terei

# All else in .shenv to share between shells and get around
# normal stupid unix bashrc/profile loading issues.
if [ -n "${BASH_VERSION}" ]; then
	source ~/.bashrc
elif [ -n "${ZSH_VERSION}" ]; then
	source ~/.zshrc
fi

export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
