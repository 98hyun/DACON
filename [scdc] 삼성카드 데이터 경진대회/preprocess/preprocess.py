#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd


# In[2]:


info=pd.read_csv('../raw/[Track1_데이터1] mrc_info.csv',encoding='cp949')
train=pd.read_csv('../raw/[Track1_데이터2] samp_train.csv',encoding='cp949')
cst=pd.read_csv('../raw/[Track1_데이터3] samp_cst_feat.csv',encoding='cp949')
dtype=pd.read_csv('../raw/[Track1_데이터4] variable_dtype.csv')


# In[3]:


Train=pd.merge(train,cst,on=['cst_id_di'])
Train['MRC_ID_DI']=Train['MRC_ID_DI'].replace({1:1,2:1,3:1,4:1,5:1,6:1,7:1,8:1,9:1,10:1})


# In[4]:


notFeature=['cst_id_di','MRC_ID_DI']
feature=[col for col in Train.columns if col not in notFeature]

X=Train[feature]
y=Train['MRC_ID_DI']


# In[5]:


X.to_csv('train_preprocess.csv')
y.to_csv('test_preprocess.csv')

