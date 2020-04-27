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
        
        stage('Setting Environments') {
          steps {
              sh 'gcloud auth activate-service-account --key-file=/root/gcp.json'
          }
        }
    	stage('Getting Values') {
          steps {
		sh 'gcloud projects list'
		}
	}
}
}
