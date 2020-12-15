# table 1

products=read.csv("./csv/products(1).csv",stringsAsFactors=F,na.strings=c("NA","NULL"))
od=read.csv("./csv/orderdetails.csv",stringsAsFactors=F,na.strings=c("NA","NULL"))

merge1=products %>% inner_join(od) %>%
group_by(productCode) %>% 
summarise(SumOfQuantityOrdered=sum(quantityOrdered),
Average_Sales_Price=mean(priceEach)) %>%
arrange(desc(SumOfQuantityOrdered))

x=c("productName","productCode","productVendor","SumOfQuantityOrdered")
merge2=select(products,productCode,productName,productVendor,productLine)

data2=merge1 %>% inner_join(merge2)
data=slice(data2[x],1:10)


# table 1 
# ggplot

# 3
ggplot(data2, aes(x = Average_Sales_Price, y = SumOfQuantityOrdered)) +
geom_point(aes(color = productLine)) +
geom_smooth(se = FALSE)+
labs(title = "graph 1-3 scatter plot",
       subtitle = "graph 2 same",
       x = "Average Sales Price",
       y = "SumOfQuantityOrdered",
       color = "productLine")

# 4
ggplot(data2,aes(x=Average_Sales_Price,y=SumOfQuantityOrdered))+
geom_point(aes(color=productLine))+
facet_wrap(~productLine)+
labs(title = "graph 1-4 split scatter plot",
		subtitle="wrap by productline",	
       x = "Average Sales Price",
       y = "SumOfQuantityOrdered",
       color = "productLine")

# 1
ggplot(data,aes(y=reorder(productName,SumOfQuantityOrdered),
x=SumOfQuantityOrdered))+
geom_bar(stat="identity",colour='black',fill='#CCCCCC')+
geom_text(aes(label=SumOfQuantityOrdered),
color='white',hjust=1.5)+
labs(title = "Graph 1-1 bar plot",
		subtitle="Top 10 products by quantity of ordered",
       x = "Sum Of Quantity Ordered",
       y = "Product Names",
       color = "productLine")

# 2
ggplot(data2,aes(x=Average_Sales_Price))+
geom_histogram(aes(y=..density..),fill='white',
colour='black',binwidth=9)+
geom_density(fill='#f8867d',alpha=0.5)+
labs(title="Graph 1-2",
subtitle="average sales price all products",
x="average Sales Price",
y="density")


# table 2

customers=read.csv("./csv/customers.csv",stringsAsFactors=F,na.strings=c('NA','NULL'))
od=read.csv("./csv/orderdetails.csv",stringsAsFactors=F,na.strings=c('NA','NULL'))
orders=read.csv("./csv/orders.csv",stringsAsFactors=F,na.strings=c('NA','NULL'))

merge1=merge(customers,orders,by='customerNumber')
merge2=merge(merge1,od,by='orderNumber') %>%
select(customerNumber,customerName,city,country,quantityOrdered,priceEach,creditLimit)

merge3=merge2 %>% group_by(customerNumber) %>%
summarise(Amount=sum(quantityOrdered*priceEach))

y=c("customerNumber","customerName","city","country","creditLimit")
merge2=distinct(merge2[y])
merge4=merge3 %>% inner_join(merge2)
x=c("customerNumber","customerName","city","country","Amount")
data=merge4[x] %>%
arrange(desc(Amount)) %>% slice(1:10)

## ggplot2

# 3
ggplot(merge4, aes(x = creditLimit, y = Amount)) +
geom_point(aes(color = country)) +
geom_smooth(se = FALSE)+
labs(title = "graph 1-3 scatter plot and regression plot",
       subtitle = "graph 2 same",
       x = "creditLimit",
       y = "Amount",
       color = "country")

# 4
ggplot(merge4,aes(x=creditLimit,y=Amount))+
geom_point(aes(color=country))+
facet_wrap(~ country)+
labs(title = "graph 1-4 split scatter plot",
		subtitle="wrap by country",	
       x = "credit Limit",
       y = "Amount",
       color = "country")

# 1
data$Amount=round(data$Amount,1)
ggplot(data,aes(y=reorder(customerName,Amount),
x=Amount))+
geom_bar(stat="identity",colour='black',fill='#CCCCCC')+
geom_text(aes(label=Amount),
color='white',hjust=1.2)+
labs(title = "Graph 1-1 bar plot",
		subtitle="Top 10 products by Amount",
       x = "Amount",
       y = "customer Names")

# 2
ggplot(merge4,aes(x=creditLimit))+
geom_histogram(aes(y=..density..),fill='white',
colour='black',binwidth=10000)+
geom_density(fill='#f8867d',alpha=0.5)+
labs(title="Graph 1-2",
subtitle="creditLimit of all customers",
x="creditLimit",
y="density")
