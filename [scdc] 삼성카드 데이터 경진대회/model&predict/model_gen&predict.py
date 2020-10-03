#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pickle
import numpy as np
import pandas as pd
import sklearn
import lightgbm
from matplotlib import pyplot as plt


# In[2]:


categorical_feature=list(dtype[dtype.dType=='categorical'].Variable_Name.values)


# In[3]:


X=pd.read_csv('../preprocess/train_preprocess.csv',index_col=0)
y=pd.read_csv('../preprocess/test_preprocess.csv',index_col=0)


# In[4]:


X_train,X_test,y_train,y_true=sklearn.model_selection.train_test_split(X,y,test_size=0.2,random_state=2020)

params={
    'objective':'binary',
    'metric':'binary_logloss',
    'is_unbalance':True,
    'learning_rate':0.03,
    'verbose':0    
}


# In[5]:


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


# In[6]:


for model in models:
    print(f"best score :",model.best_score['valid_0']['binary_logloss'])


# In[7]:


data=pd.concat([pd.DataFrame(model.predict(X_test,raw_score=True)),y_true.reset_index(drop=True)],axis=1)
data['yPred']=np.where(data[0]<-1.2,0,1)
data.columns=['판별함수','yTrue','yPred']
data.index=y_true.index
data=pd.concat([train.iloc[y_true.index]['cst_id_di'],data],axis=1)


# In[8]:


fpr,tpr,threshold=sklearn.metrics.roc_curve(y_true,data['yPred'])
auc=sklearn.metrics.auc(fpr,tpr)
plt.plot(fpr,tpr)
plt.plot([0,1],[0,1],'k--')
plt.title("auc score : "+str(auc))
plt.show()


# In[9]:


data.sort_values(['판별함수'],ascending=False)[:405]['yPred'].value_counts(),
data.sort_values(['판별함수'],ascending=False)['yPred'].value_counts()
data.to_csv('quiz_s.csv')

# LIFT = 2.78
# auroc = 0.79


# In[10]:


with open('final_model.sav','wb') as file:
    pickle.dump(model,file)

