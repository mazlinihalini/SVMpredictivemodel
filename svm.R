library(ROSE)
library(e1071)
library(dplyr)
library(caret)
library(reshape2)
library(MASS)

#Load data
dt = read.csv("Shiny Readmission.csv")
dt[1] = NULL

# Convert to Factor
dt$age = as.factor(dt$age)
dt$admission_type_id = as.factor(dt$admission_type_id)
dt$discharge_disposition_id = as.factor(dt$discharge_disposition_id)
dt$admission_source_id = as.factor(dt$admission_source_id)
dt$medical_specialty = as.factor(dt$medical_specialty)
dt$max_glu_serum = as.factor(dt$max_glu_serum)
dt$A1Cresult = as.factor(dt$A1Cresult)


df = read.csv("Filtered Diabetic Readmission.csv")
df[1] = NULL

#Encoding the categorical target variables as factors
df$readmitted = as.factor(df$readmitted)

#Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(df$readmitted, SplitRatio = 0.80) 
df_train = subset(df, split == TRUE)
df_test = subset(df, split == FALSE)

#Feature Scaling
df_train[-19] = scale(df_train[-19])
df_test[-19] = scale(df_test[-19])


# balanced data set with under sampling
df_train <- ovun.sample(readmitted~., data=df,
                  method="under",
                  p = 0.5, 
                  seed=1)$data

# Building SVM classifier
svm_classifier = svm(formula = readmitted ~ ., 
                     data = df_train, 
                     type = 'C-classification', 
                     kernel = 'linear') 



