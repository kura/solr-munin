#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "install lxml"
apt-get --assume-yes --quiet install python-lxml
echo "done"
echo "chmod"
chmod +x solr_*
echo "done"
echo "chown"
chown root:root solr_*
echo "done"
echo "move"
mv solr_* /usr/share/munin/plugins/
echo "done"
echo "symlink"
ln -s /usr/share/munin/plugins/solr_docs /etc/munin/plugins/solr_docs
ln -s /usr/share/munin/plugins/solr_documentcache /etc/munin/plugins/solr_documentcache
ln -s /usr/share/munin/plugins/solr_filtercache /etc/munin/plugins/solr_filtercache
ln -s /usr/share/munin/plugins/solr_qps /etc/munin/plugins/solr_qps
ln -s /usr/share/munin/plugins/solr_querycache /etc/munin/plugins/solr_querycache
ln -s /usr/share/munin/plugins/solr_querytime /etc/munin/plugins/solr_querytime
ln -s /usr/share/munin/plugins/solr_updates /etc/munin/plugins/solr_updates
echo "done"
echo "restart munin-node"
/etc/init.d/munin-node restart
echo "done"
exit 0
