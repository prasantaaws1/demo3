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
        stage('Trigger CD Pipeline') { 
            steps {
                script {
                    sh "curl -v -k --user admin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'http://3.110.178.118:8080/job/cd-job/buildWithParameters?token=gitops-token'"
                }
            }
        }
}
}
