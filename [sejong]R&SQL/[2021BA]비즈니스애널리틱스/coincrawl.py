from selenium import webdriver

import requests
from bs4 import BeautifulSoup
import time

from pymongo import MongoClient
client=MongoClient('localhost', 27017)
db=client.coin
xrp=db.xrp

options=webdriver.ChromeOptions()
# options.headless=True
options.add_argument('window-size=1920x1080')
options.add_experimental_option("excludeSwitches", ["enable-logging"])
options.add_argument('user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36')

browser=webdriver.Chrome('./chromedriver_win32/chromedriver.exe',
options=options)

url='https://coinmarketcap.com/ko/currencies/xrp/historical-data/'
browser.get(url)
time.sleep(3)

count=0
button='//*[@id="__next"]/div/div[1]/div[2]/div/div[3]/div/div/p[1]/button'

y=3500
while count!=61:
    # 선택
    browser.execute_script(f'window.scrollTo(0, {y});')
    browser.find_elements_by_xpath(button)[0].click()
    # 대기
    time.sleep(3)
    # 조건
    count+=1
    y+=1500
    if count%5==0:
        y+=190

trs=browser.find_elements_by_css_selector('tbody tr')
# print(trs)
# print(f"len(trs) : {len(trs)}")
for tr in trs:
    lst=tr.text.split(' ')

    year=lst[0]+' '+lst[1]+' '+lst[2]
    start=lst[3]
    high=lst[4]
    low=lst[5]
    end=lst[6]
    volume=lst[7]
    price=lst[8]

    data={
        'year':year,
        'start':start,
        'high':high,
        'low':low,
        'end':end,
        'volume':volume,
        'price':price
    }

    # print(data)
    xrp.insert_one(data)

time.sleep(7)
browser.quit()
