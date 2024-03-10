pipeline {

agent none

environment {     
    DOCKERHUB_CREDENTIALS= credentials('dockerhub-jenkins-agent3')
    DOCKER_USERNAME='lokeshjwork'
    IMAGE_NAME='devops-integration'
    IMAGE_TAG='kube-deploy'
    YAML_FILE='deploymentservice.yaml'
}

stages {
  stage('Git checkout') {	agent {label 'agent3'}
    steps {
      git branch: 'main', url: 'https://github.com/Lokeshwork/devops-automation.git'
    }
  }

  stage('build') {	agent {label 'agent3'}
    steps {
      sh 'docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG .'
    }
  }

  
stage('Login to Dockerhub') {	agent {label 'agent3'}
    steps {
      sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW> --password-stdin'
    }
  }

  stage('Pushing Image to dockerhub') {	agent {label 'agent3'}
    steps {
      sh 'docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}'
      sh 'docker logout'
    }
  }

  stage('deploying on kubernetes') {	agent {label 'Kubernetes'}
    steps {
      sh 'kubectl apply -f ${YAML_FILE}'
    }
  }
}
}
