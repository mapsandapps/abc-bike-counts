library(plyr)

seasonal <- read.csv("seasonal.csv",
  sep = ",")


# this function will take two time periods and sum up data for
# all intersections that were observed for both time periods
# and calculate the change in riders

compare <- function(data, season1, season2, time) {
  # get data for season1
  dataS1 <- data[data$season == season1 & data$time == time,
    c("location", "season", "time", "total", "Latitude", "Longitude")]

  # get data for season2
  dataS2 <- data[data$season == season2 & data$time == time,
    c("season", "total", "Latitude", "Longitude")]

  # merge season1 and season2 by long & lat
  bothSeasons <- merge(dataS1, dataS2,
    by = c("Longitude", "Latitude"))

  outputData <- ddply(bothSeasons, .(time, season.x, season.y), summarize,
    count.x = sum(total.x),
    count.y = sum(total.y),
    intersections = length(total.x)
  )

  outputData$change <- (outputData$count.y - outputData$count.x) / outputData$count.x

  # return(bothSeasons)



  write.table(outputData, 
    file = "time-comparison.csv",
    append = TRUE,
    quote = FALSE,
    sep = ",",
    row.names = FALSE,
    col.names = FALSE)
}

compare(seasonal, "Fall 2009", "Fall 2010", "AM")
compare(seasonal, "Fall 2010", "Fall 2011", "AM")
compare(seasonal, "Fall 2011", "Fall 2012", "AM")
compare(seasonal, "Fall 2012", "Fall 2013", "AM")
compare(seasonal, "Fall 2009", "Fall 2013", "AM")
compare(seasonal, "Fall 2009", "Fall 2010", "PM")
compare(seasonal, "Fall 2010", "Fall 2011", "PM")
compare(seasonal, "Fall 2011", "Fall 2012", "PM")
compare(seasonal, "Fall 2012", "Fall 2013", "PM")
compare(seasonal, "Fall 2009", "Fall 2013", "PM")
compare(seasonal, "Spring 2009", "Spring 2010", "AM")
compare(seasonal, "Spring 2010", "Spring 2011", "AM")
compare(seasonal, "Spring 2011", "Spring 2012", "AM")
compare(seasonal, "Spring 2012", "Spring 2013", "AM")
compare(seasonal, "Spring 2009", "Spring 2013", "AM")
compare(seasonal, "Spring 2009", "Spring 2010", "PM")
compare(seasonal, "Spring 2010", "Spring 2011", "PM")
compare(seasonal, "Spring 2011", "Spring 2012", "PM")
compare(seasonal, "Spring 2012", "Spring 2013", "PM")
compare(seasonal, "Spring 2009", "Spring 2013", "PM")