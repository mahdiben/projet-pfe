FROM jenkins/jenkins:lts

USER root

# install jenkins plugins
COPY ./jenkins-plugins /usr/share/jenkins/plugins
RUN while read i ; \
                do /usr/local/bin/install-plugins.sh $i ; \
        done < /usr/share/jenkins/plugins
        
RUN apt-get update
RUN apt-get install -y python-pip
# Install app dependencies
RUN pip install --upgrade pip


RUN apt-get install git
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.6

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" -o docker.tgz \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v



USER jenkins

