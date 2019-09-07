plot1 <- function() {
        #loads data file onto computer if it isn't already there
        if(!file.exists("household_power_consumption.txt")) {
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(url, "plotData.zip")
                unzip("plotData.zip")
        }
        
        #readdata into R
        library(data.table)
        colName <- names(fread("household_power_consumption.txt", nrows = 1))
        data <- fread("household_power_consumption.txt", skip = 66637, nrows = 2880)
        names(data) <- colName
        library(lubridate)
        data$Date <- dmy(data$Date)
        
        #Create plot
        png("plot1.png", width = 480, height = 480)
        hist(data$Global_active_power, col = "red", 
             xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
        dev.off()
}