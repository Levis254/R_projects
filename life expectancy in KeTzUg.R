library(gapminder)
View(gapminder)
library(tidyverse)
names(gapminder)
#select life expectancy data for Kenya, Tanzania, and Uganda
data<-gapminder %>% 
  select(country, year, lifeExp) %>% 
  filter(country %in% c("Kenya", "Tanzania", "Uganda"))
View(data)
