raw <- read.csv("raw-data.csv",
  header = TRUE,
  col.names = c("location", "time", "season", "male", "female", 
    "ageu18", "age19to39", "age40up", 
    "helmet", "onstreet", "trafficdirection", "laws", "bikelane", 
    "nrgender", "nrage", "nrhelmet", "nrstreet", "nrdirection", "nrlaws", "nrbikelane"))

cleaned <- raw[,1:3]

cleaned$male <- NA
cleaned$male[raw$male==1 & raw$female!=1] <- 1
cleaned$male[raw$male!=1 & raw$female==1] <- 0

cleaned$female <- NA
cleaned$female[raw$female==1 & raw$male!=1] <- 1
cleaned$female[raw$female!=1 & raw$male==1] <- 0

cleaned$ageu18 <- NA
cleaned$ageu18[raw$ageu18==1 & raw$age19to39!=1 & raw$age40up!=1] <- 1
cleaned$ageu18[raw$ageu18!=1 & raw$age19to39==1 & raw$age40up!=1] <- 0
cleaned$ageu18[raw$ageu18!=1 & raw$age19to39!=1 & raw$age40up==1] <- 0

cleaned$age19to39 <- NA
cleaned$age19to39[raw$ageu18==1 & raw$age19to39!=1 & raw$age40up!=1] <- 0
cleaned$age19to39[raw$ageu18!=1 & raw$age19to39==1 & raw$age40up!=1] <- 1
cleaned$age19to39[raw$ageu18!=1 & raw$age19to39!=1 & raw$age40up==1] <- 0

cleaned$age40up <- NA
cleaned$age40up[raw$ageu18==1 & raw$age19to39!=1 & raw$age40up!=1] <- 0
cleaned$age40up[raw$ageu18!=1 & raw$age19to39==1 & raw$age40up!=1] <- 0
cleaned$age40up[raw$ageu18!=1 & raw$age19to39!=1 & raw$age40up==1] <- 1

cleaned$helmet <- NA
cleaned$helmet[raw$helmet==1 & raw$nrhelmet==0] <- 1
cleaned$helmet[raw$helmet==0 & raw$nrhelmet==0] <- 0

cleaned$onstreet <- NA
cleaned$onstreet[raw$onstreet==1 & raw$nrstreet==0] <- 1
cleaned$onstreet[raw$onstreet==0 & raw$nrstreet==0] <- 0

cleaned$trafficdirection <- NA
cleaned$trafficdirection[raw$trafficdirection==1 & raw$nrdirection==0] <- 1
cleaned$trafficdirection[raw$trafficdirection==0 & raw$nrdirection==0] <- 0

cleaned$laws <- NA
cleaned$laws[raw$laws==1 & raw$nrlaws==0] <- 1
cleaned$laws[raw$laws==0 & raw$nrlaws==0] <- 0

cleaned$bikelane <- NA
cleaned$bikelane[raw$bikelane==1 & raw$nrbikelane==0] <- 1
cleaned$bikelane[raw$bikelane==0 & raw$nrbikelane==0] <- 0


library(plyr)
seasonal <- ddply(cleaned, .(season, time, location), summarize, 
  total = length(season),
  malepercent = mean(male),
  male = sum(male), 
  female = sum(female), 
  helmet = mean(helmet),
  onstreet = mean(onstreet),
  trafficdirection = mean(trafficdirection),
  laws = mean(laws),
  bikelane = mean(bikelane))

locations <- read.csv("locations.csv",
  header = TRUE)

seasonal <- merge(seasonal, locations, 
  by.x = "location",
  by.y = "Location")

seasonal <- seasonal[order(seasonal$season, seasonal$time),]


write.table(seasonal[!is.na(seasonal$Latitude),],
  file = "seasonal.csv",
  quote = FALSE,
  sep = ",",
  row.names = FALSE)