# This script nicley starts up the ssh-agent and loads any private
# keys of the user. It can handles nicley being called when ssh-agent
# is already running
#
# Author: David Terei
# Last Modified: 11/08/2008

#ssh-agent
SSH_ENV=$HOME/.ssh/environment
TIMEOUT=3600

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent -t ${TIMEOUT} > ${SSH_ENV}
	chmod 600 ${SSH_ENV}
	source ${SSH_ENV} > /dev/null
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	source ${SSH_ENV} > /dev/null
	ps -p ${SSH_AGENT_PID} | grep ssh-agent > /dev/null || {
		start_agent;
	}
else
	start_agent;
fi 

