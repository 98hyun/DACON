import re
import requests
from bs4 import BeautifulSoup
# import csv

# config
headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36'}
baseurl='https://search.naver.com/search.naver?'
params={
    'where':'news',
    'query':'코로나 종식',
    'start':0
}
f=open('./[visualization]/corona_finish.txt',encoding='utf-8-sig',mode='a')
# writer=csv.writer(f)

# regex
p=re.compile('([0-9가-힣]+)')

# scrap

for i in range(10,101,10):
    print(i)
    params['start']=i
    # ready
    res=requests.get(url=baseurl,headers=headers,params=params)
    soup=BeautifulSoup(res.text,'lxml')

    # find new list
    news_list=soup.find('ul',attrs={'class':'list_news'}).find_all('li')
        
    # find articles
    for news in news_list:
        title=news.find('a',attrs={'class':'news_tit'})
        if title:
            title=title.get_text()
        else:
            continue
        
        content=news.find('a',attrs={'class':'api_txt_lines dsc_txt_wrap'}).get_text()
        
        # regex edit
        title_list=p.findall(title)
        content_list=p.findall(content)

        title_list.extend(content_list)
        # put it in.
        f.writelines([f"{lst}\n"for lst in title_list])

# file close
f.close()