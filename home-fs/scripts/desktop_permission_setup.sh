#!/bin/bash
# this file runs from permission_setup.sh only if we are running in a graphical setting

#give pinta home directory access
sudo flatpak override com.github.PintaProject.Pinta --filesystem=~/ && echo "pinta permissions added"
