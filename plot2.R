plot2 <- function() {
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
        date <- with(data, dmy(Date) + hms(Time))
        date <- as.POSIXct(date)
        data <- data[, -c(1,2)]
        data <- data %>% mutate(Date = date)
        
        #Create plot
        png("plot2.png", width = 480, height = 480)
        plot(data$Date, data$Global_active_power, type = "l", 
             xlab = "", ylab = "Global Active Power (kilowatts)")
        dev.off()
}