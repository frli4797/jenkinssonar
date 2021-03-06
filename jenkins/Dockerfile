FROM jenkins:2.32.2

USER root
RUN apt-get update \
#      && apt-get -y upgrade \
      && apt-get install -y sudo curl vim \
	&& apt-get install -y docker \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# getting the docker-cli
# --- Attention: docker.sock needs to be mounted as volume in docker-compose.yml
# see: https://issues.jenkins-ci.org/browse/JENKINS-35025
# see: https://get.docker.com/builds/
# see: https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Docker+Custom+Build+Environment+Plugin#CloudBeesDockerCustomBuildEnvironmentPlugin-DockerinDocker
RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz && tar -xvzf docker-latest.tgz
RUN mv docker/* /usr/bin/
RUN usermod -a -G staff jenkins
#RUN chmod a+rwx /var/run/docker.sock

USER jenkins

# installing specific list of plugins. see: https://github.com/jenkinsci/docker#preinstalling-plugins
RUN /usr/local/bin/install-plugins.sh git \
	github \
	config-file-provider \
	docker \
	docker-commons \
	job-dsl \
	build-pipeline \
	resource-disposer \
	cloudbees-folder \
	docker-build-publish \
	ldap

# Adding default Jenkins Jobs
COPY jobs/spring-example-mvn.xml /usr/share/jenkins/ref/jobs/spring-example-mvn/config.xml
COPY jobs/spring-example-mvn-docker.xml /usr/share/jenkins/ref/jobs/spring-example-mvn-docker/config.xml
COPY jobs/spring-example-mvn-dockersa.xml /usr/share/jenkins/ref/jobs/spring-example-mvn-dockersa/config.xml

############################################
# Configure Jenkins
############################################
# Jenkins settings
COPY config/config.xml /usr/share/jenkins/ref/config.xml

# Jenkins Settings, i.e. Maven, Groovy, ...
COPY config/hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml
COPY config/hudson.plugins.groovy.Groovy.xml /usr/share/jenkins/ref/hudson.plugins.groovy.Groovy.xml
COPY config/maven-global-settings-files.xml /usr/share/jenkins/ref/maven-global-settings-files.xml
COPY config/github-plugin-configuration.xml /usr/share/jenkins/ref/github-plugin-configuration.xml
COPY config/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml /usr/share/jenkins/ref/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml
COPY config/hudson.plugins.git.GitSCM.xml /usr/share/jenkins/ref/hudson.plugins.git.GitSCM.xml

# SSH Keys & Credentials
COPY config/credentials.xml /usr/share/jenkins/ref/credentials.xml
COPY config/ssh-keys/cd-demo /usr/share/jenkins/ref/.ssh/id_rsa
COPY config/ssh-keys/cd-demo.pub /usr/share/jenkins/ref/.ssh/id_rsa.pub

# tell Jenkins that no banner prompt for pipeline plugins is needed
# see: https://github.com/jenkinsci/docker#preinstalling-plugins
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
