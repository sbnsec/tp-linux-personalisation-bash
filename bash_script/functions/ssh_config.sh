#!/bin/bash

setup_ssh_config () {
  figlet "SSH"
  echo -e "${BLUE}Configuration de SSH${NC}"

  # Create the .ssh directory if it does not exist
  echo -e "${BLUE}Creation du repertoire .ssh s'il n'existe pas...${NC}"
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"

  # Add public key to authorized_keys
  echo "Ajout de la clé publique dans authorized_keys..."
  touch $SSH_DIR/authorized_keys
  echo "$PUBLIC_KEY" > "$SSH_DIR/authorized_keys"
  chmod 600 "$SSH_DIR/authorized_keys"
  chown gon:gon $SSH_DIR/authorized_keys

  # Disable password authentication
  echo -e "${BLUE}Desactiver l'authentification par mot de passe...${NC}"
  sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' "$SSH_CONFIG_FILE"

  # Disable root login via SSH
  echo -e "${BLUE}Desactiver login root ssh...${NC}"
  sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG_FILE"

  # Disable root login via SSH
  echo -e "${BLUE}Autoriser authentification par clé publique...${NC}"
  sed -i 's/^#PubkeyAuthentication yes.*/PubkeyAuthentication yes/' "$SSH_CONFIG_FILE"
  
  # Construct AllowUsers directive from the allowed IPs
  ALLOW_USERS=""
  for ip in "${ALLOWED_IPS[@]}"; do
      ALLOW_USERS+="AllowUsers $TARGET_USER@$ip\n"
  done

  # Append the new AllowUsers directive to the SSH configuration
  echo -e "$ALLOW_USERS" >> "$SSH_CONFIG_FILE"

  # Restart the SSH service to apply changes
  echo -e "${BLUE}Redemarrer le service ssh...${NC}"
  systemctl restart sshd

  echo -e "${GREEN}Configuration de SSH terminée...${NC}"

}