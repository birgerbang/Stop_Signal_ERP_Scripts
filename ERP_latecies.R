library(tidyverse)
library(hrbrthemes)
library(viridis)
library(ggplot2)
library(lme4)
library(sjPlot)
library(ggbeeswarm)

ERPl <- read.csv('LatencyN3P3table.txt')

cor(ERPl$N2.peak, ERPl$N2.half.area)
cor(ERPl$P3.peak, ERPl$P3.half.area)


model1 <- lm(N2.half.area ~ condition, data=ERPl)
model2 <- lm(N2.half.area ~ group, data = ERPl)
model3 <- lm(N2.half.area ~ condition*group, data = ERPl)

model4 <- lm(N2.half.area ~ condition*group + factor(participant), data = ERPl)

#model4 <- lmer(N2.half.area ~ condition*group + (factor(participant)|condition), data=ERPl)


tab_model(model1, model2, model3, p.style = "stars", show.aic = FALSE, show.ci=FALSE, show.r2 = TRUE, show.se=FALSE)

model1.1 <- lm(N2.peak ~ condition, data=ERPl)
model2.1 <- lm(N2.peak ~ group, data = ERPl)
model3.1 <- lm(N2.peak ~ condition*group, data = ERPl)

tab_model(model1.1, model2.1, model3.1 ,p.style = "stars", show.aic = FALSE, show.ci=FALSE, show.r2 = TRUE, show.se=FALSE)

manova <- anova(model3)
summary(manova)
