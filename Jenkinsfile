pipeline {
    agent any
    environment {
        NAME = 'miniadmin'
        PROFILE = 'dev'
    }

    stages {
        stage('下载代码') {
            steps {
                echo '****************************** download code start... ******************************'
                git branch: 'main', url: 'https://github.com/stack-stark/k8sj.git'
            }
        }

        stage('vue环境准备') {
            steps {
                echo '****************************** vue start... ******************************'
                sh 'npm install --registry=https://registry.npm.taobao.org'
                sh 'npm run build-prod'
            }
        }

        stage('构建Docker镜像') {
            steps {
                // echo '****************************** delete container and image... ******************************'
                // sh 'docker ps -a|grep $NAME|awk \'{print $1}\'|xargs -i docker stop {}|xargs -i docker rm {}'
                // sh 'docker images|grep $NAME|grep dev|awk \'{print $3}\'|xargs -i docker rmi {}'
                echo '****************************** build image... ******************************'
                sh 'docker build -t k8sjv2 .'
                sh 'docker images'
            }
        }

        stage('运行容器') {
            steps {
                echo '****************************** run start... ******************************'
                sh 'kubectl apply  -f k8sj.yaml'
            }
        }   

        stage('检查状态') {
            steps {
                echo '****************************** check start... ******************************'
                sh 'kubectl describe pods  --namespace front-end' 
            }
        }

    }
}
