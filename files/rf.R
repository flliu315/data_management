# Read Data
data <- read.csv("RF-data.csv", header = TRUE)
str(data)
data$colony.loss <- as.factor(data$colony.loss) #将目标变量转换为因子型
table(data$colony.loss)

# Data Partition
set.seed(123)#设置随机种子
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))#数据集随机抽70%定义为训练数据集，30%为测试数据
train <- data[ind==1,]
test <- data[ind==2,]

# Random Forest
library(randomForest)
set.seed(222)
rf <- randomForest(colony.loss~., data=train, ntree = 500, mtry = 2, importance = TRUE, proximity = TRUE)#importance 和 proximity 是计算每个变量的重要性和样本之间的距离
print(rf)

# Prediction & Confusion Matrix - train data
library(caret)
p1 <- predict(rf, train)
confusionMatrix(p1, train$colony.loss)

# Prediction & Confusion Matrix - test data
p2 <- predict(rf, test)
confusionMatrix(p2, test$colony.loss)

# Error rate of Random Forest
plot(rf)

# Tune mtry
t <- tuneRF(train[,-12], train[,12],
       stepFactor = 0.5,
       plot = TRUE,
       ntreeTry = 500,
       trace = TRUE,
       improve = 0.05)

# Variable Importance
varImpPlot(rf, sort = T, n.var = 10, main = "Top 10 - Variable Importance")
importance(rf)

# Partial Dependence Plot
partialPlot(rf, train, GA, "serious")

