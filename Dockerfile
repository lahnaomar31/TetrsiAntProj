# Utilise une image de base Ubuntu 20.04
FROM ubuntu:20.04

# Met à jour les paquets et installe les dépendances nécessaires
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    ant \
    ivy \
    git \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Télécharge Ivy version 2.5.0 et le place dans le répertoire lib de Ant
RUN curl -O https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.5.0/ivy-2.5.0.jar \
    && mv ivy-2.5.0.jar /usr/share/ant/lib/

# Crée un dossier pour ton projet
WORKDIR /usr/src/app

# Copie tous les fichiers de ton projet dans l'image Docker
COPY . .

# Exécute les étapes de build et de test avec Ant
RUN ant clean retrieve compile-test

# Définit le point d'entrée pour exécuter les tests automatiquement lors de l'exécution du conteneur
CMD ["ant", "test"]
