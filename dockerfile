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

