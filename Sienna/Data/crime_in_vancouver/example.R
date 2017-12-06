# install ggmap using devtools package from github
#  devtools::install_github("dkahle/ggmap")
library(ggmap)
library(dplyr)
library(plyr)
d <- read.csv("crime_in_vancouver.csv", 
              header=T, stringsAsFactors = F)

m <- get_googlemap("vancouver", zoom = 15,
                   size=c(1000,1000),
                   maptype="satellite")
p <- ggmap(m)
type <- "Vehicle Collision or Pedestrian Struck (with Fatality)"
dd <- filter(d, YEAR==2003)
dd<-filter(dd, grepl("Break",dd$TYPE))
# p <- p + geom_point(mapping=aes(x=Longitude,
#                             y=Latitude,col=TYPE),
#                     data=dd)
# print(p)
# #for this longi, for every year, how many breaking and entering 
# min_long<--123.130
# max_long<--123.110
# min_lat<-49.275
# max_lat<-49.290
# 
# d_grid<-filter(d,Latitude>=min_lat,Latitude<=max_lat)
# d_grid<-filter(d_grid,Longitude>=min_long,
#                Longitude <=max_long)
# d_grid<-filter(d_grid,grepl("Break",d_grid$TYPE))
# d_out<-plyr::ddply(d_grid,.(YEAR),function(split_df){
#   nr<-nrow(split_df)
#   df_out<-data.frame(number=nc)
#   return(df_out)
# })
# 
# 
# df_filt<-d[d$Latitude<=49.290 & d$Latitude>=49.275,]
# df<-filt<-df_filt[df_filt$Longitude<=-123.130 & df_filt$Longitude>=-123.110,]
# 
