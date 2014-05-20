pneu <- read.csv("pneumatic-clean.csv",
  header = TRUE,
  sep = ",")

# define day of the week as a factor
pneu$day <- weekdays(as.Date(pneu$date))

# define weekday
pneu$weekday <- ifelse(pneu$day == "Saturday", "Weekend", ifelse(pneu$day == "Sunday", 
  "Weekend", "Weekday"))


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
dayTime <- ddply(pneu, .(hour, location, weekday), summarize,
  riders = sum(nb, na.rm = TRUE) + 
    sum(sb, na.rm = TRUE) + 
    sum(wb, na.rm = TRUE) + 
    sum(eb, na.rm = TRUE))

library(ggplot2)
# ggplot(data = timeOfDayLoc,
#   aes(x = hour, y = riders, fill = location)) +
# geom_bar(stat = "identity",
#   position = position_dodge())



# # plot beltline only
# ggplot(data = timeOfDayLoc[substr(timeOfDayLoc$location, 1, 8) == "BeltLine",],
#   aes(x = as.numeric(hour) - 0.5, y = riders)) +
# geom_bar(stat = "identity") +
# scale_x_continuous(breaks = seq(0, 24, 4),
#   limits = c(0, 24))

# # plot non-beltline only
# ggplot(data = timeOfDayLoc[substr(timeOfDayLoc$location, 1, 8) != "BeltLine",],
#   aes(x = as.numeric(hour) - 0.5, y = riders)) +
# geom_bar(stat = "identity") +
# scale_x_continuous(breaks = seq(0, 24, 4),
#   limits = c(0, 24))

write.table(dayTime,
  file = "time-weekday.csv",
  quote = FALSE,
  sep = ",",
  row.names = FALSE)


