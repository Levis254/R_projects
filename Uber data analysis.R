#Uber data analysis
library(ggplot2)#ggplot2 for data visualization
library(ggthemes)
library(lubridate)#use timeframes in the dataset
library(dplyr)#dplyr for data manipuation
library(tidyr)#tidyr for tidying the data
#dt for data tables in JS
library(DT)
#scales for helping in graphical scales
library(scales)


color=c("#CC1011", "#665555", "#05a399", "#cfcaca","#f5e840","#0683c9","#e075b0")
color

setwd("C:/Users/Noor/OneDrive/Desktop")
apr<-read.csv("uber-raw-data-apr14.csv")
jun<-read.csv("uber-raw-data-jun14.csv")
jul<-read.csv("uber-raw-data-jul14.csv")
aug<-read.csv("uber-raw-data-aug14.csv")
may<-read.csv("uber-raw-data-may14.csv")
sep<-read.csv("uber-raw-data-sep14.csv")

#combine the data together
data<-rbind(apr,may,jun,jul,aug,sep)
View(data)
#summary of the data
summary(data)
#print the first 6 rows of the data
head(data)

#we use the Date Time function to convert the date time factor into a more readable format

data$Date.Time<-as.POSIXct(data$Date.Time, format="%m/%d/%Y %H:%M:%S")
data$Time<-format(as.POSIXct(data$Date.Time, format="%m/%d/%Y %H: %M: %S" ), format= "%H: %M: %S")
data$Date.Time<-ymd_hms(data$Date.Time)

#create individual columns for month day and year

data$day<-factor(day(data$Date.Time))
data$month<-factor(month(data$Date.Time, label=TRUE))
data$year<-factor(year(data$Date.Time))
data$dayofweek<-factor(wday(data$Date.Time, label=TRUE))

#add Time variable as well

data$second=factor(second(hms(data$Time)))
data$minute=factor(minute(hms(data$Time)))
data$hour=factor(hour(hms(data$Time)))


View(data)

hourly_data<-data %>% 
  group_by(hour) %>% 
  dplyr::summarize(Total=n())
View(hourly_data)
#show data in searchable js table
datatable(hourly_data)

#plot the data by hour

ggplot(hourly_data, aes(hour, Total))+
  geom_bar(stat="identity",
           fill="steelblue")+
  ggtitle("Trips Every Hour", subtitle="aggregated 11/3/2022")+
  theme(legend.position="none",
        plot.title=element_text(hjust=0.5),
        plot.subtitle=element_text(hjust=0.5))+
  scale_y_continuous(labels=comma)

#aggregate the data by month and hour

month_hour_data<-data %>% 
  group_by(month, hour) %>% 
  dplyr::summarize(Total=n())

#show data in searchable js table

datatable(month_hour_data)

ggplot(month_hour_data, aes(hour, Total, fill=month))+
  geom_bar(stat="identity")+
  ggtitle("Trips by Month and Hour")+
  scale_y_continuous(labels=comma)+
  theme(legend.position="none",
        plot.title=element_text(hjust=0.5),
        plot.subtitle=element_text(hjust=0.5))

#aggregate data by day of the month
day_data<-data %>% 
  group_by(day) %>% 
  dplyr::summarize(Trips=n())

#show data in searchable js table
datatable(day_data)
#plot the data by data
ggplot(day_data, aes(day, Trips))+
  geom_bar(stat="identity",
           fill="steelblue")+
  ggtitle("Trips by day of the month")+
  theme(legend.position = "none",
        plot.title = element_text(hjust=0.5))+
  scale_y_continuous(labels=comma)

