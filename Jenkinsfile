pipeline {
  agent {
    label {
      label "build-centos"
      customWorkspace "${env.WORKSPACE}/../workspace/${env.JOB_NAME}/${env.BUILD_NUMBER}"
    }
  }

  stages{
    stage('Build image') {
      when { branch 'release-0.18' }
      steps {
        sh """
docker version

#Script to build binary
cat > build.sh << EOF
cd /go/src/github.com/coreos/prometheus-operator/
go get -u github.com/prometheus/promu
/go/bin/promu build --prefix ./.build/linux-amd64/ -v
EOF

#Get the binary built at the right place
docker run  --rm  --name goo -v "${env.WORKSPACE}":/go/src/github.com/coreos/prometheus-operator/ golang:1.13.4 /bin/bash /go/src/github.com/coreos/prometheus-operator/build.sh

#Build Docker image
docker build -t repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.18.0-fork-$BUILD_NUMBER .
docker push repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.18.0-fork-$BUILD_NUMBER
echo "Done"
        """
      }
      when { branch 'release-0.19' }
      steps {
        sh """
docker version

#Script to build binary
cat > build.sh << EOF
cd /go/src/github.com/coreos/prometheus-operator/
go get -u github.com/prometheus/promu
/go/bin/promu build --prefix ./.build/linux-amd64/ -v
EOF

#Get the binary built at the right place
docker run  --rm  --name goo -v "${env.WORKSPACE}":/go/src/github.com/coreos/prometheus-operator/ golang:1.13.4 /bin/bash /go/src/github.com/coreos/prometheus-operator/build.sh

#Build Docker image
docker build -t repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.19.0-fork-$BUILD_NUMBER .
docker push repocache.nonprod.ppops.net/dev-docker-local/prometheus/prometheus-operator:v0.19.0-fork-$BUILD_NUMBER
echo "Done"
        """
      }      
    }
  }
}
