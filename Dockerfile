FROM jenkins/jenkins
LABEL maintainer="hitjethva@gmail.com"
USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
RUN apt-get update
RUN apt-get install -y python3 python3-pip python3-venv
RUN pip3 install SQLAlchemy
RUN pip3 install --upgrade pip
RUN apt-get install -y pylint
RUN pip3 install pylint-fail-under
RUN pip3 install coverage
RUN apt-get install -y zip
RUN apt-get install -y maven

RUN pip3 install pip-audit
RUN pip3 install bandit

COPY ./hadolint /usr/local/bin/

RUN apt-get update && \
apt-get -y install apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; \
echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
$(lsb_release -cs) \
stable" && \
apt-get update && \
apt-get -y install docker-ce
RUN apt-get install -y docker-ce
RUN usermod -a -G docker jenkins

USER jenkins
 
ENV JAVA_OPTS="-Xmx4096m"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --prefix=/jenkins"
