library(tidyverse)
library(dplyr)
library(gridExtra)
library(scales)
library(janitor)
library(jpeg)
library(grid)

#Load Nigerian songs dataset
nigeriansongs<-read.csv("~/GitHub/Afrobeats/nigerian_spotify_songs.csv")
nigeriansongs<-janitor::clean_names(nigeriansongs)

#Convert fields to factors
nigeriansongs$artist<-as.factor(nigeriansongs$artist)
nigeriansongs$artist_top_genre<-as.factor(nigeriansongs$artist_top_genre)
nigeriansongs$release_date<-as.factor(nigeriansongs$release_date)

#most commonly occuring music genre in Afrobeat music
ggplot(nigeriansongs, aes(artist_top_genre)) +
  geom_bar(fill = "dodgerblue")+coord_flip()+
  theme_bw()+xlab("music genres")

#Song popularity by genre, filtering out those with values of zero
popsongs1<-filter(nigeriansongs,popularity>0)

#Plot histogram of popular song genres
popsonghistogram=ggplot(popsongs1, aes(popularity,fill=artist_top_genre))+
  geom_histogram(binwidth=9)+theme_bw()+
  labs(fill="music genre")

#Save plots as either pdf or jped                   
ggsave("popsonghistogram.pdf",width = 297,height = 210,units = c("mm"),dpi = 300)
ggsave("popsonghistogram.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)

#Which are the most popular songs?
#Filter songs with popularity over 50
popularsongs<-filter(nigeriansongs,popularity>50)

#Removing one track that is repeated- Risky by Davido
popularsongs <- popularsongs[-c(26),] 

#Which are the most popular songs from past 4 years
#Filter popularity over 50 for each year 2017-2020
set2017 <-filter(nigeriansongs,popularity>50,release_date==2017)

set2018 <-filter(nigeriansongs,popularity>50,release_date==2018)

set2019 <-filter(nigeriansongs,popularity>50,release_date==2019)
#remove a repeated track - Risky by Davido
set2019 <- set2019[-c(11),] 

set2020 <-filter(nigeriansongs,popularity>50,release_date==2020)

songplot1=ggplot(data = set2017, mapping = aes(x = reorder(name, popularity),popularity)) + 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2017")+
  coord_flip()+xlab("")+theme_bw()+
  scale_x_discrete(labels=wrap_format(10))

songplot2=ggplot(data = set2018, mapping = aes(x = reorder(name, popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+
  ggtitle("Most popular songs 2018")+
  coord_flip()+xlab("")+theme_bw()+
  scale_x_discrete(labels=wrap_format(17))
                     
songplot3=ggplot(data = set2019, mapping = aes(x=reorder(name,popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2019")+
  coord_flip()+theme_bw()+xlab("")+
  scale_x_discrete(labels=wrap_format(15))
  
songplot4=ggplot(data = set2020, mapping = aes(x = reorder(name,popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2020")+
  coord_flip()+theme_bw()+xlab("")+
  scale_x_discrete(labels=wrap_format(17))

#Arrange plots in a grid
grid.arrange(songplot1,songplot2,nrow=2,ncol=1)
grid.arrange(songplot3,songplot4,nrow=2,ncol=1)

#Save plots as either pdf or jped                   
ggsave("songplot3.pdf",width = 297,height = 210,units = c("mm"),dpi = 300)
ggsave("songplot3.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)

#Popular songs by artist. Picked two Wizkid and Davido
#Filter songs by Wizkid
WizKid_df<-filter(nigeriansongs,artist=="WizKid")
WizKid_df <- WizKid_df[-c(1),] 

#Load the background images to use in plot
wizkid_img <- readJPEG("wizkid.jpg")
davido_img<-readJPEG("davido.jpg")

#To insert background image we use the annotation custom function in R
wizkidgraph=ggplot(WizKid_df,aes(x=reorder(name,danceability),danceability))+ 
  ggtitle("Wizkid most danceable songs on Spotify")+xlab("")+
  scale_fill_continuous(guide = FALSE)+
  annotation_custom(rasterGrob(wizkid_img, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf)+
  geom_bar(stat = "identity",position = "dodge",alpha=0.5,fill="orangered",colour="grey")+ 
  coord_flip()+ scale_x_discrete(labels=wrap_format(15))

#Save plots as either pdf or jped                   
ggsave("wizkidgraph.pdf",width = 297,height = 210,units = c("mm"),dpi = 300)
ggsave("wizkidgraph.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)
           
#Filter songs by Davido
Davido_df<-filter(nigeriansongs,artist=="DaVido")
#Remove one repeated track - Risky
Davido_df <- Davido_df[-c(14),] 

davidograph=ggplot(data = Davido_df, mapping = aes(x = reorder(name, danceability),danceability))+ 
  ggtitle("Davido most danceable songs on Spotify")+xlab("")+
  scale_fill_continuous(guide = FALSE)+
  annotation_custom(rasterGrob(davido_img, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf)+
  geom_bar(stat = "identity",position = "dodge",alpha=0.5,fill="lightgoldenrod1",colour="black")+ 
  coord_flip()+theme(axis.text = element_text(size = 10))+
  scale_x_discrete(labels=wrap_format(10))
ggsave("davidograph.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)

# What are the most danceable songs
danceabilityplot=ggplot(data = popularsongs, mapping = aes(x = reorder(name, danceability), danceability))+ 
   geom_bar(stat = "identity",fill="blanchedalmond",color="orangered")+
   xlab("")+coord_flip()+ theme_bw()+
  ggtitle("Most danceable Afrobeats on Spotify 1998-2020")

#Save plots as either pdf or jped                   
ggsave("danceabilityplot.pdf",width = 297,height = 210,units = c("mm"),dpi = 300)
ggsave("danceabilityplot.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)

#Highest popularity score is 73, filter out those with 40 and above
topartist<-filter(artist_summary, popularity > 39)

#Top African artists on Spotify
ggplot(data = topartist, mapping = aes(x = reorder(artist, popularity), popularity)) + 
  geom_bar(stat = "Identity",fill="blanchedalmond",color="orangered3") + 
  ggtitle("Most popular African artists Spotify")+
  coord_flip()+ theme_bw()+
  scale_x_discrete(labels(wrap_format(10))+
                     theme_light())


