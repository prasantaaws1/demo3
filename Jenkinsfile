pipeline{
    agent {
        label "jenkins-agent"
    }
    tools {
        jdk "Java17"
        maven "Maven3"
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
    }
}
