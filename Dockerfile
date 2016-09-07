#
# Sonarqube Docker Image for Open DevOps Pipeline
#
# VERSION : 1.0
#
FROM devopsopen/docker-base

MAINTAINER Open DevOps Team <open.devops@gmail.com>

ENV REFRESHED_AT 2016-09-09

ENV SONAR_VERSION=6.0
ENV SONARQUBE_HOME=/opt/sonarqube
ENV SONARQUBE_JDBC_USERNAME=sonar
ENV SONARQUBE_JDBC_PASSWORD=sonar
ENV SONARQUBE_JDBC_URL=

# Http port
EXPOSE 9000

RUN set -x \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
    && mkdir /opt \
    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/*

VOLUME ["$SONARQUBE_HOME/data", "$SONARQUBE_HOME/extensions"]

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]