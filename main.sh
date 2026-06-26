#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


echo -e "${CYAN}==============================${NC}"
echo -e "${YELLOW}       SELECT AN OPTION       ${NC}"
echo -e "${CYAN}==============================${NC}"
echo -e "  ${GREEN}[1]${NC} Terminate running server - 1"
echo -e "  ${GREEN}[2]${NC} Start server - 2"
echo -e "${CYAN}==============================${NC}"
read -rp "Enter your choice: " choice

case "$choice" in
    1)
        echo -e "\n${RED}[+] STOPPING SERVER 1...${NC}"

        bash ./killserver.sh
        ;;
    2)
        echo -e "\n${GREEN}[+] STARTING SERVER 2...${NC}"

        bash ./autostart.sh
        ;;
    *)
        echo -e "\n${YELLOW}[!] Invalid choice: '$choice'. Please enter 1 or 2.${NC}"
        exit 1
        ;;
esac
