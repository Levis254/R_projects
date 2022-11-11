library(ggplot2)
library(tidyverse)
world_map<-map_data("world")
1
#check the first six rows
world_map %>% head
View(world_map)

#plot the map of Kenya
Kenya<-world_map %>% 
  filter(region=="Kenya")

  
ggplot(data=Kenya, aes(x=long, y=lat, map_id=region))+
  geom_map(map=Kenya)
