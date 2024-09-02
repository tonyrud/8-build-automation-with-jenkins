#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/tonyrud/jenkins-shared-library.git',
    credentialsID: 'github-creds'
    ]
)

pipeline {
    agent any
    tools {
       maven 'maven-3.9'
    }
    environment {
        DOCKER_REPO_SERVER = '326347646211.dkr.ecr.us-east-2.amazonaws.com'
        DOCKER_REPO = "${DOCKER_REPO_SERVER}/java-maven-app"
    }

    stages {

        stage("copy files to ansible server") {

            steps {
                script {
                            sshagent(['digital-ocean-ansible-server']) {
                                // copy files from repo to ec2 instance
                                sh "scp -o StrictHostKeyChecking=no ansible/* root@157.245.143.37:/root"
                            }

                            withCredentials([string(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'username')]) {
                                sh 'scp ${keyfile} root@157.245.143.37:/root/ssh-key.pem'
                            }
                }
            }
        }
    }
}
