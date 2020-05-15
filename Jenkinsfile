pipeline {
  agent {
    label {
      label "build-centos"
      customWorkspace "${env.WORKSPACE}/../workspace/${env.JOB_NAME}/${env.BUILD_NUMBER}"
    }
  }

  stages{
    stage('Build image') {
      when { branch 'release-0.23' }
      steps {
        sh """
docker version

#Script to build binary and image
make build image image-retag

#Build Docker image
docker tag prometheus repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.23.0-fork-$BUILD_NUMBER .
docker push repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.23.0-fork-$BUILD_NUMBER
echo "Done"
        """
      }
    }
  }
}