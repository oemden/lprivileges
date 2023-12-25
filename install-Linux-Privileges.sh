#!/bin/bash
# Linux Privileges - Install
# ------------------------------------------------------------
Version_main=1.0
version_script=1.1
# ------------------------------------------------------------
base_name=$(basename ${0})
read_link=$(readlink -f "${0}")
dir_name=$(dirname ${read_link})
my_date=$(date)
display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"
#exec_user=$(ps aux | grep $0 | awk '{ print $1 }' | uniq)
exec_user="$(logname)"
uid_d=$(id -u ${exec_user})

echo $dir_name
cd "${dir_name}" ; pwd
# ------------------------------------------------------------
echo "Importing source .conf files"
lrpivileges_global_conf=${dir_name}/etc/lprivileges.global.conf ## Import Before Custom Conf
lrpivileges_conf=${dir_name}/etc/lprivileges.conf  ## Import After GLobal Conf
# ------ Import Parameters -----------------------------------
source "${lrpivileges_global_conf}"
source "${lrpivileges_conf}"
# ------------------------------------------------------------
clear

function check_sudo {
	if [[ "$EUID" -ne 0 ]] ; then
	 echo "must be run as root"
	 exit 1
	fi
}

function log_lprivileges_install {
	echo "$1" | tee -a ${log_file_install}
}

function create_dirs {
	mkdir -p ${icon_dir} ${conf_dir} ${log_dir} ${icon_corp_dir_conf} ${requests_dir}
	echo "createdir"
	echo ${icon_dir} ; ls -l ${icon_dir}
	echo ${conf_dir} ; ls -l ${conf_dir}
	echo ${log_dir} ; ls -l ${log_dir}
	chown root:staff ${requests_dir}/* # root & staff can write
	chmod -R 665 ${requests_dir}/* # Everyone & staff can write
}

function touch_logfiles {
	mkdir -p ${log_dir}
	touch ${log_file_install} ${log_file}
	log_lprivileges_install "${my_date} | Installing Linux Privileges"
	log_lprivileges_install "${my_date} | create ${log_dir}"
	log_lprivileges_install "${my_date} | create ${log_file_install}"
	log_lprivileges_install "${my_date} | create ${log_file}"
	chown root:root ${log_file_install} # all for root only
	chmod -R 700 ${log_file_install} # all for root only
	chown root:staff ${log_file}  # all for root and users
	chmod -R 770 ${log_file} # all for root and users
	
	ls -l ${log_file}
	ls -l ${log_file_install}
}

function install_dep {
	apt update
	#apt install remind at yad -y
	apt install at -y
}

function copy_files {
	# icons
	log_lprivileges_install "${my_date} copying lprivileges icons"
	cp ./icons/* ${icon_dir}/
	# chown & chmod
	chown root:root ${icon_dir} # all for root only
	chmod -R 655 ${icon_dir} # all for root only

	log_lprivileges_install "${my_date} copying Custom Corporate Icon"
	#if [[ -d "./icons_corporate/" ]] ; then 
		cp ./icons_corporate/* "${icon_corp_dir_conf}"
		chown root:staff ${icon_corp_dir_conf}/* # Everyone can read, only owner can write
		chmod -R 655 ${icon_corp_dir_conf}/* # Everyone can read, only owner can write
	#fi

	# systemd daemons
	log_lprivileges_install "${my_date} copying lprivileges systemd services"
	cp ./daemons/* ${daemons_dir}/
	chown root:root ${daemons_dir}/lprivileges* # Everyone can read, only owner can write
	chmod -R 644 ${daemons_dir}/lprivileges* # Everyone can read, only owner can write

	# config
	log_lprivileges_install "${my_date} copying lprivileges conf file"
	cp ./etc/* ${conf_dir}/
	chown root:root ${conf_dir}/* # write for root only
	chmod -R 644 ${conf_dir}/* # write for root only
	
	# bin
	log_lprivileges_install "${my_date} copying lprivileges executables"
	cp ./bin/* ${scripts_dir}/
	chown root:root ${scripts_dir}/lprivileges* # all for root only - exec others
	chmod -R 755 ${scripts_dir}/lprivileges* # all for root only - exec others

}

function load_daemons {
	pause 5
	log_lprivileges_install "${my_date} loading lprivileges Daemons"
	systemctl daemon-reload
#	systemctl start "${daemons_dir}/lprivileges.*"
	log_lprivileges_install "${my_date} enabling services"
	systemctl enable --now "${daemons_dir}"/lprivileges.*
	systemctl enable --now atd
}

function lprivileges_DesktopApp_create() {
	log_lprivileges_install "$(date) Creating lprivileges App Shorcut. ${app_dir}/${app_name}"

cat <<EOF > /usr/share/applications/linux-privileges.desktop
#!/usr/bin/env xdg-open

[Desktop Entry]
Type=Application
Terminal=true
Name="Linux Privileges"
Icon=/usr/local/share/icons/lprivileges/lprivileges_icon_locked.png
Exec=/usr/local/bin/lprivilegesreq
EOF

}

function do_it {
	echo
	check_sudo
	touch_logfiles
	create_dirs
	copy_files
	install_dep
	lprivileges_DesktopApp_create
	load_daemons
}

echo "---"
do_it
echo "---"

exit 0

