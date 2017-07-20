# JO 16/02/2017
# Script to test for homo or heteroscedasticty
library(car)

hskedac_tests <- function(sample1,sample2){
  
    
  #Reshaping the example data
  long.data <- twoVarWideToLong(sample1,sample2)
   
  L_test_plot(long.data)
  
  
}


#General code to reshape two vectors into a long data.frame
twoVarWideToLong <- function(sample1,sample2) {
  res <- data.frame(
    GroupID=as.factor(c(rep(1, length(sample1)), rep(2, length(sample2)))),
    DV=c(sample1, sample2)
  )
  
  return(res)
  
}   


# Levene's test. bartlett and fligner
L_test_plot <- function(long.data) {
  
  # Make boxplots for inspection
  pdf('Boxplot.pdf')
  
  boxplot(DV ~ GroupID, data = long.data)
  
  dev.off()
  
  # Make qq plots
  pdf('sample1_qqplot.pdf')
  
  qqnorm(sample1);qqline(sample1)
  
  dev.off()
  
  pdf('sample2_qqplot.pdf')
  
  qqnorm(sample2);qqline(sample2)
  
  dev.off()
  
  # Run tests to an outfile
  sink('HomoskeadictyTest.txt')
  
  print('Test for normality:')
  print(shapiro.test(sample1))
  print(shapiro.test(sample2))
  
  print('---------------------------')
  print('Test for homoskedasticity:')
  print(leveneTest(DV~GroupID,long.data))
  print(bartlett.test(DV~GroupID,long.data))
  print(fligner.test(DV~GroupID,long.data))
  
  
  sink()
  
}

# test functions for generating dummy data
gen_homo <- function(){
  
  sample1 <- rnorm(100, mean = 50, sd = 5)
  
  return(sample1)
  
  }


gen_hetero <- function(){
  
  sample1 <- rnorm(100, mean = 50, sd = 1:20)
  
  return(sample1)
 
  }