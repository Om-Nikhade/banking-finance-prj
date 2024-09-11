pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git 'https://github.com/Om-Nikhade/banking-finance-prj.git'                
                sh "mvn clean package"
            }        
        }
        
        stage('Generate Test Reports') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/banking-finance-prj/target/surefire-reports/', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        
        stage('Create Docker Image') {
            steps {
                sh 'docker build -t omnikhade/banking-finance-prj:1.0 .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerlogin', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')])
                    sh 'docker login -u ${dockerlogin} -p ${dockerpassword}'
                }
            }
        

        stage('Push Image') {
            steps {
                sh 'docker push omnikhade/banking-finance-prj:1.0'
            }
        }
    }
}

