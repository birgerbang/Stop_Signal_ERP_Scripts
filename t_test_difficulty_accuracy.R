library(tidyverse)
library(hrbrthemes)
library(viridis)
library(ggplot2)

library(ggbeeswarm)
easier_accuracies = read.csv("easier_accuracies.txt")
harder_accuracies = read.csv("harder_accuracies.txt")

easy_accuracies <- easier_accuracies[["X0.72158"]]
hard_accuracies <- harder_accuracies[["X0.52841"]]

#data <- data.frame(easy_accuracies, hard_accuracies)

t.test(easy_accuracies, hard_accuracies)



data <- data.frame(
  category=c( rep("Easier\ntrials",length(easy_accuracies)), rep("Difficult\ntrials",length(hard_accuracies)) ),
  value=c(easy_accuracies, hard_accuracies)
)

data %>%
  ggplot( aes(x=category, y=value, fill=category)) +
  #scale_y_continuous(breaks=c(0,1), labels=c("Unsuccessful\nStop", "Successful\nStop ")) +
  geom_violin(draw_quantiles = c(0.05, 0.95)) +
  #geom_boxplot() +
  geom_quasirandom() +
  theme(legend.position = "none")  +
  #scale_fill_viridis(discrete = TRUE, alpha=0.9, option="A") +
  stat_summary(fun=mean, geom="Point", shape=20, size=10) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=15)
  ) +
  ggtitle("Participants accuracies on difficult vs easier stop trials") +
  #coord_flip() +
  xlab("Welch Two Sample t-test: p-value = 1.877e-15")+
  ylab("Accuracy")

SSD_easier <- read.csv2("SSD_easier.txt")
SSD_harder <- read.csv2("SSD_harder.txt")

SSD_hard <- as.numeric(SSD_harder[["X0.348"]])
SSD_easy <- as.numeric(SSD_easier[["X0.348"]])

SSD_hard <- SSD_hard * 1000
SSD_easy <- SSD_easy * 1000

t.test(SSD_easy, SSD_hard)

data2 <- data.frame(
  type=c( rep("Easier\ntrials",length(SSD_easy)), rep("Difficult\ntrials",length(SSD_hard)) ),
  value=c(SSD_easy, SSD_hard)
)
data2 %>%
  ggplot( aes(x=type, y=value, fill=type)) +
  #geom_histogram( alpha=0.8, position = 'identity', binwidth = 0.05)
  geom_violin()+
  stat_summary(fun=mean, geom="Point", shape=20, size=10) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=15)
  )+
  coord_flip()+
  ggtitle("SSD of difficult vs easier trials")+
  xlab("")+
  ylab("mean(SSD_easier) = 281 ms,  mean(SSD_difficult) = 349 ms")
  
