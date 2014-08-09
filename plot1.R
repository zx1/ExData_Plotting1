# function to read in data betweeen two dates from a flat file
# plot the specified data and save the plot to a PNG

Plot1 = function(){
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
    
	# Create a histogram of Global active power and save it as a PNG
    png(file="plot1.png", width=480, height=480)
    hist(data$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
}
