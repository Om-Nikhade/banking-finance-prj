pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Clone code from the provided GitHub repository
                git 'https://github.com/Om-Nikhade/banking-finance-prj.git'
            }        
        }
        
        stage('Build') {
            steps {
                // Run Maven to build the project (Maven should be available in the environment's PATH)
                sh 'mvn clean package'
            }
        }
    }
}   