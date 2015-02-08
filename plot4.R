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

###GENERATING PLOT4###

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(Consumption, {
        plot(Global_active_power ~ Datetime, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ Datetime, col = 'Red')
        lines(Sub_metering_3 ~ Datetime, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ Datetime, type = "l", 
             ylab = "Global_rective_power", xlab = "datetime")
})
dev.copy(png, file = "plot4.png") 
dev.off()

