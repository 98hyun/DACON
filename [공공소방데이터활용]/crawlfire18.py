# library
from bs4 import BeautifulSoup
import requests
import sqlite3

# config
s_key='qfc3a1UrA1TUTqi5MLpiAVuYEktqTznfXceNTrSSkfhRyAijwPF4e95Ya7KVROhJiHBXHe9Cb6T6n8mwCK9qZA=='
headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36'}
con=sqlite3.connect('fire.db')
cur=con.cursor()

# ready
pageNo=1
numOfRows=50

for date in range(20210121,20210404):

    ocrn_ymd=date
    url=f'http://apis.data.go.kr/1661000/FireInformationService/getArFireByplceFpcnd?serviceKey={s_key}&pageNo={pageNo}&numOfRows={numOfRows}&resultType=json&ocrn_ymd={ocrn_ymd}'

    res=requests.get(url,headers=headers)

    res=res.json()
    items=res['response']['body']['items']['item']

    for item in items:
        sidoNm=item['sidoNm']
        vctmPercnt=item['vctmPercnt']
        lifeDmgPercnt=item['lifeDmgPercnt']
        injrdprPercnt=item['injrdprPercnt']
        firePlceSctnNm=item['firePlceSctnNm']   
        prptDmgSbttAmt=item['prptDmgSbttAmt']   
        ocrnMnb=item['ocrnMnb']
        ocrnYmd=item['ocrnYmd']

        values=[(sidoNm,vctmPercnt,lifeDmgPercnt,injrdprPercnt,firePlceSctnNm,prptDmgSbttAmt,ocrnMnb,ocrnYmd)]
        
        cur.executemany("insert into accident values (?,?,?,?,?,?,?,?)",values)
        # Save (commit) the changes
        con.commit()
con.close()