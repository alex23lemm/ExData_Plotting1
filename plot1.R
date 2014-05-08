
# Load data --------------------------------------------------------------------

hpc_df <- read.table('./raw_data/household_power_consumption.txt', 
                     header = TRUE, sep = ';', na.strings = c('?'))


# Pre-process data -------------------------------------------------------------

names(hpc_df) <- tolower(names(hpc_df))

# Subset data according to instructions
hpc_df <- hpc_df[hpc_df$date %in% c('1/2/2007', '2/2/2007'), ]


# Create and save plot ---------------------------------------------------------

png('plot1.png')
hist(hpc_df$global_active_power, 
     col = 'red', 
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency', 
     main = 'Global Active Power')
dev.off()





