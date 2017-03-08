# JO 16/02/2017
# Script to test for homo or heteroscedasticty




#General code to reshape two vectors into a long data.frame
twoVarWideToLong <- function(sample1,sample2) {
  res <- data.frame(
    GroupID=as.factor(c(rep(1, length(sample1)), rep(2, length(sample2)))),
    DV=c(sample1, sample2)
  )   
}   

#Reshaping the example data
long.data <- twoVarWideToLong(sample1,sample2)


# Levene's test. bartlett and fligner
L_test_plot <- function(ID_data) {
  
  boxplot(DV ~ GroupID, data = long.data)
  
  print(leveneTest(DV~GroupID,long.data))
  print(bartlett.test(DV~GroupID,long.data))
  print(fligner.test(DV~GroupID,long.data))
  
}
