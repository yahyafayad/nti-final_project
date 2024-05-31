pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws_access_key')
    AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
    AWS_DEFAULT_REGION = "eu-west-3"
    AWS_ACCOUNT_ID = '058264315018'
    
    ECR_BACKEND_NAME = 'nti-backend-image'
    ECR_FRONTEND_NAME = 'nti-frontend-image'
    IMAGE_TAG = "${BUILD_NUMBER}"
    BACKEND_REPO_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_BACKEND_NAME}"
    FRONTEND_REPO_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_FRONTEND_NAME}"
  }
  stages {
    stage('Start The Pipeline') {
      steps {
        sh 'echo Welcome To NTI Final Project DevOps Automation Track'
        sh "aws ecr get-login-password --region ${env.AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
      }
    }
    stage('Build Image and Generate Security Report using Trivy') {
      steps {
        script {
          dir('backend') {
            sh "docker build -t ${env.BACKEND_REPO_URL}:${env.IMAGE_TAG} ."
            sh "trivy image ${env.BACKEND_REPO_URL}:${env.IMAGE_TAG} > backend_scan.txt"
            sh "aws s3 cp backend_scan.txt s3://fp-statefile-bucket/"
            sh "docker push ${env.BACKEND_REPO_URL}:${env.IMAGE_TAG}" 
          }
          dir('frontend') {
            sh "docker build -t ${env.FRONTEND_REPO_URL}:${env.IMAGE_TAG} ."
            sh "trivy image ${env.FRONTEND_REPO_URL}:${env.IMAGE_TAG} > frontend_scan.txt"
            sh "aws s3 cp frontend_scan.txt s3://fp-statefile-bucket/"
            sh "docker push ${env.FRONTEND_REPO_URL}:${env.IMAGE_TAG}" 
          }
        }
      }
    }
    stage('Update Deployment File') {
      environment {
        GIT_USER_NAME = "samiselim"
      }
      steps {
        withCredentials([string(credentialsId: 'github_tocken', variable: 'GITHUB_TOKEN')]) {
          sh 'git config user.email "jenkins@gmail.com"'
          sh 'git config user.name "jenkins"'
          sh "sed -i 's|image:.*|image: ${env.BACKEND_REPO_URL}:${env.IMAGE_TAG}|g' ./k8s/backend.yaml"
          sh "sed -i 's|image:.*|image: ${env.FRONTEND_REPO_URL}:${env.IMAGE_TAG}|g' ./k8s/frontend.yaml"

          sh 'git remote set-url origin https://samiselim:${GITHUB_TOKEN}@github.com/samiselim/FinalProject_NTI.git'
          sh 'git add .'
          sh "git commit -m 'Update deployment image to version ${BUILD_NUMBER}'"
          sh 'git push origin HEAD:main'
        }
      }
    }
  }
}
