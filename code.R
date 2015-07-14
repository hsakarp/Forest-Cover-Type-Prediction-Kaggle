
library(randomForest)  
library(ggplot2)
library(gridExtra)
library(corrplot)
library(caret)
library(tree)

forest<- read.csv("train.csv")
head(forest)

forest$Id<- NULL
soil<- forest[ ,c(15:54)]
area<- forest[,c(11:14)]
forest<- forest[,c(-15:-54, -11:-14)]
Newfactor <- factor(apply(soil, 1, function(x) which(x == 1)), labels = c(1:38)) 
forest$Soil_Type<- as.integer(Newfactor)
Newfactor2 <- factor(apply(area, 1, function(x) which(x == 1)), labels = c(1:4)) 
forest$Wilderness_Area<- as.integer(Newfactor2)
forest<- forest[ ,c(1:10,12,13,11)]
head(forest)
forestTrain<-forest

boxplot(forest[,c(-7,-8,-9,-11,-12,-13)], las=3, par(mar = c(15, 4, 2, 2)), col="darkseagreen4",main="General")
theme_set(theme_gray(base_size = 20))
g1<- ggplot(forest, aes(Elevation, color = factor(Cover_Type), fill = factor(Cover_Type))) + geom_density(alpha = 0.2)
g2<- ggplot(forest, aes(Aspect, color = factor(Cover_Type), fill = factor(Cover_Type))) + geom_density(alpha = 0.2)
g3<- ggplot(forest, aes(Horizontal_Distance_To_Roadways, color = factor(Cover_Type), fill = factor(Cover_Type))) + geom_density(alpha = 0.2)
g4<- ggplot(forest, aes(Horizontal_Distance_To_Fire_Points, color = factor(Cover_Type), fill = factor(Cover_Type))) + geom_density(alpha = 0.2)
grid.arrange(g1, g2,g3,g4, ncol=2,nrow=2)

set.seed(1)
forest1<- forest[runif(dim(forest)[1]) > 0.8, ]  
forest1$Id <- NULL

#Remove columns with zero variance
sub = apply(forest1[,-56], 2, function(col) all(var(col) !=0 ))
forestSub<- forest1[,sub]
n<- dim(forestSub)
set.seed(1)
split <- runif(dim(forestSub)[1]) > 0.2  
train <- forestSub[split,]  
test <- forestSub[!split,]

#Tree prediction
train1<- train
test1<- test
names(train1)<- c("Elevation", "Aspect","Slope","H_D_To_Hydro","V_D_To_Hydro","H_D_To_Roads","Hillshade_9am" ,"Hillshade_Noon" ,"Hillshade_3pm","H_D_To_Fire_Points" ,"Soil_Type","Wilderness_Area","Cover_Type" )
names(test1)<- c("Elevation", "Aspect","Slope","H_D_To_Hydro","V_D_To_Hydro","H_D_To_Roads","Hillshade_9am" ,"Hillshade_Noon" ,"Hillshade_3pm","H_D_To_Fire_Points" ,"Soil_Type","Wilderness_Area","Cover_Type" )
tree.forests = tree(factor(Cover_Type) ~., data = train1)
 plot(tree.forests)
 text(tree.forests, cex=1.1)
 tree.prediction = predict(tree.forests, test1[,-13], type='class')
sa<- data.frame(cover=test[,13], pred=tree.prediction)

#Correlation matrix
cor<- forest[,c(-9,-8,-7,-13)]
names(cor)<- c("Elevation", "Aspect","Slope","H_D_To_Hydro","V_D_To_Hydro","H_D_To_Roads", "H_D_To_Fire_Points" ,"Soil_Type","Wilderness_Area" )
#Correlation between variables
m<- cor(cor)
corrplot(m, method = "number", tl.cex=1.2, mar = c(2, 2, 2, 2))

#Use randomForest for prediction
rf <- randomForest(factor(Cover_Type) ~ ., train, mtry=12, ntree=1000) 
predictions <- predict(rf, test)  
pred<- data.frame(Cover_Type=test$Cover_Type, Prediction=predictions)
rownames(pred)=NULL
head(pred, 15)

cm1<- confusionMatrix(predictions, test$Cover_Type)
cm1$table
cm1$overall['Accuracy']

#Next step. After training modelmove on to General case. Test set prediction
forestTest<- read.csv("test.csv")
#forest<- read.csv("train.csv")
forestTest$Id<- NULL
soil<- forestTest[ ,c(15:54)]
area<- forestTest[,c(11:14)]
forest<- forestTest[,c(-15:-54, -11:-14)]
Newfactor <- factor(apply(soil, 1, function(x) which(x == 1)), labels = c(1:40)) 
forestTest$Soil_Type<- as.integer(Newfactor)
Newfactor2 <- factor(apply(area, 1, function(x) which(x == 1)), labels = c(1:4)) 
forestTest$Wilderness_Area<- as.integer(Newfactor2)
forestTest<- forestTest[ ,c(1:10,56,55)]
head(forestTest)

#Remove columns witt zero variance
sub = apply(forestTest, 2, function(col) all(var(col) !=0 ))
TestSub<- forestTest[,sub]
n<- dim(TestSub)  

#Use our previous data set "forest" as training set.
forestTest$Id <- NULL
forestTrain$Id<- NULL
#forestTrain$Cover_Type<- as.factor(forestTarin$Cover_Type) 

#Use randomForest for prediction
rf1 <- randomForest(factor(Cover_Type) ~ ., mtry = 12,ntrees=1000, importance = TRUE,forestTrain)  
predictions <- predict(rf1, TestSub)  
```

## Save results
id<- read.csv("sampleSubmission.csv")
result<- data.frame(Id=id$Id, Cover_Type= predictions)
head(result,20)
#write.csv(result, "Submission7.csv", row.names=FALSE)

Importance<-rf
varImpPlot(Importance, col="darkblue", pch=19)






