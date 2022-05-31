#install.packages("hrbrthemes")
#install.packages("viridis")
# Libraries
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(ggplot2)


easy_successful <- c(1:4213)*0+1 #successful stops are coded 1
easy_unsuccesssful <- c(1:2215)*0 #unsuccesful stops are coded 0
hard_successful <- c(1:2780)*0+1
hard_unsuccessful <- c(1:3593)*0


easy <- c(easy_successful, easy_unsuccesssful)
hard <- c(hard_successful, hard_unsuccessful)

data <- data.frame(easy, hard)

data <- data.frame(
  category=c( rep("Easier\ntrials",length(easy)), rep("Difficult\ntrials",length(hard)) ),
  value=c(easy, hard)
)

t.test(easy, hard) #calculate if groups are different


data %>%
  ggplot( aes(x=category, y=value, fill=category)) +
  scale_y_continuous(breaks=c(0,1), labels=c("Unsuccessful\nStop", "Successful\nStop ")) +
  stat_summary(fun=mean, geom="point", shape=20, size=10) +
  geom_violin() +
  #scale_fill_viridis(discrete = TRUE, alpha=0.9, option="A") +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=15)
  ) +
  ggtitle("Welch Two Sample t-test: p-value < 2.2e-16") +
  coord_flip() +
  xlab("")+
  ylab("")
  
