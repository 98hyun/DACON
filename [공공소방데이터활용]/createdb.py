import sqlite3

con=sqlite3.connect('fire.db')
cur=con.cursor()

# drop table
# cur.execute("DROP TABLE accident")
# print("Table dropped... ")

# #Commit your changes in the database
# con.commit()

# # Create table 1
# cur.execute('''
# CREATE TABLE fire 
# (sidoNm text, 
# flsrpPrcsMnb integer,
# slfExtshMnb integer, 
# fireRcptMnb integer, 
# stnEndMnb integer, 
# ocrnYmd text,
# falsDclrMnb integer)
# ''')

# # Create table 18
# cur.execute('''
# CREATE TABLE accident 
# (sidoNm text, 
# vctmPercnt integer,
# lifeDmgPercnt integer, 
# injrdprPercnt integer, 
# firePlceSctnNm integer,
# prptDmgSbttAmt integer,
# ocrnMnb integer, 
# ocrnYmd text)
# ''')
