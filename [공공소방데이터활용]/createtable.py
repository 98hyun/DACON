import sqlite3
import pandas as pd

con=sqlite3.connect('fire.db')
cur=con.cursor()

# table 
rows=cur.execute("select * FROM fire")

data=pd.DataFrame(rows,
columns=['sidoNm','flsrpPrcsMnb','slfExtshMnb','fireRcptMnb','stnEndMnb','ocrnYmd','falsDclrMnb'])

data.to_csv('fire.csv',index=False)
    