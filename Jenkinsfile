// 0. Your personal web page will be on URL: http://sawxpv01.ssn.entsvcs.com/{shortname}/
// 1. Rename "lpastva" to your {shortname} in this file
// 2. Open package.json and rename "lpastva" to your {shortname}
// 3. Create your own testing collections in Postman, simialr to file postman_collection.json

def gv

pipeline {

	// loading environemnt variables from Jenkins config http://sawxpv01.ssn.entsvcs.com/jenkins/credentials/
	environment {
		PROJECT = "lpastva"
	}

	// on  what agent this pipeline should run - we have only one agent (server) now
	agent any

	// steps that will be performed one by one
		stages {

		// loading external file (inside Jenkinsfile should be only steps, logical, bussiness process are better to be outsude in functions)
		stage('Load groovy file'){
			steps {
				script{
					gv = load "./jenkins.groovy"
				}
			}
		}	
		   
		// this is part, where we stop docker containers and hnece starting web page
		stage('Stop application') {	  
			steps {
				sh "docker-compose -f ./docker-compose.yaml down"
			}
		}
		
		// this is part, where we start docker containers and hence starting web page
		stage('Start application') {	  
			steps {
				sh "docker-compose -f ./docker-compose.yaml up --build -d"
			}
		}	 

		// this is part, where we start docker containers and hnece starting web page
		stage('Sleep 10 seconds') {	  
			steps {
				script {          
					sh "sleep 10"
				}
			}
		}		
	   
		// Actual start of working with Newman tests
		stage ("Running Newman tests") {	
			steps {
				script {       
					gv.executeTesting()		  
				}
			}		
		}

		// Your page is browsable now on http://sawxpv01.ssn.entsvcs.com/lpastva/
		stage ("DONE!") {	
			steps {
				script {       
					sh "echo 'Heureka!'"
					sh "echo 'Your page is browsable now on http://sawxpv01.ssn.entsvcs.com/lpastva/'"
					
				}
			}		
		}
	
	}

	post {

		failure {
			echo "Failure!"
			emailext body: 'A Jenkins build was failed on http://sawxpv01.ssn.entsvcs.com/jenkins/ for lpastva', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Jenkins build failed web-aciopr'
		}

		success {
			echo "Success!"
		}
	}

}