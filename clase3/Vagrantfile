# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
  config.vm.box = "ubuntu/focal64"
  config.vm.boot_timeout = 900
  config.vm.synced_folder ".", "/vagrant", disabled: true
  server.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
        # Customize the amount of memory and cpus on the VM:
      vb.memory = 2048
      vb.cpus = 2
    end
  server.vm.hostname = "server"
  server.vm.network "public_network"
  server.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y python3
	  sudo apt-get install -y unzip
	  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	  unzip awscliv2.zip
	  sudo ./aws/install
	  sudo apt install software-properties-common -y
	  sudo add-apt-repository --yes --update ppa:ansible/ansible
	  sudo apt install ansible -y
	  sudo apt-get install python3-pip -y
	  pip3 install boto3
	  pip3 install boto
	  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
          sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com/ $(lsb_release -cs) main"
          sudo apt install terraform
          sudo apt install net-tools
    SHELL
  end  
end
