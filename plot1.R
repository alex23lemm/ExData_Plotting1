# Load libraries ---------------------------------------------------------------

library(lubridate)



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








