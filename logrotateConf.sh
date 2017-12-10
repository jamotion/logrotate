#!/bin/bash
#
# Helper functions for manipulating logrotate configurationsfile

function createLogrotateConfigurationEntry() {
  local file="$1"
  local file_user="$2"
  local file_owner="$3"
  local conf_copies="$4"
  local conf_logfile_compression="$5"
  local conf_logfile_compression_delay="$6"
  local conf_logrotate_interval="$7"
  local conf_logrotate_size="$8"
  local conf_dateformat="$9"
  local new_log=
  new_log=${file}" {"
  new_log=${new_log}"\n  su ${file_owner_user} ${file_owner_group}"
  new_log=${new_log}"\n  copytruncate"
  new_log=${new_log}"\n  rotate ${conf_copies}"
  new_log=${new_log}"\n  missingok"
  if [ -n "${conf_logfile_compression}" ]; then
    new_log=${new_log}"\n  ${conf_logfile_compression}"
  fi
  if [ -n "${conf_logfile_compression_delay}" ]; then
    new_log=${new_log}"\n  ${conf_logfile_compression_delay}"
  fi
  if [ -n "${conf_logrotate_interval}" ]; then
    new_log=${new_log}"\n  ${conf_logrotate_interval}"
  fi
  if [ -n "${conf_logrotate_size}" ]; then
    new_log=${new_log}"\n  ${conf_logrotate_size}"
  fi
  if [ -n "${conf_dateformat}" ]; then
    new_log=${new_log}"\n  dateext\n  dateformat ${conf_dateformat}"
  fi
  new_log=${new_log}"\n}"
  echo -e $new_log
}

function insertConfigurationEntry()
{
  local config=$1
  local config_file=$2

  cat >> $config_file <<_EOF_
${config}
_EOF_
}