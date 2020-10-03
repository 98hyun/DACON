#!/usr/bin/env python
# coding: utf-8

# # data load

# In[1]:


import pickle
import numpy as np
import pandas as pd
import sklearn
import lightgbm
from matplotlib import pyplot as plt


# In[2]:


info=pd.read_csv('./raw/[Track1_데이터1] mrc_info.csv',encoding='cp949')
train=pd.read_csv('./raw/[Track1_데이터2] samp_train.csv',encoding='cp949')
cst=pd.read_csv('./raw/[Track1_데이터3] samp_cst_feat.csv',encoding='cp949')
dtype=pd.read_csv('./raw/[Track1_데이터4] variable_dtype.csv',encoding='cp949')


# # data browse
# 

# In[3]:


def datainfo(df):
    return pd.DataFrame([(col,df[col].nunique(),df[col].isna().sum(),df[col].dtype,df[col].unique()[:5]) for col in df.columns],
                       columns=['name','nunique','missing','dtype','value :5'])


# In[4]:


# datainfo(info)
# datainfo(train)
# datainfo(cst)
# datainfo(dtype)


# # data cleaning

# In[5]:


# 0 미용 1 6 8 홈쇼핑 2 3 5 10 종합몰 4 9 전문몰 7 오픈마켓_소셜
# info


# In[6]:


# 미이용 대다수 그 뒤로 오픈마켓 홈쇼핑 등.
# train.MRC_ID_DI.value_counts(normalize=True)


# In[7]:


# 숫자형 범주형 나누기
# dtype.dType.unique()
categorical_feature=list(dtype[dtype.dType=='categorical'].Variable_Name.values)


# In[8]:


Train=pd.merge(train,cst,on=['cst_id_di'])
Train['MRC_ID_DI']=Train['MRC_ID_DI'].replace({1:1,2:1,3:1,4:1,5:1,6:1,7:1,8:1,9:1,10:1})


# In[9]:


notFeature=['cst_id_di','MRC_ID_DI']
feature=[col for col in Train.columns if col not in notFeature]

X=Train[feature]
y=Train['MRC_ID_DI']


# # binary baseline model

# In[10]:


X_train,X_test,y_train,y_true=sklearn.model_selection.train_test_split(X,y,test_size=0.2,random_state=2020)

params={
    'objective':'binary',
    'metric':'binary_logloss',
    'is_unbalance':True,
    'learning_rate':0.03,
    'verbose':0    
}


# In[11]:


cv=sklearn.model_selection.KFold(n_splits=6,shuffle=True,random_state=2020)
oof_train=dict()
models=[]

for foldId,(train_idx,valid_idx) in enumerate(cv.split(X_train)):
    X_tr,X_val=X_train.iloc[train_idx],X_train.iloc[valid_idx]
    y_tr,y_val=y_train.iloc[train_idx],y_train.iloc[valid_idx]

    lgbTrain=lightgbm.Dataset(X_tr,y_tr,categorical_feature=categorical_feature)
    lgbValid=lightgbm.Dataset(X_val,y_val,reference=lgbTrain,categorical_feature=categorical_feature)

    model=lightgbm.train(params,lgbTrain,num_boost_round=3000,valid_sets=[lgbValid],early_stopping_rounds=70,
                        verbose_eval=50,categorical_feature=categorical_feature)
    models.append(model)
    res=model.predict(X_test,raw_score=True,num_iteration=model.best_iteration)
    
    oof_train[f"oof_{foldId}"]=res


# In[12]:


for model in models:
    print(f"best score :",model.best_score['valid_0']['binary_logloss'])


# In[13]:


# fpr,tpr,threshold=sklearn.metrics.roc_curve(y_true,oof_train['oof_0'])
# auc=sklearn.metrics.roc_auc_score(y_true,oof_train['oof_0'])
# plt.plot(fpr,tpr)
# plt.plot([0,1],[0,1],'k--')
# plt.title("auc score : "+str(auc))
# plt.show()


# In[14]:


with open('final_model.sav','wb') as file:
    pickle.dump(models[0],file)


# In[15]:


data=pd.concat([pd.DataFrame(model.predict(X,raw_score=True)),y],axis=1)
data['yPred']=np.where(data[0]<-1.2,0,1)
data.columns=['판별함수','yTrue','yPred']
data.index=y.index
data=pd.concat([train.iloc[y.index]['cst_id_di'],data],axis=1)


# In[16]:


fpr,tpr,threshold=sklearn.metrics.roc_curve(y,data['yPred'])
auc=sklearn.metrics.auc(fpr,tpr)
plt.plot(fpr,tpr)
plt.plot([0,1],[0,1],'k--')
plt.title("auc score : "+str(auc))
plt.show()


# In[17]:


# data.to_csv('quiz_s.csv')


# In[18]:


data.sort_values(['판별함수'],ascending=False)[:2025]['yPred'].value_counts(),data.sort_values(['판별함수'],ascending=False)['yPred'].value_counts()

# LIFT = 2.78
# auroc = 0.79


# # data eda

# In[19]:


lightgbm.plot_importance(model,figsize=(15,50),max_num_features=50,dpi=200,importance_type="gain")


# In[20]:


cat=X[categorical_feature]
num=X.drop(categorical_feature,axis=1)

feature=['VAR003','VAR226','VAR025','VAR138','VAR104','VAR065','VAR167','VAR075','VAR103','VAR217','VAR040',
'VAR031','VAR050','VAR156','VAR048','VAR210','VAR017','VAR090','VAR197','VAR041','VAR101','VAR042',
'VAR027','VAR120','VAR171','VAR130','VAR108','VAR024','VAR036','VAR105','VAR010','VAR049','VAR002',
'VAR181','VAR173','VAR192','VAR183','VAR086','VAR062','VAR008','VAR201','VAR152','VAR136','VAR022',
'VAR016','VAR212','VAR172','VAR131','VAR185','VAR035']

num=num[feature]
num=pd.concat([Train['MRC_ID_DI'],num],axis=1)
# num=num[num['MRC_ID_DI']==1]


# In[21]:


for col in num.columns:
    num[col]=num[col].apply(lambda x:1 if x>0 else 0)


# # Marketing

# In[22]:


from mlxtend.frequent_patterns import apriori

baskets=apriori(num.iloc[:,30:50],use_colnames=True,min_support=0.7)
baskets.sort_values(['support'],ascending=False)[:20]


# In[23]:


from mlxtend.frequent_patterns import association_rules

association_rules(baskets,min_threshold=0.1).sort_values(['lift','conviction'],ascending=False)

