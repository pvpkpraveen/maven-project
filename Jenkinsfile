pipeline {
    agent any
    stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage('Deploy to Stage'){
            steps{
                build job: 'Deploy-to-Stage'
            }
        }
        stage('Deploy to Production'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message: 'Approve PRODUCTION Deployment ??'
                }
                build job: 'Delpoy-to-Production'
            }
            post{
                success{
                    echo 'Code Deployed to Production Environment'
                }
                failure{
                    echo 'WARNING: Failed to deploy code to PRODUCTION'
                }
            }
            }
        }
    }
}