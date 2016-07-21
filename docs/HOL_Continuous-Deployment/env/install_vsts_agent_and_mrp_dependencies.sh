#!/bin/bash

# Validate input parameters
if [[ !("$#" -eq 4) ]]; 
    then echo "Parameters missing for vsts agent configuration." >&2
    exit 1
fi

# Get parameters
vsts_account_name=$1
vsts_personal_access_token=$2
vsts_agent_name=$3
vsts_agent_pool_name=$4

# Set up variables
vsts_url=https://$vsts_account_name.visualstudio.com

# Install build agent dependencies
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt-get update -y
sudo apt-get install git -y

# Install dotnet core
sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
sudo apt-get update

sudo apt-get install dotnet-dev-1.0.0-preview2-003121 -y



# Set up variables
agent_tar=${agent_url##*/}
agent_folder=/opt/vstsagent
agent_url=https://github.com/Microsoft/vsts-agent/releases/download/v2.103.1/vsts-agent-ubuntu.16.04-x64-2.103.1.tar.gz

# Get installation package
cd /tmp ; wget -q ${agent_url}


# Unpack installation package
sudo mkdir ${agent_folder}
cd ${agent_folder}
sudo tar xzf /tmp/${agent_tar}


# Configure agent
./config.sh configure --url $vsts_url --agent $vsts_agent_name --pool $vsts_agent_pool_name --nostart --acceptteeeula --auth PAT --token $vsts_personal_access_token --unattended

# Configure agent to run as a service
sudo ./svc.sh install
sudo ./svc.sh start
q


## Install PartsUnlimitedMRP dependencies ##
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update

# Install libunwind, libcurl, and libicu
sudo apt-get install -y libunwind8 libcurl3 libicu52 

# Install Gradle, Java, and MongoDB
sudo apt-get install gradle -y
sudo apt-get install openjdk-8-jdk openjdk-8-jre mongodb -y

# Set environment variables for Java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin