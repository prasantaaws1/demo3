pipeline{
    agent {
        label "jenkins-agent"
    }
    tools {
        jdk "Java17"
        maven "Maven3"
    }
    stages{
        stage('Example Build') { 
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
                sh 'mvn clean package'
            }
        }
    }
}
