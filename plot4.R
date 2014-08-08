load.data <- function() {
    # Read the data
    data <- read.csv(
        "household_power_consumption.txt",
        na.strings='?',        # NA is represented as ? in the file
        sep=';')

    # Restrict data to the dates of interest
    data <- data[data$Date %in% c('1/2/2007', '2/2/2007'),]

    # Convert the dates and times
    data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %T")

    data
}

data <- load.data()

gen.plot2 <- function(data) {
    with(data, plot(datetime, Global_active_power,
                    type='l',
                    ylab='Global Active Power (kilowatts)',
                    xlab=NA))
}

gen.plot3 <- function(data) {
    with(data, {
        plot(datetime, Sub_metering_1,
             type='l',
             ylab='Energy submetering',
             xlab=NA)
        lines(datetime, Sub_metering_2, col='red')
        lines(datetime, Sub_metering_3, col='blue')
    })
    legend("topright", legend=names(data)[7:9], col=c('black', 'red', 'blue'), lty='solid')
}

gen.plot4 <- function(data) {
    par(mfcol=c(2,2))
    gen.plot2(data)
    gen.plot3(data)
    with(data, {
        plot(datetime, Voltage, type='l');
        plot(datetime, Global_reactive_power, type='l')})
}

png(file='plot4.png')
gen.plot4(data)
dev.off()
