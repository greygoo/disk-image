#!/bin/sh

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

Main() {
        InstallAnsible
        RunAnsiblePlaybooks
} # Main

InstallAnsible()
{
        echo "Installing ansible"
        yes | DEBIAN_FRONTEND=noninteractive apt-get -yqq install ansible
} # InstallAnsible

RunAnsiblePlaybooks()
{
        echo "Running playbooks"
        ansible-playbook ansible/playbooks/*
} # RunAnsiblePlaybooks

Main "$@"
