# Read only the lines necessary

df <- read.table("household_power_consumption.txt", sep=";", header=FALSE, na.strings = "?", skip = 66637, nrows = 2880,
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

df <- transform(df, Date = as.Date(Date,format="%d/%m/%Y" ))
df <- transform(df, Time = as.character(Time))
df <-transform(df,  Time=strptime( paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))

par(mfrow=c(2,2), mar=c(2,4,2,1), cex="0.70")

# First plot
with(df, plot(Time,Global_active_power, type="n", ylab="Global active power", main=""))
with(df, lines(Time, Global_active_power), type="l")

# Second Plot
with(df, plot(Time,Voltage, type="n", ylab="Voltage", xlab="datetime", main=""))
with(df, lines(Time, Voltage), type="l")

# Third Plot
with(df, plot(Time,Sub_metering_1, type="l", ylab="Energy sub metering", main=""))
with(df, lines(Time, Sub_metering_2, col="red", type="l"))
with(df, lines(Time, Sub_metering_3, col="blue", type="l"))
legend("topright", pch = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Fourth Plot
with(df, plot(Time,Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime", main=""))
with(df, lines(Time, Global_reactive_power), type="l")


dev.copy(png, file="plot4.png")
dev.off()
