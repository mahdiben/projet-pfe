FROM jenkins/jenkins:lts

# Plugins for better UX (not mandatory)
RUN /usr/local/bin/install-plugins.sh ansicolor
RUN /usr/local/bin/install-plugins.sh greenballs

# Plugin for scaling Jenkins agents
RUN /usr/local/bin/install-plugins.sh kubernetes

# install jenkins plugins
COPY ./jenkins-plugins /usr/share/jenkins/plugins
RUN while read i ; \
                do /usr/local/bin/install-plugins.sh $i ; \
        done < /usr/share/jenkins/plugins
        
RUN apt-get update
RUN apt-get install -y python-pip
# Install app dependencies
RUN pip install --upgrade pip 

USER jenkins