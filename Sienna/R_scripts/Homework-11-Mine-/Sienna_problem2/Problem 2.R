'for each year, for each tile, get events.Tile and find the top 5
count number of events for each and save this number

once i have those 5 tiles, i can plot those coordinates by creating a data frame
with a row for each tile. 

when i plot, i can use geom point to put points for each event in each tile
'

#i think this is tech my ANALYSIS 

d<-load_filtered_dataset()
years<-unique(d$YEAR)
n_years<-length(years)

max_lat <- 49.29723
min_lat <- 49.20091
max_long <- -123.0236
min_long <- -123.2199

for (i in 1:n_years){
  cur_year<-years[i]
  d<-dplyr::filter(d,YEAR==cur_year)
  browser()
  events <- dplyr::select(d, Longitude, Latitude)
  
  mt <- ManyTiles(min_lat, max_lat, min_long, max_long, 10, 5, events)
  
  number_tiles <- get_number_tiles.ManyTiles(mt)
  num_events <- rep(NA, number_tiles)  #so i can get the number of events for each tile
  for (i in 1:number_tiles) {
    current_tile <- get_tile.ManyTiles(mt, i)
    current_events <- get_events.Tile(current_tile)
    num_events[i] <- nrow(current_events)
    #now find top 5 boxes and plot it 
  }
  num_events<-order(num_events)
  top_5<-num_events[1:5]
  
  tile1 <- get_tile.ManyTiles(mt, top_5[1]) 
  tile2 <- get_tile.ManyTiles(mt, top_5[2]) #HOW COME THE EVENTS LIST IS EMPTY
  tile3 <- get_tile.ManyTiles(mt, top_5[3])
  tile4 <- get_tile.ManyTiles(mt, top_5[4])
  tile5 <- get_tile.ManyTiles(mt, top_5[5])
 
  tile_list <- list(tile1,tile2,tile3,tile4,tile5)
  df_list <- as.list(rep(NA, 5))
  for (i in 1:5) {
    df_list[[i]] <- Tile_to_rectangle_df(tile_list[[i]]) #data frame form so that i can do the map
  }
  df <- do.call(rbind, df_list)
  m <- get_googlemap("vancouver ca", zoom = 11)
  p <- ggmap(m)
  p <- p + geom_rect(mapping=aes(xmin=min_long, xmax=max_long,
                                 ymin=min_lat, ymax=max_lat),
                     data=df, fill=NA, size=1, color="red",
                     inherit.aes=FALSE)
  print(p) #still have to add the data points to each of the 5 boxes in this map
  
}
  