#!/bin/bash

install_packages () {
  echo -e "${CYAN}Packages - Installing mandatory packages...${NC}"
  apt update
  apt install -y curl figlet sl ufw git tmux libpam-google-authenticator aide
  echo -e "${GREEN}Packages - Mandatory packages installed correctly${NC}"
}