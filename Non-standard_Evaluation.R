### NSE tutorial
### 2018-06-28

# Example of SE
f <- function(x){x}
f(2)

x<-3
f(x)

library(dplyr)
library(ggplot2)

x <- seq(0, 2*pi, length=100)
sinx<-sin(x)
plot(x, sinx,type="1")

library(tidyverse)

df <- tibble(x=1:3,y=3:1)
# Select all rows where x=1
filter(df, x==1)

# this is not equivalent
my_var <- x
filter(df, my_var == 1)

# this is not equivalent
my_var <- "x"
filter(df, my_var == 1)

# Read programming with dplyr

toy.df <- tibble(
  g1 = c(1,1,2,2,2),
  g2 = c(1,2,1,2,1),
  a = sample(5),
  b = sample(5)
)

toy.df

# If we want to group bt the group variable g1, then calculate the mean of a
# iris %>% head() %>% summary() is equivalent to summary(head(iris))
toy.df %>%
  group_by(g1) %>%
  summarise(a=mean(a))

# Write a function. In this case it fails because it is looking for, but can't find group_var
my_summarise <- function(df, group_var){
  df %>%
    group_by(group_var) %>%
    summarise(a=mean(a))
}

my_summarise(toy.df, g1)


# our escape hatch is that we are going to quote it ourselves

# attempt 2
my_summarise2 <- function(df, group_var){
    # capture the symbol and its environment
    group_var <- enquo(group_var)
  
  df %>%
    # !! tells it that we have already quoted it above
    group_by(!!group_var) %>%
    summarise(a=mean(a))
}

my_summarise2(toy.df, g1)


# Challenge quesiton

# Write another summarize function that calculated the mean sum and tally of the number of observations

summarise(toy.df, 
              mean = mean(a),
              sum = sum(a),
              n = n() # Don't have to specify a here since it is a df
              )

my_summarise3 <- function(df, my_var){
  my_var <- enquo(my_var)
  
  summarise(df, 
            mean = mean(!!my_var),
            sum = sum(!!my_var),
            n = n() # Don't have to specify a here since it is a df
  )
}

my_summarise3(toy.df, a*b)
