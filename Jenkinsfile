pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository
                git 'https://github.com/Om-Nikhade/banking-finance-prj.git'
                
                // Run Maven to build the project
                sh "mvn clean package"
            }
        }
        
        stage('Generate Test Reports') {
            steps {
                // Publish HTML test reports
                publishHTML([
                    allowMissing: false, 
                    alwaysLinkToLastBuild: false, 
                    keepAll: false, 
                    reportDir: 'target/surefire-reports',  // Use relative path to workspace
                    reportFiles: 'index.html', 
                    reportName: 'HTML Report', 
                    reportTitles: '', 
                    useWrapperFileDirectly: true
                ])
            }
        }
        
        stage('Create Docker Image') {
            steps {
                // Build Docker image
                sh 'docker build -t omnikhade/banking-finance-prj:1.0 .'
            }
        }

        stage('Docker Login') {
            steps {
                // Login to Docker Hub
                withCredentials([usernamePassword(credentialsId: 'dockerlogin', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')]) {
                    sh 'docker login -u ${dockerlogin} -p ${dockerpassword}'
                }
            }
        }

        stage('Push Image') {
            steps {
                // Push Docker image to Docker Hub
                sh 'docker push omnikhade/banking-finance-prj:1.0'
            }
        }
         stage('Config & Deployment') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AwsAccessKey', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir('Terraform-files') {
                    sh 'sudo chmod 600 mykey.pem'
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform apply --auto-approve'
}
    }
}
}
}
}
    

