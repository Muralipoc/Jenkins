pipeline {
    agent {
        node {
              label 'master'
              }
           }
    stages {

        stage('pipeline started') {
          steps {
              sh 'echo "Pipeline started"'
          }
        }

        stage('clonning') {
          steps {
                sh 'sudo rm -r *;sudo git clone https://github.com/Muralipoc/Jenkins.git ;pwd'
                }
        }
        stage('terraform init') {
            steps {
            ansiColor('xterm') {
                sh 'sudo terraform init ./Jenkins'
            }
        }
        }
        stage('terraform plan') {
        steps {
            ansiColor('xterm') {
                sh 'sudo terraform plan ./Jenkins'
            }
        }
        }
	stage('terraform apply') {
        steps {
            ansiColor('xterm') {
                sh 'sudo terraform apply ./Jenkins'
            }
        }
        }
}
}
