FROM python:3.10-alpine

# Selenium & Chromium 설치
RUN apk add --no-cache chromium chromium-chromedriver

WORKDIR /app
COPY . .

# Python 의존성 설치
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["pytest", "-v"]