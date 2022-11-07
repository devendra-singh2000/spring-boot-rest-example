pipeline {
  agent any

    environment {
        
        reg_address = "749177923916.dkr.ecr.ap-south-1.amazonaws.com"
        repo = "java-app"
      
        
    }

    stages {
        stage('Checkout') {
          
            steps {
               sh """ 
               rm -rf spring*
               git clone https://github.com/Ashutosh-aws/spring-boot-rest-example.git
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

                 sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 749177923916.dkr.ecr.ap-south-1.amazonaws.com'
                }
        }
        
        stage('docker push'){
                 steps{
                     sh 'docker push ${reg_address}/${repo}:java_app-build-${BUILD_NUMBER}'
                 }
        }

        stage('deploy image'){
            steps{
              sshagent(['cred-ec2']) {
                  sh "ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.65.250 'docker stop \$(docker ps -a -q) && docker rm \$(docker ps -a -q) ' "
                  sh "ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.65.250 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 749177923916.dkr.ecr.ap-south-1.amazonaws.com && docker run -d -p 80:8090 ${reg_address}/${repo}:java_app-build-${BUILD_NUMBER}' "
                 // sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 749177923916.dkr.ecr.ap-south-1.amazonaws.com'
                  //sh 'docker rmi -f $(docker images -aq)'
                  //sh 'hostname -I'
                  //sh 'docker run -d  ${reg_address}/${repo}:java_app-build-${BUILD_NUMBER}'
              }

            }
        } 
    }
  
}
