# 라이브러리
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from bs4 import BeautifulSoup
import requests
import time
import pandas as pd

# options
options=webdriver.ChromeOptions()
options.add_argument('user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36')

# config
basepath='C:/Users/ckdck/workspace/online/goorm/webcrawl/'
browser=webdriver.Chrome(basepath+'chromedriver_win32/chromedriver.exe',options=options)

# http://www.realtyprice.kr/notice/gsstandard/search.htm 공시지가 사이트
browser.get('http://www.realtyprice.kr/notice/gsstandard/search.htm')
browser.switch_to_default_content()
# browser.switch_to_frame('main')
time.sleep(2)

# 경기도
sido=browser.find_element_by_id('sido_list')
select=Select(sido)
select.select_by_visible_text('경기도')
time.sleep(1)

# dataframe
Arr=[]

# 수지구
sgg=browser.find_element_by_id('sgg_list')
select=Select(sgg)
select.select_by_visible_text('용인수지구')
time.sleep(1)

# 동
eub=browser.find_element_by_id('eub_list')
select=Select(eub)

soup=BeautifulSoup(browser.page_source,'lxml')
dong=soup.find('select',attrs={'id':'eub_list'})

# parse data
for d in dong:
    e=d.get_text()
    select.select_by_visible_text(e)
    browser.find_element_by_xpath('//*[@id="searchText"]/p/input').click()
    time.sleep(2)
    # page parse
    soup=BeautifulSoup(browser.page_source,'lxml')
    tbody=soup.find('tbody',attrs={'id':'dataList'})

    arr=[]
    count=0

    # page 1
    for tr in tbody.find_all('tr'):
        count+=1
        for td in tr.find_all('td'):
            arr.append(td.get_text())
        if count==2:
            arr.append('경기도 용인시 수지구')
            Arr.append(arr)
            count=0
            arr=[]

    # page 2
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[1]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 수지구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 3
    try:
        browser.find_element_by_xpath('//*[@id="pagination"]/a[2]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            break
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 수지구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 4 
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[3]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 수지구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

time.sleep(1)

# 기흥구
sgg=browser.find_element_by_id('sgg_list')
select=Select(sgg)
select.select_by_visible_text('용인기흥구')
time.sleep(1)

# 동
eub=browser.find_element_by_id('eub_list')
select=Select(eub)

soup=BeautifulSoup(browser.page_source,'lxml')
dong=soup.find('select',attrs={'id':'eub_list'})

# parse data
for d in dong:
    e=d.get_text()
    select.select_by_visible_text(e)
    browser.find_element_by_xpath('//*[@id="searchText"]/p/input').click()
    time.sleep(2)
    # page parse
    soup=BeautifulSoup(browser.page_source,'lxml')
    tbody=soup.find('tbody',attrs={'id':'dataList'})

    arr=[]
    count=0

    # page 1
    for tr in tbody.find_all('tr'):
        count+=1
        for td in tr.find_all('td'):
            arr.append(td.get_text())
        if count==2:
            arr.append('경기도 용인시 기흥구')
            Arr.append(arr)
            count=0
            arr=[]

    # page 2
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[1]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 기흥구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 3
    try:
        browser.find_element_by_xpath('//*[@id="pagination"]/a[2]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            break
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 기흥구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 4 
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[3]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 기흥구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

time.sleep(1)

# 처인구
sgg=browser.find_element_by_id('sgg_list')
select=Select(sgg)
select.select_by_visible_text('용인처인구')
time.sleep(1)

# 동
eub=browser.find_element_by_id('eub_list')
select=Select(eub)

soup=BeautifulSoup(browser.page_source,'lxml')
dong=soup.find('select',attrs={'id':'eub_list'})

# parse data
for d in dong:
    e=d.get_text()
    select.select_by_visible_text(e)
    browser.find_element_by_xpath('//*[@id="searchText"]/p/input').click()
    time.sleep(2)
    # page parse
    soup=BeautifulSoup(browser.page_source,'lxml')
    tbody=soup.find('tbody',attrs={'id':'dataList'})

    arr=[]
    count=0

    # page 1
    for tr in tbody.find_all('tr'):
        count+=1
        for td in tr.find_all('td'):
            arr.append(td.get_text())
        if count==2:
            arr.append('경기도 용인시 처인구')
            Arr.append(arr)
            count=0
            arr=[]

    # page 2
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[1]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 처인구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 3
    try:
        browser.find_element_by_xpath('//*[@id="pagination"]/a[2]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            break
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 처인구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

    # page 4 
    try: 
        browser.find_element_by_xpath('//*[@id="pagination"]/a[3]').click()
        time.sleep(2)

        soup=BeautifulSoup(browser.page_source,'lxml')
        tbody=soup.find('tbody',attrs={'id':'dataList'})

        arr=[]
        count=0

        for tr in tbody.find_all('tr'):
            count+=1
            for td in tr.find_all('td'):
                arr.append(td.get_text())
            if count==2:
                arr.append('경기도 용인시 처인구')
                Arr.append(arr)
                count=0
                arr=[]
    except:
        pass

time.sleep(1)

realprice=pd.DataFrame(Arr,columns=['일련번호','소재지','면적(m2)','지목','공시지가(원/m2)','지리적위치','이용상황','주위환경','도로교통','형상지세','용도지역','주소'])

print(realprice.head())

realprice.to_csv('realprice.csv',index=False)
time.sleep(1)

browser.quit()