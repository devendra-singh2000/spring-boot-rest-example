pipeline {
  agent any

    environment {
        
        reg_address = "749177923916.dkr.ecr.us-east-1.amazonaws.com"

        repo = "demo-app"
      
        
    }

    stages {
        stage('Checkout') {
          
            steps {
               sh """ 
                            
               git clone https://github.com/devendra-singh2000/spring-boot-rest-example.git
               """
            } 
                
        }

        stage('maven build'){
            steps{
          
                sh  'cd spring-boot-rest-example'
                sh 'mvn clean install package'
                 }
        }
        
        stage('dockerfile build'){
            steps{
          
                sh  'docker build -t java-app/build /var/lib/jenkins/workspace/java-app-pipeline/.'
                sh 'docker tag java-app/build ${reg_address}/${repo}:java_app-build-${BUILD_NUMBER}'
                 }
        }
        stage('ECR logging'){
                steps{

                 sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 749177923916.dkr.ecr.us-east-1.amazonaws.com'
                }
        }
        
        stage('docker push'){
                 steps{
                     sh 'docker push ${reg_address}/${repo}:java_app-build-${BUILD_NUMBER}'
                 }
        }

    }
  
}
