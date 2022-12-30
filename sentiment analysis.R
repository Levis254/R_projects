#Sentiment analysis model in R
install.packages("tidytext")
library(tidytext)
load the data set with sentiments
sentiments
#retrieve these bing lexicons
get_sentiments("bing")

library(stringr)
library(tidyverse)
install.packages("janeaustenr")
library(janeaustenr)

tidy_data<-austen_books()%>%
  group_by(book)%>%
  mutate(linenumber=row_number(),
         chapter=cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                               ignore_case=TRUE))))%>%
  ungroup()%>%
  unnest_tokens(word, text)
# we use book sense and sensibility and derive its words to implement

positive_senti<-get_sentiments("bing")%>%
  filter(sentiment=="positive")
#find the count of positive words semi joining with the positive sentiment derived dataset
tidy_data%>%
  filter(book=='Emma')%>%
  semi_join(positive_senti)%>%
  count(word, sort=TRUE)

bing<-get_sentiments("bing")
Emma_sentiment<-tidy_data %>%
  inner_join(bing)%>%
  count(book="Emma", index=linenumber%/%80, sentiment)%>%
  spread(sentiment,n,fill=0)%>%
  mutate(sentiment=positive-negative)

#visualize the sentiment analysis

ggplot(Emma_sentiment, aes(index, sentiment, fill=book))+
  geom_bar(stat="identity", show.legend=TRUE)+
  facet_wrap(~book, ncol=2, scales="free_x")

counting_words<-tidy_data%>%
  inner_join(bing)%>%
  count(word, sentiment, sort=TRUE)
counting_words%>%
  filter(n>150)%>%
  mutate(n=ifelse(sentiment=="negative",-n,n))%>%
  mutate(word=reorder(word,n))%>%
  ggplot(aes(word,n, fill=sentiment))+
  geom_col()+
  coord_flip()+
  labs(y="Sentiment Score")

#visualise using a word cloud
install.packages("reshape2")
install.packages("wordcloud")
library(reshape2)
library(wordcloud)

tidy_data%>%
  inner_join(bing)%>%
  count(word, sentiment, sort=TRUE)%>%
  acast(word~sentiment, value.var="n", fill=0)%>%
  comparison.cloud(colors=c("red","dark blue"),
                   max.words=100)
