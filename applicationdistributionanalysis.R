#Importing applications data 

library(readxl)
State_Application_Process_Data_New <- read_excel("State Application Process Data New.xlsx", col_types = c("date", "numeric", "numeric", 
                                                                       "numeric", "numeric", "numeric", 
                                                                       "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
appData <- as.data.frame(State_Application_Process_Data_New)

#Writing data as csv for others use
write.csv(appData, file = "appData.csv")

#Importing applications under review data

library(readxl)
appReview <- read_excel("State Application Process Data New.xlsx", sheet="underReview", col_types = c("date", "numeric", "numeric",                                                                                                     "numeric", "numeric", "numeric", 
                                                                                                      "numeric", "numeric", "numeric", "numeric"))
appReview <- as.data.frame(appReview)

##################################################################
### Building stacked area graph for overall application status ###
##################################################################

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

#Creating stacked area plot

status <- ggplot(appStatus, aes(x=date, y=value, fill=variable)) + 
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette = "Blues", labels=c("Pending", "Withdrawn", "Incomplete"))

status + labs(x = "Date of Data",
              y = "# of Applications",
              title = "Cannabis Applications by App Status",
              caption = "Data is sourced from Massachusetts Cannabis
              Commission.  Pending applications represent an application where
              at least 1 part of the application is complete.") +
  guides(fill=guide_legend(title=NULL))


###################################################################
### Building stacked area graph for type of license application ###
###################################################################

#subsetting to app type category

appCategory <- appReshape[which(appReshape$variable == 'craftCooperative' 
                              | appReshape$variable == 'cultivator' 
                              | appReshape$variable == 'establishmentAgent'
                              | appReshape$variable == 'microbusiness'
                              | appReshape$variable == 'productManufacturer'
| appReshape$variable == 'researchFacility'
| appReshape$variable == 'retailer'
| appReshape$variable == 'transporter'),]



#Creating stacked area plot

library(ggplot2)

Category <- ggplot(appCategory, aes(x=date, y=value, fill=variable)) + 
  geom_area(colour="black", size=.2, alpha=.4)


Category + labs(x = "Date of Data",
              y = "# of Applications",
              title = "Cannabis Applications by License Type",
              caption = "Data is sourced from Massachusetts Cannabis
              Commission.  The numbers in this chart represent distinct license numbers 
that have submitted at least one of the packets
related to getting a license (App of Intent, Background, Management/Ops, Payment)") +
  guides(fill=guide_legend(title=NULL)) +
  scale_fill_discrete(labels=c('Craft Cooperative', 'Cultivator', 'Establishment Agent',
                               'Microbusiness', 'Product Manufacturer', 'Research Facility',
                               'Retailer', 'Transporter'))

##################################################################
### Building stacked area graph for applications under review ###
##################################################################

#Reshaping dataset for input into stacked area 

library(reshape)
appReviewshaped <- melt(appReview, id=c("date"))

library(ggplot2)

appRevCategory <- appReviewshaped[which(appReviewshaped$variable == 'craftCooperative' 
                                | appReviewshaped$variable == 'cultivator' 
                                | appReviewshaped$variable == 'establishmentAgent'
                                | appReviewshaped$variable == 'microbusiness'
                                | appReviewshaped$variable == 'productManufacturer'
                                | appReviewshaped$variable == 'researchFacility'
                                | appReviewshaped$variable == 'retailer'
                                | appReviewshaped$variable == 'transporter'),]


#Creating stacked bar chart

