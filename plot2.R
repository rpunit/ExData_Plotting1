# Read only the lines necessary

df <- read.table("household_power_consumption.txt", sep=";", header=FALSE, na.strings = "?", skip = 66637, nrows = 2880,
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

df <- transform(df, Date = as.Date(Date,format="%d/%m/%Y" ))
df <- transform(df, Time = as.character(Time))
df <-transform(df,  Time=strptime( paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))

with(df, plot(Time,Global_active_power, type="n", ylab="Global active power (Kilowatts)", main=""))
with(df, lines(Time, Global_active_power), type="l")

dev.copy(png, file="plot2.png")
dev.off()
