pipeline {
    agent any

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
    }
}
