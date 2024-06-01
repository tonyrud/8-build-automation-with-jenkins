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
        IMAGE_NAME = 'tonyrudny/java-maven-app-private:1.0.3-6'
    }
    stages {
        stage('build app') {
            steps {
                echo 'building application jar...'
                buildJar()
            }
        }
        stage('build image') {
            steps {
                script {
                    echo 'building the docker image...'
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        } 
        stage("deploy") {
            steps {
                script {
                    echo 'deploying docker image to EC2...'
                    def dockerCmd = "docker run -p 8080:8080 -d ${IMAGE_NAME}"
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@3.145.156.253 ${dockerCmd}"
                    }
                }
            }               
        }
        stage('commit version update'){
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-access-token', variable: 'TOKEN')]){
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'

                        sh "git remote set-url origin https://${TOKEN}@github.com/tonyrud/java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump - ${IMAGE_NAME}"'
                        sh "git push origin HEAD:${GIT_BRANCH}"
                    }
                }
            }
        }
    }
}
