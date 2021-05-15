import pandas as pd
from selenium import webdriver
import time
import requests
from bs4 import BeautifulSoup

options=webdriver.ChromeOptions()
# options.headless=True
options.add_argument('window-size=1920x1080')
options.add_experimental_option("excludeSwitches", ["enable-logging"])
options.add_argument('user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36')

browser=webdriver.Chrome('./chromedriver_win32/chromedriver.exe',
options=options)

url='https://coinmarketcap.com/ko/exchanges/upbit/'
headers={'User-Agent':'user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36'}
browser.get(url)

path='https://coinmarketcap.com'

values=[]
idxs=[]

for i in range(1,268):
    data=[]
    browser.execute_script(f'window.scrollTo({i*30},{i*40})')
    td2_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[2]/div'
    td3_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[3]/div'
    td4_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[4]/div'
    td5_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[5]/div'
    td6_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[6]/div'
    td7_xpath=f'//*[@id="__next"]/div[1]/div[2]/div/div[1]/div[2]/div[1]/div[2]/div[3]/div/table/tbody/tr[{i}]/td[7]/div'

    td2=browser.find_element_by_xpath(td2_xpath)

    elem=td2.find_element_by_css_selector('a')
    if elem.text in idxs:
        continue

    td3=browser.find_element_by_xpath(td3_xpath).text
    td4=browser.find_element_by_xpath(td4_xpath).text
    td5=browser.find_element_by_xpath(td5_xpath).text
    td6=browser.find_element_by_xpath(td6_xpath).text
    td7=browser.find_element_by_xpath(td7_xpath).text

    sub_url=elem.get_attribute("href")
    sub_res=requests.get(sub_url,headers=headers)
    sub_soup=BeautifulSoup(sub_res.text,'lxml')

    try:
        money=sub_soup.find_all('div',attrs={'class':'statsValue___2iaoZ'})
        if elem.text not in idxs:
            values.append([elem.text,td3,td4,td5,td6,td7])
    except:
        continue

    # print(values)
    # break

df=pd.DataFrame(values,columns=['통화','쌍','가격','거래량(24시간)','거래량(%)','유동성'])
# df.to_csv('upbit.csv')

browser.quit()