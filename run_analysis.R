run_analysis <- function(){
        library(reshape2)
        
        measurements <- read.table("./UCI HAR Dataset/features.txt")
        wantedMeasurements <- grep("mean|std", measurements[,2])
        
        ##read train files###
        actionTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
        dataTrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
        dataTrain <- dataTrain[,wantedMeasurements]
        subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        train <- cbind(actionTrain, subjectTrain, dataTrain)
        
        ##read test files####
        actionTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
        dataTest <- read.table("./UCI HAR Dataset/test/x_test.txt")
        dataTest <- dataTest[,wantedMeasurements]
        subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        test <- cbind(actionTest, subjectTest, dataTest)
        
        mergedData <- rbind(train,test)
        
        actionNames <- read.table("./UCI HAR Dataset/activity_labels.txt")
        actions <- actionNames[mergedData[,1],2]
        mergedData[,1] <- actions
        
        varNames <- c("activity", "subject", measurements[wantedMeasurements,2])
        names(mergedData) <- varNames
        
        meltedData <- melt(mergedData, id = c("activity", "subject"))
        castedData <- dcast(meltedData, activity+subject~variable, mean)
        
}