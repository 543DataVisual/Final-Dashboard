------------------------------------
 # Deliverable 1:
#clean memory
rm(list = ls())

#loading in data
location='https://github.com/543DataVisual/Deliverable1/raw/main/' 
file='copy_tractassignments.csv'
link=paste0(location,file)
mydata=read.csv(link)
#creating elements to be included on visual
message = "*Only 1 tract contains highest quantity
            of non-english speakers in it*"
mn = mean(mydata$total_non_english,na.rm = T)
annMean = paste0('Mean:',round(mn))
labels = labs(x = "Non-English Speakers", y = "Counts of Tracts", title = "Total Non-English Speakers", 
              subtitle = "in Each Tract in The City of Bellevue, Washington USA")
gginfo = mydata %>% ggplot(aes(x = total_non_english)) +
  geom_histogram(fill = "#a3b18a", color = "white") + 
  geom_vline(aes(xintercept=mean(total_non_english))) +
  annotate(geom = 'text',color='red',
           label=annMean,
           y = 4,
           x= mn+100,
           angle=90) +
  annotate(geom = 'text', color="#a3b18a",
           label=message,
           y=3,
           x=mn+1400,
           angle=0)
#creating visual
graph = 
  gginfo + 
  labels + 
  theme_few()
graph

saveRDS(graph,file="graph.rds")

------------------------------------
# Deliverable 2:
# clean memory 
rm(list = ls())
#loading in data
location='https://github.com/543DataVisual/deliverable2/raw/main/'
file='rating_address.csv'
link=paste0(location,file)

airbnb_data=read.csv(link)

#creating plot

basel = ggplot(data=rating_address,
                 aes(x=location, y=share, fill=reorder(rating,share)))
barstacked = basel + geom_bar(stat = 'identity', position = 'stack')
barstacked = barstacked + geom_text(size = 2,
                                      position = position_stack(vjust = 0.6),
                                      aes(label = scales::percent (share,accuracy = 0.1)))
barstacked = barstacked + scale_y_continuous(labels = scales::percent) + labs(title= 'Airbnb Rating by Location')
barstacked

saveRDS(barstacked,file="graph2.rds") 
----------------------------------
  Deliverable 3:
# clean memory
rm(list = ls())
library(sf)
#loading in shape file
maplink = 'https://github.com/543DataVisual/Deliverable-3/raw/main/ESDIST.geojson'
mapWorld=read_sf(maplink)

mapWorld_indexes=read_sf("mapWorld_indexes.geojson")
#creating a map layer
baseMap = ggplot(data=mapWorld) + theme_classic() + 
  geom_sf(fill='grey', 
          color=NA)

#layering the data layer on top of the map layer
numericMap = baseMap + geom_sf(data=mapWorld_indexes,
                               aes(fill=total_non_english), 
                               color=NA)

#adding labels to map
labels = labs(title = "Non English Speakers by Elementary School Boundary", 
              subtitle = "The City of Bellevue, Washington USA")
graph = numericMap +
  labels
Legend_title ="Total Non English Speakers 
(grey indicates missing values)"

graph + scale_fill_gradient(name = Legend_title) +
  theme_minimal()

saveRDS(graph,file="map.rds") 
  