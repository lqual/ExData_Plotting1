subsetdata <- function() {
        #loads data file onto computer if it isn't already there
        if(!file.exists("household_power_consumption.txt")) {
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(url, "plotData.zip")
                unzip("plotData.zip")
        }
        
        #readdata into R
        library(data.table)
        data <- fread("household_power_consumption.txt")
        
        #figure out how many rows to skip and how many to read
        place <- c(1:length(data$Date))
        library(lubridate)
        date <- dmy(data$Date)
        locate <- data.frame(place, date)
        library(dplyr)
        locate <- locate %>% mutate(logic = as.numeric(date)) %>% 
                        filter(logic == 13545 | logic == 13546)
        skiprows <- locate$place[1]
        numrows <- length(locate$place)
        
        #figure out column names and read table into R
        colName <- names(fread("household_power_consumption.txt", nrows = 1))
        data <- fread("household_power_consumption.txt", skip = skiprows, nrows = numrows)
        names(data) <- colName
        
        #result is a list of dataframe, value to plug into skip, and value to plug into nrows
        list(data, c("skip", skiprows), c("nrows", numrows))
}