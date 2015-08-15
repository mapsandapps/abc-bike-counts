pneu <- read.csv("pneumatic-clean.csv",
  header = TRUE,
  sep = ",")

# define day of the week as a factor
pneu$day <- weekdays(as.Date(pneu$date))

# define weekday
pneu$weekday <- ifelse(pneu$day == "Saturday" | pneu$day == "Sunday", 
  "Weekend", 
  "Weekday")

# define beltline
pneu$beltline <- ifelse(substr(pneu$location, 1, 8) == "BeltLine", 
  "Beltline",
  "Not Beltline")


library(plyr)
timeOfDay <- ddply(pneu, .(hour), summarize, 
  riders = sum(nb, na.rm = TRUE) + 
    sum(sb, na.rm = TRUE) + 
    sum(wb, na.rm = TRUE) + 
    sum(eb, na.rm = TRUE))
timeOfDayLoc <- ddply(pneu, .(hour, location), summarize, 
  riders = sum(nb, na.rm = TRUE) + 
    sum(sb, na.rm = TRUE) + 
    sum(wb, na.rm = TRUE) + 
    sum(eb, na.rm = TRUE))
dayTime <- ddply(pneu, .(hour, location, weekday, beltline), summarize,
  riders = sum(nb, na.rm = TRUE) + 
    sum(sb, na.rm = TRUE) + 
    sum(wb, na.rm = TRUE) + 
    sum(eb, na.rm = TRUE))
beltlineData <- ddply(pneu, .(hour, weekday, beltline), summarize,
  ridersPerHour = (sum(nb, na.rm = TRUE) + 
    sum(sb, na.rm = TRUE) + 
    sum(wb, na.rm = TRUE) + 
    sum(eb, na.rm = TRUE)) / length(hour))

library(ggplot2)
ggplot(beltlineData[beltlineData$weekday == "Weekday" & beltlineData$beltline == "Beltline",],
  aes(x = hour, y = ridersPerHour)) +
geom_bar()

library(reshape)
beltlineWide <- cast(beltlineData[beltlineData$beltline == "Beltline",], hour ~ weekday)
notBeltlineWide <- cast(beltlineData[beltlineData$beltline == "Not Beltline",], hour ~ weekday)

allWide <- merge(beltlineWide, notBeltlineWide,
  by.x = "hour",
  by.y = "hour",
  suffixes = c('Beltline', 'Other'))

# round
allWide[1:length(allWide$hour),2:5] <- round(allWide[1:length(allWide$hour),2:5],
  3)



# write.table(allWide,
#   file = "for-d3.csv",
#   quote = FALSE,
#   sep = ",",
#   row.names = FALSE)


