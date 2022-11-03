
api_key<-"mdqQibuyIzZwxUPV9Squ35"
api_secret<-"d8acobenOyToLJ96lpkR1YC7X76fDVO25J3WMWLKWR5tJv"
access_token<-"2552858940-eNV4XyqQpGhWH18cHsGqg36VGWyLLhO8V4Zz"
access_token_secret<-"skTOsGLE1wJeZHKrhXJI7dQZ0MSKnRumc8Ef9KIgdqlC5"


setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

remove.packages("twitteR")
library(twitteR)
