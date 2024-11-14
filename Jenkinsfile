pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKER_IMAGE = 'noobcoder1209/project_1'
    }

    stages {

        stage('Install Docker') {
            steps {
                script {
                    // Check if Docker is installed
                    def dockerInstalled = sh(script: 'which docker', returnStatus: true) == 0

                    if (!dockerInstalled) {
                        echo 'Docker is not installed. Installing Docker...'
                        // Installing Docker (Debian/Ubuntu example)
                        sh '''
                            sudo apt-get update
                            sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                            sudo apt-get update
                            sudo apt-get install -y docker-ce
                            sudo systemctl enable docker
                            sudo systemctl start docker
                        '''
                    } else {
                        echo 'Docker is already installed.'
                    }
                }
            }
        }

        stage('Initialize'){
            steps {
                script {
                    def dockerHome = tool 'myDocker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        
        stage('Check Docker') {
            steps {
                script {
                    // Check if Docker is running
                    sh 'docker info'

                    // Check Docker version
                    sh 'docker version'

                    // Check DOCKER_HOST environment variable
                    echo "DOCKER_HOST: ${env.DOCKER_HOST}"
                }
            }
        }
        

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