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
	// stage("Waiting for approval"){
    //         steps{
    //             script{
    //                 // Prompt, if yes build, if no abort
    //                 try {
    //                     timeout(time: 1, unit: 'MINUTES'){
    //                         approved = input message: 'Deploy to production?', ok: 'Continue',
    //                             parameters: [choice(name: 'approved', choices: 'Yes\nNo', description: 'Deploy this build to production')]
    //                         if(approved != 'Yes'){
    //                             error('Build not approved')
    //                         }
    //                     }
    //                 } catch (error){
    //                     error('Build not approved in time')
    //                 }
    //             }
    //         }
    //     }
	stage("Deploying to Kubernetes production environment"){
	    steps{
	    	script{
		 sh "echo $registry:$currentBuild.number"
		 sh "kubectl set image -n ben-space deployment/micro-deployment micrometer-demo-deployment=$registry:$currentBuild.number" //using the terminal
         // sh 'kubectl replace ' //creating a new yml file and replacing the old one
         // sh 'kubectl edit ..' //produce a notepad to edit the resources

		}
	    }

	}
        
    }
}
