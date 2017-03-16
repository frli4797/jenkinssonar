#/bin/bash

JENKINS_HOME=vol/jenkins_home
CONFIG=jenkins/config
JOBS=jenkins/jobs

cp -i $JENKINS_HOME/config.xml \
	$JENKINS_HOME/credentials.xml \
	$JENKINS_HOME/github-plugin-configuration.xml \
	$JENKINS_HOME/hudson.plugins.groovy.Groovy.xml \
	$JENKINS_HOME/hudson.tasks.Maven.xml \
	$JENKINS_HOME/maven-global-settings-files.xml \
	$JENKINS_HOME/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml \
	$JENKINS_HOME/hudson.plugins.git.GitSCM.xml \
	$CONFIG

cp -i $JENKINS_HOME/jobs/spring-example-mvn/config.xml $JOBS/spring-example-mvn.xml
cp -i $JENKINS_HOME/jobs/spring-example-mvn-docker/config.xml $JOBS/spring-example-mvn-docker.xml
cp -i $JENKINS_HOME/jobs/spring-example-mvn-dockersa/config.xml $JOBS/spring-example-mvn-dockersa.xml




