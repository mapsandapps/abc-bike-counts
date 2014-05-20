pneu <- read.csv("pneumatic-raw.csv",
  header = TRUE,
  sep = "\t",
  col.names = c("date", "time", "nb", "sb", "wb", "eb", "location"))

# improve time format
pneu$date <- strptime(as.character(pneu$date), "%a, %b %d, %Y")
pneu$date <- format(pneu$date, "%Y-%m-%d")
pneu$time <- strptime(as.character(pneu$time), "%I:%M %p")
pneu$time <- format(pneu$time, "%H:%M")
names(pneu)[names(pneu) == 'time'] <- 'hour'


write.table(pneu,
  file = "pneumatic-clean.csv",
  quote = FALSE,
  sep = ",",
  row.names = FALSE)