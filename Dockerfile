# Utiliser une image Alpine avec Java 17
FROM openjdk:17-alpine

# Installer curl et bash
RUN apk add --no-cache curl bash

# Télécharger et installer Ant
RUN curl -O https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.6-bin.tar.gz && \
    tar -xzf apache-ant-1.9.6-bin.tar.gz -C /opt/ && \
    rm apache-ant-1.9.6-bin.tar.gz

# Configurer les variables d'environnement pour Ant
ENV ANT_HOME=/opt/apache-ant-1.9.6
ENV PATH=$ANT_HOME/bin:$PATH

# Télécharger et installer Ivy
RUN curl -O https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.5.0/ivy-2.5.0.jar && \
    mv ivy-2.5.0.jar $ANT_HOME/lib/ivy.jar

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers du projet
COPY . .

# Construire et tester le projet avec Ant
RUN ant clean retrieve compile-test

# Lancer les tests
CMD ["ant", "test"]
