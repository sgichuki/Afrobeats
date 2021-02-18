# Afrobeats
Analysis of popular African music on Spotify
# Project description: 
This post is inspired by an article about popular podcasts in Kenya (https://nation.africa/kenya/newsplex/kenya-s-best-and-highest-earning-podcasts-3288260).I looked on Kaggle and found a dataset of African music on Spotify, most is from Nigerian artists so will refer to this data as the Afrobeats data set. Here are some plots from this data in R.

1. What is the most common genre in Afrobeats music?
Start by loading the data and all necessary libraries

library(tidyverse)
library(dplyr)
library(gridExtra)
library(scales)
library(janitor)
library(jpeg)
library(grid)

nigeriansongs<-read.csv("C:\\Users\\warau\\Documents\\R\\nigerian_spotify_songs1.csv")
nigeriansongs<-janitor::clean_names(nigeriansongs)
