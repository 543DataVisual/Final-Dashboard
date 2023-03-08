------------------------------------
#  Deliverable 1:
#clean memory
rm(list = ls())

#loading packages
library(ggplot2)
library(tidyverse)
library(ggthemes)

#loading in data
location='https://github.com/543DataVisual/Deliverable1/raw/main/' 
file='copy_tractassignments.csv'
link=paste0(location,file)
mydata=read.csv(link)

------------------------------------------
#Deliverable 2:
# clean memory
rm(list = ls())

#loading packages
library(dplyr)
library(ggplot2)
library(tidyverse)
library(magrittr)
library(scales)

#Loading in data
location='https://github.com/543DataVisual/deliverable2/raw/main/'
file='airbnb_final.csv'
link=paste0(location,file)

airbnb_data=read.csv(link)

#aggregating data
(airbnb_locrating=table(airbnb_data$low_rating,airbnb_data$address))

(locrating_col=prop.table(airbnb_locrating, margin = 2) %>% round(.,1))
(rating_address = as.data.frame(airbnb_locrating))
as.data.frame(locrating_col)
rating_address$share = as.data.frame(locrating_col)[,3]
rating_address

names(rating_address)[1:3] = c("rating","location","counts")
rating_address

write.csv(file = "rating_address.csv")



-------------------------------------------
  Deliverable 3:
# clean memory
rm(list = ls())

#Installing packages
library(sf)
library(ggplot2)

#loading in shape file
maplink = 'https://github.com/543DataVisual/Deliverable-3/raw/main/ESDIST.geojson'
mapWorld=read_sf(maplink)

#loading in data file
location ='https://github.com/543DataVisual/Deliverable-3/raw/main/'
file ='cleanedtractsfiledeliverable3.2.csv'
datalink = paste0(location,file)

mydata = read.csv(datalink)

#aggregating the data to be organized by school district name with mean per capita income and total non English as the variables
deliverable3 = aggregate(data=mydata,cbind(per_cap_income,total_non_english)~NAME,mean)


#merging data file to map file by school district name
mapWorld_indexes = merge(mapWorld, 
                         deliverable3, 
                         by='NAME')
st_write(mapWorld_indexes,
         "mapWorld_indexes.geojson",
         delete_dsn = T)

