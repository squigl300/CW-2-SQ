pipeline {
    agent any
    environment {
        // Add the path to the Jenkins environment for this pipeline
        PATH = "/usr/local/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                // Checks out the source code from GitHub
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Define the Docker image name
                    def dockerImageName = 'squigl300/myapp:v2'
                    
                    // Build the Docker image
                    docker.build(dockerImageName)
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    def dockerImageName = 'squigl300/myapp:v2'
                    
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin"
                    }

                    // Push the image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image(dockerImageName).push()
                    }
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    // Define Docker image name
                    def dockerImageName = 'squigl300/myapp:v2'

                    // Run a container from the image and execute a simple test command
                    sh "docker run --rm ${dockerImageName} echo 'Container test successful'"
                }
            }
        }

     stage('Deploy to Kubernetes') {
        steps {
            script {
                // The ID of the SSH credentials added in Jenkins
                def sshCredentialsId = 'my-ssh-key'

                sshagent([sshCredentialsId]) {
                    // Set the Kubernetes context
                    sh "kubectl config use-context minikube"

                    // Update the image in the Kubernetes deployment
                    sh "/usr/local/bin/kubectl set image deployment/myapp-deployment myapp=squigl300/myapp:v2 --record"
                }
                }
            }
        }
    }
}

