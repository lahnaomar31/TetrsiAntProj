# Utiliser une image de base avec Java 17 installé
FROM openjdk:17-jdk

# Installer curl pour télécharger Ant et Ivy
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Télécharger et installer Ant 1.9.6
RUN curl -O https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.6-bin.tar.gz && \
    tar -xzf apache-ant-1.9.6-bin.tar.gz -C /opt/ && \
    rm apache-ant-1.9.6-bin.tar.gz

# Configurer les variables d'environnement pour Ant
ENV ANT_HOME=/opt/apache-ant-1.9.6
ENV PATH=$ANT_HOME/bin:$PATH

# Télécharger et installer Ivy 2.5.0 dans le répertoire lib d'Ant
RUN curl -O https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.5.0/ivy-2.5.0.jar && \
    mv ivy-2.5.0.jar $ANT_HOME/lib/ivy.jar

# Créer un dossier pour ton projet
WORKDIR /usr/src/app

# Copier tous les fichiers de ton projet dans l'image Docker
COPY . .

# Construire le projet avec les cibles spécifiques
RUN ant clean retrieve compile-test

# Définir le point d'entrée pour exécuter les tests automatiquement lors de l'exécution du conteneur
CMD ["ant", "test"]
