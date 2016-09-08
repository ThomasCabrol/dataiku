#! /bin/bash

#===================================================#
# Configuration of DSS on the edge node				#
#===================================================#

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Global update of the machine
gpg --keyserver pgp.mit.edu --recv-keys B9733A7A07513CAD
gpg -a --export 07513CAD | apt-key add -
apt-get -y update
apt-get -y upgrade

# Preparing the install 
mkdir -p /mnt/dataiku
chown dataiku:dataiku /mnt/dataiku

# Downloading DSS
mkdir -p /home/dataiku/installers
mkdir -p /home/dataiku/installers/dataiku
chown -R dataiku:dataiku /home/dataiku
sudo -u dataiku sh -c "wget http://downloads.dataiku.com/public/studio/3.1.2/dataiku-dss-3.1.2.tar.gz -P /home/dataiku/installers/dataiku/"
sudo -u dataiku sh -c "cd /home/dataiku/installers/dataiku/ ; tar -xzf dataiku-dss-3.1.2.tar.gz ; rm dataiku-dss-3.1.2.tar.gz"
sudo -i "/home/dataiku/installers/dataiku/dataiku-dss-3.1.2/scripts/install/install-deps.sh" -yes -without-java -with-r
sudo -u dataiku sh -c "/home/dataiku/installers/dataiku/dataiku-dss-3.1.2/installer.sh -p 20000 -d /mnt/dataiku/dss-data-dir"

# Configuring & starting DSS
sudo -u dataiku sh -c "/mnt/dataiku/dss-data-dir/bin/dssadmin install-hadoop-integration"
sudo -u dataiku sh -c "/mnt/dataiku/dss-data-dir/bin/dssadmin install-spark-integration"
sudo -u dataiku sh -c "/mnt/dataiku/dss-data-dir/bin/dssadmin install-h2o-integration"
sudo -u dataiku sh -c "/mnt/dataiku/dss-data-dir/bin/dss start"
