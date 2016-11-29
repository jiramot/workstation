set -e

SOURCE_DIR=`dirname "${BASH_SOURCE[0]}"`

# Smoketest environment
if [[ `which brew` ]]; then
  echo "OK Found brew!"
else
  echo "Please install brew first."
  echo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

# Installing most important package
if [[ `which ansible` ]]; then
  echo "Ansible is already installed"
else
  echo "INFO Installing ansible..."
  if [[ $OSTYPE == darwin* ]]; then
    brew install ansible
  else
    sudo add-apt-repository -y ppa:rquillo/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
  fi
fi

# Run ansible
echo "INFO Execute ansible playbook"
ansible-playbook -i ${SOURCE_DIR}/hosts.ini -K ${SOURCE_DIR}/playbook.yml $*
