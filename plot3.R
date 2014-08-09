# function to read in data betweeen two dates from a flat file
# plot the specified data and save the plot to a PNG

Plot3 = function(){
    FlatFileName = "household_power_consumption.txt"
    
	# The start and end date are provided by the assignment
    StartDateTime = strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
    StopDateTime = strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S")
    
	# Read only the first row of the file
    Row1 = read.table(FlatFileName, sep=";", nrows=1, header=T, na.strings="?")
	# Save the Column Names for later
    ColumnNames = colnames(Row1)
    
	# Combine the Date and Time and parse it into a POSIXct
    Row1dt = paste(Row1[[1]], Row1[[2]], sep=" ")
    Row1DateTime = strptime(Row1dt, "%d/%m/%Y %H:%M:%S")
    
	# Calculate the number of Rows to Skip and the number of rows to read
    # Add 1 for the Header
    RowsToSkip = difftime(StartDateTime, Row1DateTime, units="mins") + 1
    RowsToRead = difftime(StopDateTime, StartDateTime, units="mins") + 1
    #print(paste("Skip =", RowsToSkip, "Select =", RowsToRead))
    
	# Skip x number of rows and read in y number of rows. restore
	# the column names
    data = read.table(FlatFileName, sep=";", skip=RowsToSkip, nrows=RowsToRead, header=F, na.strings="?")
    colnames(data) = ColumnNames
    
    #print( head(data, n=1) )
    #print( tail(data, n=1) )
    
	# Create a sequence of POSIXct datetime by mins to plot on the x axis
    sdt = seq(StartDateTime, StopDateTime, "mins")
    
	# Create a plot with Energy sub metering series and a legend. 
	# save the file as PNG
    png(file="plot3.png", width=480, height=480)
    plot(x=sdt, y=data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(x=sdt, y=data$Sub_metering_2, col="red")
    lines(x=sdt, y=data$Sub_metering_3, col="blue")
    axis.POSIXct(1,at = seq(StartDateTime, StopDateTime, "days"), format = "%a")
    legend("topright", legend=colnames(data)[c(7:9)], lwd=1, col=c("black","red","blue"))
    dev.off()
}
