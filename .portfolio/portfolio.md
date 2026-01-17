---
title: "TP Linux - Personnalisation Bash"
description: "Bash: Automatisation, durcissement SSH/Firewall (UFW) et personnalisation Linux."
date: "2024-10-25"
tags: ["bash","linux","security","cli","automation"]
lang: "fr"

# Configuration techStack
techStack:
  - name: "Bash"
    category: "language"
    icon: "🖥️"
  - name: "Linux / Debian"
    category: "infra"
    icon: "🐧"
  - name: "OpenSSH"
    category: "security"
    icon: "🔐"
  - name: "UFW"
    category: "network"
    icon: "🔥"
  - name: "AIDE / Tripwire"
    category: "tool"
    icon: "🛡️"
  - name: "Vim / Nano"
    category: "tool"
    icon: "📝"

# Architecture du projet
architecture:
  overview: "Ce projet utilise une architecture modulaire basée sur Bash pour l'automatisation du système. Un script principal orchestre l'ensemble des configurations en sourçant des fonctions dédiées au durcissement de SSH, à la configuration du pare-feu (UFW), et à l'optimisation de l'environnement utilisateur. Cette modularité garantit un déploiement fiable et une séparation claire des responsabilités, le tout visant à transformer une installation Debian brute en un système sécurisé et productif."
  components:
    - "Script Principal (setup.sh) : Le point de lancement. Il gère l'exécution séquentielle des fonctions, la vérification des droits (root), et la gestion des logs/erreurs."
    - "Fonctions de Durcissement SSH : Bloc de code qui automatise la modification de /etc/ssh/sshd_config pour désactiver l'authentification par mot de passe, limiter le root login, et mettre en place une liste blanche IP."
    - "Configuration du Pare-feu (UFW) : Bloc de code qui installe, active, et configure UFW (ou iptables) avec une politique par défaut de DENY et une ouverture sélective des ports (SSH, HTTP, HTTPS)."
    - "Gestion des Dotfiles (.bashrc, .vimrc) : Bloc de code qui copie les fichiers de personnalisation (alias, fonctions, prompt PS1 avancé) dans le répertoire ~/ de l'utilisateur."
    - "Scripts d'Automatisation (Scripts Modulaires) : Fichiers Bash externes au script principal contenant des fonctions spécifiques (ex: mise à jour automatique des paquets de sécurité, synchronisation rsync)."

# Diagrammes d'architecture (optionnel)
diagrams:
  - path: "https://raw.githubusercontent.com/xAMA0x/tp-linux-personalisation-bash/main/.portfolio/diagrams/Mermaid Chart - Create complex, visual diagrams with text.-2025-11-02-190905.svg"
    title: "Architecture Bash (Flux de Hardening)"
    description: "Flux séquentiel du script d'automatisation pour le durcissement du système."

# URLs et liens
demo_url: ""
demo_label: ""
github_url: "https://github.com/xAMA0x/tp-linux-personalisation-bash"
---

## 🎯 Vue d'ensemble

<div class="overview-hero dark:bg-gradient-to-br dark:from-accent/10 dark:to-purple-900/10 bg-gradient-to-br from-indigo-50 to-purple-50 border dark:border-accent/20 border-indigo-200 rounded-2xl p-8 my-8 shadow-lg">
  <p class="text-lg dark:text-white/90 text-slate-700 leading-relaxed mb-6">
    Ce TP est une boîte à outils <strong>Bash</strong> complète pour le <strong>durcissement sécuritaire</strong> et l'optimisation de Debian. Il automatise les configurations critiques (SSH, UFW, gestion des clés) tout en permettant une <strong>personnalisation profonde</strong> de l'environnement de travail. Le projet démontre une approche <strong>DevOps</strong> essentielle pour tout administrateur système, transformant l'installation de base en un hôte fiable et productif.
  </p>
  
  <div class="stats-row grid grid-cols-2 md:grid-cols-4 gap-4 mt-6">
    <div class="stat-item text-center">
      <div class="stat-value text-3xl font-bold dark:text-accent text-indigo-600">5+</div>
      <div class="stat-label text-sm dark:text-white/60 text-slate-600">Axes de durcissement</div>
    </div>
    <div class="stat-item text-center">
      <div class="stat-value text-3xl font-bold dark:text-accent text-indigo-600">1</div>
      <div class="stat-label text-sm dark:text-white/60 text-slate-600">Script d'automatisation principal</div>
    </div>
    <div class="stat-item text-center">
      <div class="stat-value text-3xl font-bold dark:text-accent text-indigo-600">8+</div>
      <div class="stat-label text-sm dark:text-white/60 text-slate-600">Fonctions et Alias personnalisés</div>
    </div>
    <div class="stat-item text-center">
      <div class="stat-value text-3xl font-bold dark:text-accent text-indigo-600">100%</div>
      <div class="stat-label text-sm dark:text-white/60 text-slate-600">Outils natifs (Bash, UFW, OpenSSH)</div>
    </div>
  </div>
