def executeTesting(){
	try {	  
		sh "npm --prefix ./ install"
		sh "npm --prefix ./ run api-tests"
		junit './newman.xml'
	} catch(Exception ex){
		echo "RESULT: FAILURE"
	}	
}

return this