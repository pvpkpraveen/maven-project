pipeline {
    agent any
    
    parameters {
        string(name: 'tomcat_dev', defaultValue: '34.233.126.191', description: 'Staging VM')
        string(name: 'tomcat_prod', defaultValue: '3.91.67.231', description: 'PRODUCTION VM')
    }
    
    triggers {
        pollSCM('* * * * *') //Polling Source Control
    }

    stages{
        stage ('Build'){
            steps{
                bat 'mvn clean package'
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
                        //bat "winscp -i /c/Users/pvakkalam/JenkinsWorkDir/my_Key_Pair.pem **/target/*.war ec2-user@${params.tomcat_dev}:/var/lib/tomcat8/webapps"
                        winscp "open sftp://ec2-user:/c/Users/pvakkalam/JenkinsWorkDir/my_Key_Pair.pem@${params.tomcat_dev}" "put **/target/*.war /var/lib/tomcat8/webapps" "exit"
                    }
                }

                stage ('Deploy to Production'){
                    steps {
                        //bat "winscp -i /c/Users/pvakkalam/JenkinsWorkDir/my_Key_Pair.pem **/target/*.war ec2-user@${params.tomcat_prod}:/var/lib/tomcat8/webapps"
                        winscp "open sftp://ec2-user:/c/Users/pvakkalam/JenkinsWorkDir/my_Key_Pair.pem@${params.tomcat_prod}" "put **/target/*.war e/var/lib/tomcat8/webapps" "exit"
                    }
                }

            }
        }
    }
}