library(tidyverse)
library(dplyr)
library(gridExtra)
library(scales)
library(janitor)
library(jpeg)
library(grid)


nigeriansongs<-read.csv("C:\\Users\\warau\\Documents\\R\\nigerian_spotify_songs1.csv")
nigeriansongs<-janitor::clean_names(nigeriansongs)

#Convert fields to factors
nigeriansongs$artist<-as.factor(nigeriansongs$artist)
nigeriansongs$artist_top_genre<-as.factor(nigeriansongs$artist_top_genre)
nigeriansongs$release_date<-as.factor(nigeriansongs$release_date)

#most commonly occuring music genre in Afrobeat music
ggplot(nigeriansongs, aes(artist_top_genre)) +
  geom_bar(fill = "dodgerblue")+coord_flip()+
  theme_bw()+xlab("music genres")

#Song popularity by genre
popsongs1<-filter(nigeriansongs,popularity>0)

ggplot(nigeriansongs, aes(popularity,fill=artist_top_genre))+
  geom_histogram(binwidth=9)+theme_bw()
ggplot(popsongs1, aes(popularity,fill=artist_top_genre))+
  geom_histogram(binwidth=9)+theme_bw()+
  labs(fill="music genre")


#Filter songs with popularity over 50
popularsongs<-filter(nigeriansongs,popularity>50)
popularsongs <- popularsongs[-c(26),] 

#Filter popularity over 50 for each year 
set2017 <-filter(nigeriansongs,popularity>50,release_date==2017)

set2018 <-filter(nigeriansongs,popularity>50,release_date==2018)

set2019 <-filter(nigeriansongs,popularity>50,release_date==2019)
set2019 <- set2019[-c(11),] 

set2020 <-filter(nigeriansongs,popularity>50,release_date==2020)

ggplot(data = set2017, mapping = aes(x = reorder(name, popularity),popularity)) + 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2017")+
  coord_flip()+xlab("")+theme_bw()+
  scale_x_discrete(labels=wrap_format(10))

ggplot(data = set2018, mapping = aes(x = reorder(name, popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+
  ggtitle("Most popular songs 2018")+
  coord_flip()+xlab("")+theme_bw()+
  scale_x_discrete(labels=wrap_format(17))
                     

ggplot(data = set2019, mapping = aes(x=reorder(name,popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2019")+
  coord_flip()+theme_bw()+xlab("")+
  scale_x_discrete(labels=wrap_format(15))
  
                    
ggplot(data = set2020, mapping = aes(x = reorder(name,popularity),popularity))+ 
  geom_bar(stat = "Identity",fill="goldenrod")+ 
  ggtitle("Most popular songs 2020")+
  coord_flip()+theme_bw()+xlab("")+
  scale_x_discrete(labels=wrap_format(17))

#Most danceable songs, ordered by danceability
ggplot(data = popularsongs, mapping = aes(x = reorder(name, danceability), danceability)) + 
  geom_bar(stat = "Identity",fill="orangered") + 
  ggtitle("Most danceable songs")+xlab("")+
  coord_flip()+theme_bw()

danceplot=ggplot(data = popularsongs, mapping = aes(x = reorder(name, danceability), danceability)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Danceability")+
  coord_flip()+
  scale_x_discrete(guide = ggplot2::guide_axis(n.dodge = 2),labels = function(x) stringr::str_wrap(x, width = 20))




#Most popular songs
popularityplot=ggplot(data = popularsongs, mapping = aes(x = reorder(name, popularity), popularity)) + 
  geom_bar(stat = "identity") + coord_flip()+ggtitle("Popularity")
grid.arrange(popularityplot,danceplot,nrow=1,ncol=2)

risky_df<-filter(popularsongs,name=="Risky")

ggplot(popularsongs, aes(x = reorder(artist,-popularity),y=popularity)+ 
         geom_bar(stat = "identity"))

ggplot(popularsongs)+geom_violin(aes(popularity,artist_top_genre))
ggplot(popularsongs, aes(popularity,fill=artist))+
  geom_histogram(binwidth=10)+theme_bw()

barplot(height=nigeriansongs$popularity, names=nigeriansongs$artist)


ggplot(popularsongs,aes(artist))+geom_point(aes(y=popularity))+
  coord_flip()

#Filter 2017 data: 
songs_2017 <-filter(nigeriansongs,release_date=="2017",artist_top_genre=="afropop")
ggplot(songlist2,aes(x=danceability,y=name))+geom_point()

ggplot(songlist2,aes(x=danceability,fct_reorder(name, danceability)))+
  geom_point(color="blue")+theme_bw()

WizKid_df<-filter(nigeriansongs,artist=="WizKid")
WizKid_df <- WizKid_df[-c(1),] 
wizkid_img <- readJPEG("wizkid.jpg")

wizkidgraph=ggplot(WizKid_df,aes(x=reorder(name,danceability),danceability)) + 
  ggtitle("Wizkid most danceable songs on Spotify")+
  scale_fill_continuous(guide = FALSE)+
  annotation_custom(rasterGrob(wizkid_img, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf)+
  geom_bar(stat = "identity",position = "dodge",alpha=0.5,fill="orangered",colour="grey")+ 
  xlab("")+coord_flip()+
  scale_x_discrete(labels(wrap_format(10))

ggsave("wizkidgraph.pdf",width = 297,height = 210,units = c("mm"),dpi = 300)
ggsave("wizkidgraph.jpg",width = 297,height = 210,units = c("mm"),dpi = 300)

davido_img<-readJPEG("davido.jpg")
Davido_df<-filter(nigeriansongs,artist=="DaVido")
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

#Filter all songs by Burna Boy 
Burna_df<-filter(nigeriansongs,artist=="Burna Boy")


artist_summary <- nigeriansongs %>%
  group_by(artist) %>%
  summarise(popularity = mean(popularity, na.rm = TRUE))

ggplot(artist_summary)+geom_bar()
topartist<-filter(artist_summary, popularity > 39)
ggplot(data = topartist, mapping = aes(x = reorder(artist, popularity), popularity)) + 
  geom_bar(stat = "Identity") + 
  ggtitle("Most popular artists")+
  coord_flip()+
  scale_x_discrete(labels(wrap_format(10))+
                     theme_light())

par(mar=c(1,1,1,1))
beeswarm(WizKid_df$popularity)

