pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKER_IMAGE = 'noobcoder1209/project_1'
        DOCKER_VERSION = '18.09-dind' // Specify the Docker version here

    }

    stages {
        stage('Initialize') {
            agent {
                label 'master'
            }
            steps {
                // Define Docker tool with the desired version
                tools {
                    someTool 'someVersion'
                }
                script {
                    def dockerHome = tool 'someTool'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
    //     stage('Initialize'){
    //         steps {
    //             script {
    //                 def dockerHome = tool 'myDocker'
    //                 env.PATH = "${dockerHome}/bin:${env.PATH}"
    //             }
    //         }
    //     }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                        // Push the Docker image to Docker Hub
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }
    }
        post {
        success {
            echo 'Build and Push to Docker Hub successful!'
        }
        failure {
            echo 'Build or Push to Docker Hub failed!'
        }
    }
}