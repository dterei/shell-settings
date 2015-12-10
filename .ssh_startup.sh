# This script launches a single, persistent ssh-agent process. If one is
# already running, then it simply sets up the current environment correctly to
# use it.
#
# We don't call ssh-add at all as then you are prompted on login to decrypt
# your ssh-keys, which you may never use. Instead, it's better to wrap the ssh
# comand with a check to see if any keys are loaded (`ssh-add -l`) and if not,
# call `ssh-add`. This gives you 'lazy' private key unlocking, which is also
# slightly better for security.
#
# This script provides a similar (but reduced) feature set to keychain.

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

