pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // 정확한 실습 6 Github 저장소 주소 확인
                git branch: 'main', url: 'https://github.com/han54369/docker-prac6.git' 
            }
        }

        stage('Build & Test') {
            steps {
                script {
                    // 핵심 수정 사항: '-u root:root' 옵션 추가
                    // Jenkins 호스트 유저(1000) 권한 대신 root 권한으로 실행하여
                    // Selenium 임시 파일 생성 권한 부족(Crash) 에러 원천 차단
                    docker.build('python-app-image').inside('-u root:root') {
                        // 권장 방식인 가상 환경(venv) 구성 및 테스트 실행
                        sh 'python -m venv venv'
                        sh '. venv/bin/activate && pip install --upgrade pip'
                        sh '. venv/bin/activate && pip install -r requirements.txt'
                        
                        // 모듈 경로 에러 방지를 위해 python -m pytest 사용
                        sh '. venv/bin/activate && python -m pytest --junitxml=report.xml'
                    }
                }
            }
            post {
                always {
                    // 테스트 성공 여부와 관계없이 테스트 결과 리포트 저장
                    junit 'report.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // 기존 컨테이너 중지 후 재배포
                    sh 'docker compose down'
                    sh 'docker compose up -d'
                }
            }
        }
    }
}
