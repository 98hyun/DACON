import pandas as pd

from pymongo import MongoClient
client=MongoClient('localhost', 27017)
db=client.coin
xrp=db.xrp

all_docs=xrp.find()

lst=[]
for docs in all_docs:
    data=[docs['year'],docs['start'][1:],docs['high'][1:],
    docs['low'][1:],docs['end'][1:],docs['volume'][1:],docs['price'][1:]]
    if data not in lst:
        lst.append(data)

df=pd.DataFrame(lst,columns=['year','start','high','low','end','volume','price'])
df.to_csv('5Yxrp.csv',index=False)