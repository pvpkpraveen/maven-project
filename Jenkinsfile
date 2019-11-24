pipeline {
    agent any
    
    parameters {
        string(name: 'tomcat_dev', defaultValue: '34.233.126.191', description: 'Staging VM')
        string(name: 'tomcat_prod', defaultValue: '3.91.67.231', description: 'PRODUCTION VM')
    }
    
    triggers {
        pollSCM('* * * * *')
    }

    stages{
        stage ('Build'){
            steps{
                sh 'mvn clean package'
            }
            post{
                success{
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
    
        stage ('Deployments'){
            parallel{
                stage ('Deploy to Staging'){
                    steps {
                        sh "scp -i C:\Users\pvakkalam\JenkinsWorkDir\my_Key_Pair.pem **/target/*.war ec2-user@${params.tomcat_dev}:/var/lib/tomcat8/webapps"
                    }
                }

                stage ('Deploy to Production'){
                    steps {
                        sh "scp -i C:\Users\pvakkalam\JenkinsWorkDir\my_Key_Pair.pem **/target/*.war ec2-user@${params.tomcat_prod}:/var/lib/tomcat8/webapps"
                    }
                }

            }
        }
    }
}