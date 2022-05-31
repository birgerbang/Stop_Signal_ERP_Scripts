library(tidyverse)
library(hrbrthemes)
library(viridis)
library(ggplot2)
library(lme4)
library(sjPlot)

library(ggbeeswarm)
data3 <- read.csv("SSDtable.txt")

summary(lm(data3$success ~ data3$SSD))

data3 %>%
  ggplot( aes(x=factor(success), y=SSD, fill=factor(success))) +
  scale_x_discrete(breaks=c(0,1), labels=c("Unsuccessful\nStop", "Successful\nStop ")) +
  geom_violin(draw_quantiles = c(0.05, 0.95)) +
  stat_summary(fun=mean, geom="point", shape=20, size=10) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=15)
  ) +
  ggtitle("SSD on successful vs unsuccessful stop trials") +
  coord_flip() +
  xlab("")+
  ylab("mean(SSD_unsuccessful) = 0.299,  mean(SSD_successful) = 0.334")

aes(x = reorder(Species, Sepal.Width, FUN = median)

data3 %>%
  ggplot( aes(x= reorder(factor(ID), SSD, FUL = median), y=SSD, fill=factor(ID))) +
  #scale_x_discrete(breaks=c(0,1), labels=c("Unsuccessful\nStop", "Successful\nStop ")) +
  geom_violin(draw_quantiles = c(0.05, 0.95)) +
  stat_summary(fun=mean, geom="point", shape=20, size=5) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=15)
  ) +
  ggtitle("Mean SSD accross participants") +
  coord_flip() +
  xlab("")+
  ylab("")

i = c(1:length(data3$ID))
data3$ID[i] <- toString(data3$ID[i])

gmod <- lm(success ~ ID, data = data3)
summary(gmod)

fm1 <- lm(success ~ easy, data = data3)
summary(fm1)

fm2 <- lm(success ~ SSD, data = data3)
summary(fm2)

fm3 <- lm(success ~ ID, data = data3)
summary(fm3)

fm4 <- lm(success ~ nGoBefore, data = data3)
summary(fm4)

fm5 <- lm(scale(success) ~ scale(easy) + scale(SSD) + scale(ID) + scale(nGoBefore), data = data3)
summary(fm5)

fm6 <- lm(success ~ nGoBefore, data = data3)
summary(fm6)

tab_model(fm1, fm2, fm3 ,p.style = "stars", show.aic = TRUE, show.ci=TRUE, show.r2 = TRUE, show.se=FALSE)

lm(success, )
