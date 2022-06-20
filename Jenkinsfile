pipeline {
    agent any
    environment{
        registry='barayathel/micrometer-example'
        dockerImage=''
        dockerHubCredentials='dock-access'
    }
    stages{
        stage("Maven build"){
            steps{
                sh '/usr/local/apache-maven/bin/mvn clean package'
            }
            
        }
        stage("Docker build"){
            steps{
                script{
                    dockerImage = docker.build "$registry"
                }
                
            }
            
        }
        stage("Pushing to DockerHub Registry"){
            steps{
                script{
                    docker.withRegistry('',dockerHubCredentials){
                        dockerImage.push("$currentBuild.number")
                        dockerImage.push("latest")
                    }
                }
            }
            
        }
        
    }
}
