#Importing applications data 

library(readxl)
State_Application_Process_Data_New <- read_excel("dataprojects/masscannabis/State Application Process Data New.xlsx", col_types = c("date", "numeric", "numeric", 
                                                                       "numeric", "numeric", "numeric", 
                                                                       "numeric", "numeric", "numeric", 
#Turning imported data into data frame                                                                       "numeric"))
appData <- as.data.frame(State_Application_Process_Data_New)

#Writing data as csv for others use
write.csv(appData, file = "appData.csv")

#Building stacked area graph for overall application status

#Reshaping dataset for input into stacked area 
install.packages('reshape')
library(reshape)
appReshape <- melt(appData, id=c("date"))

install.packages('ggplot2')
library(ggplot2)

#subsetting to app status categories

appStatus <- appReshape[which(appReshape$variable=='pendingApps' 
                              | appReshape$variable=='withdrawnApps' 
                              | appReshape$variable=='incompleteApps'), ]

status <- ggplot(appStatus, aes(x=date, y=value, fill=variable)) + 
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette = "Blues")

status + labs(x = "Date of Data",
              y = "# of Applications",
              title = "Cannabis Applications by App Status",
              caption = "Data is sourced from Massachusetts Cannabis
              Commission.  Pending applications represent an application where
              at least 1 part of the application is complete.")


