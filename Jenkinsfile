pipeline{
    agent {
        label "jenkins-agent"
    }
    tools {
        jdk "Java17"
        maven "Maven3"
    }
    environment {
        APP_NAME = "demo3"
        RELEASE = "1.0.0"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        DOCKER_USER = "pkbhub"
        DOCKER_PASS = "dockerhub"    
    }
    stages{
        stage('Clean Work Space') { 
            steps {
                cleanWs()
            }
        }
        stage('Code CheckOut') { 
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/prasantaaws1/demo3.git'
            }
        }
        stage('Build Application') { 
            steps {
                sh "mvn clean package"
            }
        }
        stage('Test Application') { 
            steps {
                sh "mvn test"
            }
        }
        stage('SonarQube Analysis') { 
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonartoken') {
                    sh "mvn sonar:sonar"
                         }
                    }
            }
        }
        stage('Sonar Quality Gate') { 
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonartoken'
                    }
            }
        }
        stage('Docker Build & Push') { 
            steps {
                script {
                    docker.withRegistry('', DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('', DOCKER_PASS) {
                    docker_image.push("${IMAGE_TAG}") 
                    }
                }
            }
        }
}
}
