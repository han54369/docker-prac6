from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

def test_google_title():
    chrome_options = Options()
    # Alpine 리눅스에 설치된 Chromium 실제 경로 지정
    chrome_options.binary_location = '/usr/bin/chromium-browser'
    
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    
    # Alpine 리눅스에 설치된 Chromedriver 실제 경로 지정
    service = Service('/usr/bin/chromedriver')
    
    # 드라이버 실행 시 service와 options 함께 전달
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    try:
        driver.get('https://www.google.com')
        assert 'Google' in driver.title
    finally:
        driver.quit()
