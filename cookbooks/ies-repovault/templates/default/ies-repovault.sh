#!/bin/bash

if [ -e "/etc/redhat-release" ]; then
	find /etc/yum.repos.d/ -name "rhel*" -o -name "redh*" -o -name "plk*" -o -name "chopin*" | xargs sed -i 's/enabled=1/enabled=0/g'
	cat << EOF > /etc/yum.repos.d/ies-repovault.repo
[ies-repovault]
name=ies-repovault
baseurl=http://ies-repovault.ies.mentorg.com/repovault/rhel/`lsb_release -rs`/os/`uname -i`/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF


  cat << EOF > /etc/yum.repos.d/ies-repopatch.repo
[ies-repopatch]
name=ies-repopatch
baseurl=http://ies-repovault.ies.mentorg.com/repovault/rhel/patch/`lsb_release -rs | cut -f1 -d.`/os/`uname -i`/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF


yum clean all
fi

if [ -e "/etc/SuSE-release" ]; then
	version=`cat /etc/SuSE-release| grep 'VERSION'| sed -e 's/VERSION\s*=\s*//g'`
	patchlevel=`cat /etc/SuSE-release| grep 'PATCHLEVEL'| sed -e 's/PATCHLEVEL\s*=\s*//g'`
	if [ "$patchlevel" = "" ]; then
		patchlevel="0"
	fi

	rpm --import http://ies-repovault.ies.mentorg.com/repovault/repomd.xml.key
	
	if [ "$version" -gt "10" ]; then
		zypper modifyservice -d -l
		zypper addservice -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/server/$version.$patchlevel/`uname -i`/ ies-repovault-SLES$version.$patchlevel-`uname -i`
		zypper addservice -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/sdk/$version.$patchlevel/`uname -i`/ ies-repovault-SDK$version.$patchlevel-`uname -i`
	else
		if [ -e "/usr/bin/zypper" ]; then
			zypper service-delete "cd:///?devices=/dev/sr0"
			zypper service-add -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/server/$version.$patchlevel/`uname -i`/ ies-repovault-SLES$version.$patchlevel-`uname -i`
			zypper service-add -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/sdk/$version.$patchlevel/`uname -i`/ ies-repovault-SDK$version.$patchlevel-`uname -i`
		fi
		rug unsubscribe -a
		rug service-delete 1
		rug service-add -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/server/$version.$patchlevel/`uname -i`/ ies-repovault-SLES$version.$patchlevel-`uname -i`
		rug subscribe ies-repovault-SLES$version.$patchlevel-`uname -i`
		rug service-add -t YUM http://ies-repovault.ies.mentorg.com/repovault/sle/sdk/$version.$patchlevel/`uname -i`/ ies-repovault-SDK$version.$patchlevel-`uname -i`
		rug subscribe ies-repovault-SDK$version.$patchlevel-`uname -i`
	fi
fi