</div>

### Objectifs du projet

<div class="objectives-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 my-8">
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      🎓
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Validation des Compétences Linux
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Réaliser le TP de 3ème année (ESGI) pour valider la maîtrise de l'environnement Linux, de la configuration système, et des outils de sécurité essentiels.
    </p>
  </div>
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      🛡️
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Durcissement du Périphérique (Hardening)
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Sécuriser la machine de manière proactive en appliquant des bonnes pratiques critiques (SSH sans mot de passe, désactivation du root login, configuration d'un pare-feu).
    </p>
  </div>
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      ⚙️
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Automatisation Modulaire (Bash)
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Développer un script Bash principal capable de centraliser et d'exécuter l'ensemble des configurations de manière fiable, en utilisant la modularité des fonctions.
    </p>
  </div>
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      🔥
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Contrôle du Flux Réseau (UFW)
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Installer et configurer le pare-feu UFW pour appliquer une politique de whitelisting stricte, bloquant tout le trafic entrant par défaut.
    </p>
  </div>
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      🖥️
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Ergonomie et Productivité CLI
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Personnaliser l'environnement de travail de l'utilisateur (dotfiles, alias, prompt PS1 avancé) pour améliorer l'efficacité et le confort en ligne de commande.
    </p>
  </div>
  <div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 hover:scale-105 transition-all duration-300 hover:shadow-xl">
    <div class="icon-wrapper text-4xl mb-4 flex items-center justify-center w-16 h-16 rounded-full dark:bg-white/10 bg-slate-100 mx-auto">
      🔑
    </div>
    <h3 class="text-lg font-semibold mb-2 dark:text-white text-slate-900 text-center">
      Sécurité Post-Configuration
    </h3>
    <p class="text-sm dark:text-white/70 text-slate-600 text-center leading-relaxed">
      Intégrer des outils de sécurité avancés (AIDE/Tripwire ou l'automatisation des mises à jour) pour maintenir un haut niveau de sécurité dans le temps.
    </p>
  </div>
</div>

## 🔐 Durcissement SSH & Authentification

<div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 my-8">
  <p class="text-sm dark:text-white/70 text-slate-600 leading-relaxed mb-4">
    Cette section gère les configurations critiques du service <strong>OpenSSH</strong>. Le script automatise la modification du fichier <code>/etc/ssh/sshd_config</code> pour imposer des politiques de connexion robustes, et gère les clés d'accès.
  </p>
  <ul class="list-disc list-outside space-y-2 pl-5 text-sm dark:text-white/70 text-slate-600">
    <li><strong>Authentification par clé forcée :</strong> Désactivation complète de <code>PasswordAuthentication yes</code> au profit de <code>PubkeyAuthentication yes</code>.</li>
    <li><strong>Clé SSH :</strong> Automatisation de la copie de la clé publique de l'utilisateur dans <code>~/.ssh/authorized_keys</code>, avec application des permissions <code>600</code>.</li>
    <li><strong>Restriction d'accès :</strong> Désactivation du <code>PermitRootLogin</code> et restriction des utilisateurs/groupes autorisés (via <code>AllowUsers</code> ou <code>AllowGroups</code>).</li>
    <li><strong>Liste Blanche IP :</strong> Implémentation d'une fonction Bash pour ajouter des adresses IP ou des plages spécifiques au <i>whitelisting</i> SSH.</li>
    <li><strong>Redémarrage :</strong> Redémarrage du service SSH (<code>systemctl restart sshd</code>) après modification pour prendre en compte les nouvelles règles de sécurité.</li>
  </ul>
</div>

## 🔥 Sécurité Réseau et Firewall (UFW)

<div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 my-8">
  <p class="text-sm dark:text-white/70 text-slate-600 leading-relaxed mb-4">
    Le script automatise l'installation et la configuration du pare-feu <strong>UFW</strong> (Uncomplicated Firewall) pour établir un périmètre de sécurité strict autour de la machine. L'objectif est d'appliquer le principe du <strong>moindre privilège réseau</strong> et d'éviter l'exposition inutile des services.
  </p>
  <ul class="list-disc list-outside space-y-2 pl-5 text-sm dark:text-white/70 text-slate-600">
    <li><strong>Installation et Activation :</strong> Installation conditionnelle de <code>ufw</code> et activation immédiate via <code>ufw enable</code>.</li>
    <li><strong>Politique par défaut stricte :</strong> Définition des règles par défaut à <code>ufw default deny incoming</code> et <code>ufw default allow outgoing</code>.</li>
    <li><strong>Ouverture sélective :</strong> Autorisation uniquement des ports essentiels, typiquement SSH (port non-standard), HTTP et HTTPS.</li>
    <li><strong>Gestion des règles :</strong> Utilisation de fonctions Bash pour ajouter des règles spécifiques (par port ou par service) et vérifier l'état du pare-feu.</li>
  </ul>
</div>

## 🖥️ Modularité Bash & Personnalisation CLI

<div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 my-8">
  <p class="text-sm dark:text-white/70 text-slate-600 leading-relaxed mb-4">
    Ce volet du TP se concentre sur l'amélioration de l'expérience utilisateur et la <strong>modularité du code</strong>. Le script est conçu pour être facilement maintenable et le shell de l'utilisateur est optimisé pour les tâches d'administration et de développement.
  </p>
  <ul class="list-disc list-outside space-y-2 pl-5 text-sm dark:text-white/70 text-slate-600">
    <li><strong>Modularité Bash :</strong> Le script principal est un orchestrateur qui utilise la commande <code>source</code> pour charger des fonctions spécifiques depuis des fichiers modulaires (ex: <code>ssh_hardening.sh</code>, <code>ufw_config.sh</code>).</li>
    <li><strong>Alias de Commandes :</strong> Ajout d'alias dans <code>.bash_aliases</code> pour les commandes fréquentes ou longues (ex: <code>alias ll='ls -lha'</code> ou un alias pour la mise à jour).</li>
    <li><strong>Prompt Personnalisé (PS1) :</strong> Modification du prompt Bash pour inclure des informations essentielles (répertoire courant, état Git) via la variable <code>$PS1</code>.</li>
    <li><strong>Gestion des Dotfiles :</strong> Automatisation de la copie et de la sauvegarde des fichiers de configuration utilisateur (<code>.bashrc</code>, <code>.vimrc</code>, <code>.gitconfig</code>).</li>
    <li><strong>Synchronisation :</strong> Intégration de scripts pour la synchronisation automatique de répertoires avec <code>rsync</code>.</li>
  </ul>
</div>

## 🛡️ Sécurité Post-Configuration

<div class="objective-card dark:bg-white/5 bg-white/80 backdrop-blur-md border dark:border-white/10 border-slate-200 rounded-xl p-6 my-8">
  <p class="text-sm dark:text-white/70 text-slate-600 leading-relaxed mb-4">
    Cette section va au-delà de la configuration initiale et se concentre sur la **maintenance sécuritaire** et la détection d'anomalies, couvrant ainsi les aspects les plus avancés du TP.
  </p>
  <ul class="list-disc list-outside space-y-2 pl-5 text-sm dark:text-white/70 text-slate-600">
    <li><strong>Mise à jour automatique :</strong> Configuration du système (via <code>unattended-upgrades</code> ou un script Cron) pour télécharger et installer automatiquement les correctifs de sécurité.</li>
    <li><strong>Détection d'Intégrité :</strong> Mise en place d'un outil de vérification d'intégrité (comme **AIDE**) pour créer une base de référence des fichiers système critiques et détecter toute modification non autorisée.</li>
    <li><strong>Désactivation de services :</strong> Script d'audit pour identifier et désactiver tous les services réseau superflus qui augmentent la surface d'attaque.</li>
    <li><strong>Authentification à Deux Facteurs (2FA) :</strong> Documentation ou implémentation des étapes pour ajouter le 2FA (via <code>Google Authenticator PAM</code>) pour les connexions SSH.</li>
  </ul>
</div>

## 🎓 Compétences démontrées

<div class="skills-showcase space-y-6 my-8">
  
  <div class="skill-category dark:bg-gradient-to-r dark:from-indigo-900/30 dark:to-purple-900/30 bg-gradient-to-r from-indigo-50 to-purple-50 border dark:border-indigo-500/30 border-indigo-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">🐧</span>
      <h3 class="text-xl font-bold dark:text-white text-slate-900">Administration Système (Linux)</h3>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Gestion du système de fichiers</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Application des bonnes permissions (ex: `chmod 600`) pour les fichiers sensibles.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Configuration de services système</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Modification du fichier `sshd_config` pour le durcissement d'OpenSSH.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Gestion des mises à jour</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Mise en place de l'automatisation des mises à jour de sécurité.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Audit et intégrité du système</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Utilisation d'outils comme AIDE ou Tripwire pour la détection d'altération de fichiers.</div>
        </div>
      </div>
    </div>
  </div>

  <div class="skill-category dark:bg-gradient-to-r dark:from-indigo-900/30 dark:to-purple-900/30 bg-gradient-to-r from-indigo-50 to-purple-50 border dark:border-indigo-500/30 border-indigo-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">🛡️</span>
      <h3 class="text-xl font-bold dark:text-white text-slate-900">Sécurité & Hardening</h3>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Authentification forte</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Désactivation de l'authentification par mot de passe (clés SSH).</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Principe du moindre privilège</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Restriction de l'accès SSH au compte `root` (`PermitRootLogin no`).</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Gestion des accès</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Configuration des listes blanches IP pour l'accès SSH.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Durcissement avancé</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Identification et désactivation des services réseau superflus.</div>
        </div>
      </div>
    </div>
  </div>

  <div class="skill-category dark:bg-gradient-to-r dark:from-indigo-900/30 dark:to-purple-900/30 bg-gradient-to-r from-indigo-50 to-purple-50 border dark:border-indigo-500/30 border-indigo-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">⚙️</span>
      <h3 class="text-xl font-bold dark:text-white text-slate-900">Automatisation & Scripting (Bash)</h3>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Modularité et orchestration</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Utilisation de `source` et des fonctions Bash pour modulariser le script.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Création d'outils CLI</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Développement d'alias et de fonctions personnalisées dans les `dotfiles`.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Gestion d'environnement</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Modification de la variable `PS1` pour un prompt avancé (info Git).</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Déploiement et fiabilité</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Gestion de la vérification des droits (`if [ "$UID" -ne 0 ]`) et gestion des erreurs.</div>
        </div>
      </div>
    </div>
  </div>

  <div class="skill-category dark:bg-gradient-to-r dark:from-indigo-900/30 dark:to-purple-900/30 bg-gradient-to-r from-indigo-50 to-purple-50 border dark:border-indigo-500/30 border-indigo-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">🌐</span>
      <h3 class="text-xl font-bold dark:text-white text-slate-900">Réseau & Firewall</h3>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Configuration de pare-feu</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Installation et activation du pare-feu UFW.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Politique de sécurité réseau</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Application des règles par défaut `DENY incoming` / `ALLOW outgoing`.</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Gestion des ports</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Ouverture sélective des ports pour les services nécessaires (SSH, HTTP, HTTPS).</div>
        </div>
      </div>
      <div class="skill-item flex items-start gap-2 dark:bg-white/5 bg-white/50 rounded-lg p-3">
        <span class="text-green-500 font-bold text-lg">✓</span>
        <div>
          <div class="font-semibold dark:text-white text-slate-900">Outil de synchronisation</div>
          <div class="text-xs dark:text-white/60 text-slate-600">Utilisation de `rsync` pour la synchronisation sécurisée et automatisée des répertoires.</div>
        </div>
      </div>
    </div>
  </div>

</div>

## 📚 Ressources & Documentation

<div class="documentation-grid grid grid-cols-1 md:grid-cols-2 gap-6 my-8">
  
  <div class="doc-card dark:bg-gradient-to-br dark:from-slate-900/50 dark:to-slate-800/50 bg-gradient-to-br from-slate-50 to-slate-100 border dark:border-white/10 border-slate-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300 cursor-pointer" data-doc-type="details">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">📖</span>
      <h3 class="text-lg font-bold dark:text-white text-slate-900">Documentation complète</h3>
    </div>
    <ul class="space-y-3">
      <li class="flex items-start gap-2">
        <span class="text-blue-500">▸</span>
        <span class="dark:text-white/70 text-slate-600">Détail du script de durcissement SSH</span>
      </li>
      <li class="flex items-start gap-2">
        <span class="text-blue-500">▸</span>
        <span class="dark:text-white/70 text-slate-600">Règles et configuration avancée d'UFW</span>
      </li>
      <li class="flex items-start gap-2">
        <span class="text-blue-500">▸</span>
        <span class="dark:text-white/70 text-slate-600">Exemples de Prompt PS1 et Alias Bash</span>
      </li>
      <li class="flex items-start gap-2">
        <span class="text-blue-500">▸</span>
        <span class="dark:text-white/70 text-slate-600">Mise en place de AIDE pour la vérification d'intégrité</span>
      </li>
    </ul>
    <div class="mt-4 text-center">
      <span class="text-sm dark:text-blue-400 text-blue-600 font-semibold">→ Voir les détails techniques</span>
    </div>
  </div>

  <div class="doc-card dark:bg-gradient-to-br dark:from-purple-900/30 dark:to-indigo-900/30 bg-gradient-to-br from-purple-50 to-indigo-50 border dark:border-purple-500/30 border-purple-300 rounded-2xl p-6 hover:scale-[1.02] transition-all duration-300 cursor-pointer" data-doc-type="architecture">
    <div class="flex items-center gap-3 mb-4">
      <span class="text-3xl">🗺️</span>
      <h3 class="text-lg font-bold dark:text-white text-slate-900">Diagramme interactif</h3>
    </div>
    <p class="dark:text-white/70 text-slate-600 mb-4">Visualisation complète de l'architecture avec tooltips détaillés pour chaque composant.</p>
    <div class="flex flex-wrap gap-2 mb-4">
      <span class="px-3 py-1 dark:bg-blue-500/20 bg-blue-200 dark:text-blue-300 text-blue-700 rounded-full text-xs">Script Bash</span>
      <span class="px-3 py-1 dark:bg-red-500/20 bg-red-200 dark:text-red-300 text-red-700 rounded-full text-xs">Hardening</span>
      <span class="px-3 py-1 dark:bg-purple-500/20 bg-purple-200 dark:text-purple-300 text-purple-700 rounded-full text-xs">Dotfiles</span>
      <span class="px-3 py-1 dark:bg-green-500/20 bg-green-200 dark:text-green-300 text-green-700 rounded-full text-xs">UFW</span>
    </div>
    <div class="text-center">
      <span class="text-sm dark:text-purple-400 text-purple-600 font-semibold">→ Voir l'architecture</span>
    </div>
  </div>

</div>

<script is:inline>
  document.addEventListener('DOMContentLoaded', function() {
    const docCards = document.querySelectorAll('[data-doc-type]');
    docCards.forEach(card => {
      card.addEventListener('click', function() {
        const type = this.getAttribute('data-doc-type');
        const tabButton = document.querySelector(`[data-tab="${type}"]`);
        if (tabButton) {
          tabButton.click();
        }
      });
    });
  });
</script>

---

**Archivé** | **Outil CLI** | **Projet Académique (ESGI)**
