# This script nicley starts up the ssh-agent and loads any private
# keys of the user. It can handles nicley being called when ssh-agent
# is already running
#
# Author: David Terei
# Last Modified: 11/08/2008

#ssh-agent
SSH_ENV=$HOME/.ssh/environment

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
	echo succeeded
	chmod 600 ${SSH_ENV}
	. ${SSH_ENV} > /dev/null
	/usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	source ${SSH_ENV} > /dev/null
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		start_agent;
	}
else
	start_agent;
fi 

