from selenium import webdriver
from selenium.webdriver.chrome.options import Options

def test_google_title():
    # Docker 환경(GUI 화면 없음)을 위한 Chrome Headless 설정
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    
    # 드라이버 실행 및 웹페이지 접속
    driver = webdriver.Chrome(options=chrome_options)
    
    try:
        driver.get("https://www.google.com")
        assert "Google" in driver.title
    finally:
        driver.quit()