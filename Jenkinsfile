def awsCredentials = [[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-personal']]
pipeline {
   agent any
   stages {
       stage('prepare workspace') {
           steps {
               sh 'rm -rf *'
               git branch: 'master', url: 'https://github.com/Rohan243/aws-eks-terraform.git'
               sh 'terraform init'
           }
       }
       stage('terraform apply') {
           steps {
               sh 'terraform apply -auto-approve'
               sh 'terraform output kubeconfig > ./kubeconfig'
               sh 'terraform output config_map_aws_auth > ./config_map_aws_auth.yaml'
               sh 'export KUBECONFIG=./kubeconfig'
           }
       }
       stage('add worker nodes') {
           steps {
               sh 'kubectl apply -f ./config_map_aws_auth.yaml --kubeconfig=./kubeconfig'
               sh 'sleep 60'
           }
       }
       stage('deploy example application') {
           steps {   
               sh 'kubectl apply -f ./example/hello-kubernetes.yml --kubeconfig=./kubeconfig'
               sh 'kubectl get all --kubeconfig=./kubeconfig'
           }
       }
       stage('Run terraform destroy') {
           steps {
               input 'Run terraform destroy?'
           }
       }
       stage('terraform destroy') {
           steps {
               sh 'kubectl delete -f ./example/hello-kubernetes.yml --kubeconfig=./kubeconfig'
               sh 'sleep 60'
               sh 'terraform destroy -force'
           }
       }
   }
}
