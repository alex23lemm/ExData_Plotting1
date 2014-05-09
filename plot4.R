# Load libraries and modify locale ---------------------------------------------

library(lubridate)
# Set locale to "C" (reflects North-American usage) for category "LC_TIME" which
# controls rendering of month names in plots
Sys.setlocale(category = "LC_TIME", locale = "C")

# Load data --------------------------------------------------------------------

hpc_df <- read.table('./raw_data/household_power_consumption.txt', 
                     header = TRUE, sep = ';', na.strings = c('?'))


# Pre-process data -------------------------------------------------------------

names(hpc_df) <- tolower(names(hpc_df))

# Subset data according to instructions
hpc_df <- hpc_df[hpc_df$date %in% c('1/2/2007', '2/2/2007'), ]

# Merge date column and time column and convert result into POSIXct format
hpc_df$date_time <- paste(as.character(hpc_df$date), as.character(hpc_df$time),
                          sep = "_")
hpc_df$date_time <- dmy_hms(hpc_df$date_time)

# Drop unnecessary columns
hpc_df$date <- NULL
hpc_df$time <- NULL


# Create and save plot ---------------------------------------------------------

png('plot4.png')
par(mfrow = c(2, 2))
with(hpc_df, {
  # Plot date time vs. global active power
  plot(date_time, global_active_power, xlab = '', ylab = 'Global Active Power',
       type = 'n')
  lines(date_time, global_active_power)
  # Plot date time vs. voltage
  plot(date_time, voltage, xlab = 'datetime', ylab = 'Voltage', type = 'n')
  lines(date_time, voltage)
  # Plot date time vs. sub metering 1-3
  plot(date_time, sub_metering_1, xlab = "",
       ylab = 'Energy sub metering ', type = 'n')
  lines(date_time, sub_metering_1)
  lines(date_time, sub_metering_2, col = 'red')
  lines(date_time, sub_metering_3, col = 'blue')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 
                                'Sub_metering_3'), 
         col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
  # Plot date time vs global reactive power
  plot(date_time, global_reactive_power, xlab = 'datetime', 
       ylab = 'Global_reactive_power', type = 'n')
  lines(date_time, global_reactive_power)
})
dev.off()
