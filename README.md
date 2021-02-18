# Afrobeats
Analysis of popular African music on Spotify
# Project description: 
This post is inspired by an article about popular podcasts in Kenya (https://nation.africa/kenya/newsplex/kenya-s-best-and-highest-earning-podcasts-3288260).I looked on Kaggle and found a dataset of African music on Spotify, most is from Nigerian artists so will refer to this data as the Afrobeats data set. Here are some plots from this data in R, access the code above. 

## 1. What is the most common genre in Afrobeats music?
The original data set has a field called "Popularity", starting from zero to the highest 73. I chose to filter out all zero values. 
No surprises here, afrobeats draws alot from dancehall music i.e. in terms of the beats. So no wonder one of the most popular genres represented is dancehall. 
Unfortunately some songs had no genre attributed to them, that is why there is a category called "Missing", this is not a real African music genre
![Popular songs histogram](popsonghistogram.jpg)

## 2. Most danceable Afrobeats songs on Spotify 
Danceability is one of the attributes of Spotify data. Danceability "describes how suitable a track is for dancing. Values range from 0.0 being least danceable and 1.0 being most danceable." 

![Most danceable songs](danceabilityplot.jpg)

## 3.Most danceable songs by African artists 
I chose to explore particular artists discography. I chose Wizkid and Davido, there was no formula to this, they just happen to have been in the industry for a long time. 
Here are the plots for each one, thought it would be more representative to have a background image of the artist for each plot. When you choose to use a background image for your plots, consider picking something that is not too busy. For this Wizkid photo, I chose one where the artist has plain grey in the background. This makes it easier for you when adjusting your bar colors for instance.

![Wizkid's most danceable songs on Spotify](wizkidgraph.jpg)

I did the same for Davido. However, I could not find a photo in a good size with a grey background. To get good color matches, you need to play around with R colors to find something that works 

![Davido's most danceable songs on Spotify](davidograph.jpg)

## 4. Which African artists are most popular on Spotify?
For this, I filtered them out of the data set based on average of the popularity scores of their songs. One you look at the plot, you notice that both Starboy and Wizkid appear, same person right? Not so much, an article on Medium explains that each moniker is associated with a particular style of music targeted at different audiences. Wizkid content is targeted at his international audience, while Starboy caters to his Nigerian fan base who love his afrobeat vibe. Read more about this here: [Wizkid or StarBoy, what's the difference?](https://medium.com/@txt_mag/wizkid-or-starboy-whats-the-difference-48000d7a846b). In this dataset, some of the artists featured include Comedians, such as the "Basketmouth" channel, had to look them up since I had not heard of them before. I chose to leave the plot as is but one can certainly filter out this group. 

![Most popular African artists on Spotify](topartist.jpg)




