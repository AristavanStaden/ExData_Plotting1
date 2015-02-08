####GETTING DATA, SUBSETTING & CONVERTING DATES & TIMES####

Alldata <- file("./data/household_power_consumption.txt")
Consumption <- read.table(text = grep("^[1,2]/2/2007", 
                             readLines(Alldata), value = TRUE), 
                                col.names = c("Date", 
                                              "Time", 
                                              "Global_active_power", 
                                              "Global_reactive_power", 
                                              "Voltage", 
                                              "Global_intensity", 
                                              "Sub_metering_1", 
                                              "Sub_metering_2", 
                                              "Sub_metering_3"), 
                 sep = ";", header = TRUE)
Consumption$Date <- as.Date(Consumption$Date, format = "%d/%m/%Y")
datetime <- paste(as.Date(Consumption$Date), Consumption$Time)
Consumption$Datetime <- as.POSIXct(datetime)
head(Consumption)

####################################################################################

###GENERATING PLOT2###

plot(Consumption$Global_active_power ~ Consumption$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png") 
dev.off()
