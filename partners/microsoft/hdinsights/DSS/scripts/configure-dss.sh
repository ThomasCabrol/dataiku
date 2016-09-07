#! /bin/bash
echo "Configuration of DSS on the edge node"

DSS=3.1.2

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

globalUpdate() {
	echo "Updating the machine...";
	sudo su
	gpg --keyserver pgp.mit.edu --recv-keys B9733A7A07513CAD
	gpg -a --export 07513CAD | apt-key add -
	apt-get -y update
	apt-get -y upgrade
	echo "[ERROR] Failed to update the machine globally..."
	exit 132
}

prepareInstall() {
	echo "Preparing the install...";
	sudo su
	mkdir -p /mnt/dataiku
	chown dataiku:dataiku /mnt/dataiku
	echo "[ERROR] Failed to prepare install..."
	exit 133
}

installDSS() {
	echo "Installing DSS...";
	sudo su
	su dataiku
	cd /home/dataiku
	mkdir -p /home/dataiku/installers
	mkdir -p /home/dataiku/installers/dataiku
	cd /home/dataiku/installers/dataiku
	wget http://downloads.dataiku.com/public/studio/3.1.2/dataiku-dss-3.1.2.tar.gz
	tar -xzf dataiku-dss-3.1.2.tar.gz
	rm dataiku-dss-3.1.2.tar.gz
	cd dataiku-dss-3.1.2/
	sudo -i "/home/dataiku/installers/dataiku/dataiku-dss-3.1.2/scripts/install/install-deps.sh" -yes -without-java -with-r
	/home/dataiku/installers/dataiku/dataiku-dss-3.1.2/installer.sh -p 20000 -d /mnt/dataiku/dss-data-dir
	echo "[ERROR] Failed to install DSS..."
	exit 134
}

configureDSS() {
	echo "Configuring DSS...";
	sudo su
	su dataiku
	cd /mnt/dataiku/dss-data-dir
	/mnt/dataiku/dss-data-dir/bin/dssadmin install-hadoop-integration
	/mnt/dataiku/dss-data-dir/bin/dssadmin install-spark-integration
	/mnt/dataiku/dss-data-dir/bin/dssadmin install-h2o-integration
	#/mnt/dataiku/dss-data-dir/bin/dssadmin install-R-integration
	/mnt/dataiku/dss-data-dir/bin/dss start
	echo "[ERROR] Failed to configure DSS..."
	exit 135
}

globalUpdate
prepareInstall
installDSS
configureDSS