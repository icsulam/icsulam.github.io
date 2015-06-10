library(gdata)
library(ggplot2)
library(car)
library(stargazer)
library(spatstat)
library(RColorBrewer)
#library(rgdal)
library(maptools)
library(mapproj)
library(grid)
library(vcd)
library(tm)
library(RJSONIO)
library(MASS)
library(qdap)

# feature selection
library(mlbench)
library(caret)

#ROC curve
#library(pROC)
library(Deducer)

options(scipen=100000000)
#
# basic descriptives:
#  have 2103 spending files
#
rm(list=ls())

insightDir  = '/home/marvin/Desktop/Insight/'
baseDir     = file.path(insightDir, 'WritingPrompts')
baseCSV     = file.path(baseDir, 'PromptCSV')
commentCSV  = file.path(baseDir, 'ResponseCSV')
listCSV     = list.files(baseCSV)

promptLevel    <- read.csv(file.path(baseDir, 'allPrompt_edited.csv'))
commentLevel   <- read.csv(file.path(baseDir, 'commentFile_reduce5.csv'))
combinedLevels <- read.csv(file.path(baseDir, 'combinedLevels.csv'))
#combinedLevels <- combinedLevels[,-c(1:2)]


dataMatrix <- subset(combinedLevels, select=c(score,
                                           sentence_count, word_count, syllable_count,
                                           topLevel, commentLength, fleschKincaid,
                                           firstLength, paragraph_count, 
                                           questionMark, exclaimMark, i_statement, you_statement,
                                           perQ, perE, perI, perU, 
                                           perStartAnd, p_editRec, p_editTime, p_isAmod,
                                           p_num_comments, timeToCreate, blockOfText))

#############################
# feature selection
#  LVQ
#
control <- trainControl(method="repeatedcv", number=10, repeats=3)
model   <- train(score~., data=dataMatrix, method="lvq", preProcess="scale", trControl=control)

#
# standard regressions
#
modScore1<- glm(score      ~ firstLength+commentLength+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + promptScore, data=c2)
modScore2<- glm(score      ~ firstLength+commentLength+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + promptScore, data=c2)
modScore3<- glm(score      ~ firstLength+commentLength+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared+created_utc +
                  perE + perQ + perI + perStartAnd + promptScore, 
                data=c2author10)
modScore <- glm(score      ~ firstLength+commentLength+paragraph_count+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + promptScore, 
                data=c2)
modShare <- glm(scoreShare ~ firstLength+commentLength+paragraph_count+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + promptScore, 
                data=c2)
modRestrict1<- glm(score      ~ firstLength+commentLength+fleschKincaid+topLevel+timeToCreate+timeSquared +
                     perE + perQ + perI + promptScore , data=c2)
stargazer(modScore1, modScore2, modScore3, modScore, modShare, type="text")
lm.beta(modScore2)
stargazer(modRestrict1, type="text")



mod80a20 <- glm(highScore  ~ firstLength+word_count+paragraph_count+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + p_score + order, 
                family = binomial(link = "probit"), data=combinedLevels)
mod80top <- glm(highScore  ~ firstLength+word_count+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + order + p_num_comments, 
                family = binomial(link = "probit"), data=combinedLevels)
mod80topb<- glm(highScore2 ~ firstLength+word_count+paragraph_count+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + p_score + order, 
                family = binomial(link = "probit"), data=combinedLevels)
mod80topc<- glm(highScore2 ~ firstLength+word_count+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + p_score + order, 
                family = binomial(link = "probit"), data=combinedLevels)
mod80topd<- glm(highScore2 ~ firstLength+word_count+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + created_utc + p_score + order, 
                family = binomial(link = "probit"), data=combinedLevels)

stargazer(mod80a20, mod80top, mod80topb, mod80topc, mod80topd, type="text")
pR2(mod80a20)
pR2(mod80top)
pR2(mod80topb)
pR2(mod80topc)
pR2(mod80topd)

restrictedSet <- combinedLevels[-as.numeric(mod80top$na.action),]
mod80top2 <- glm(highScore  ~ firstLength+word_count+bigBlockText+fleschKincaid+topLevel+timeToCreate+timeSquared +
                  perE + perQ + perI + perStartAnd + p_score + order, 
                family = binomial(link = "probit"), data=restrictedSet)
prob=predict(mod80top,type=c("response"))

rocplot(mod80top)


#chosen model
theChosenModel <- glm(highScore  ~ bigBlockText + perE + perI + 
                        timeToCreate + firstLength + topLevel + order + 
                        word_count + p_num_comments + fleschKincaid + perQ + perStartAnd, 
                                   family = binomial(link = "probit"), data=combinedLevels)
#http://www.carlislerainey.com/2012/06/30/coefficient-plots-in-r/
coefplot(theChosenModel, intercept=FALSE,
         newNames = c(order          = 'Number of Previous Stores',
                      p_num_comments = 'Karma Train',
                      perStartAnd    = '"And..." vs "... and ..."',
                      perI           = 'First Person Voice',
                      perQ           = 'Question Sentences',
                      perE           = 'Exclaimation Points',
                      fleschKincaid  = 'Grade Level',
                      word_count     = 'Word Count',
                      top_level      = 'First Commenter',
                      firstLength    = 'First Sentence Length',
                      timetoCreate   = 'Time To Create (hours)',
                      bigBlockText   = 'Big Block of Text'
                    ))
coefplot(mod80topc, intercept=FALSE)

ggplot(combinedLevels, aes(x=score))+
  geom_density(kernel="rectangular",adjust=5)+
  scale_x_continuous(limits=c(-10,50))+
  ggtitle("Story Scores follow a Power Law")+
  theme_bw()+
  geom_vline(xintercept=5, color="green")+
  theme(
    strip.text.x = element_text(size = 16),
    legend.title = element_text(size = 18),
    legend.text  = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16, angle=90),
    plot.title   = element_text(size = 20))


#
#  AHHHHHHHHHHHHHHHHH
#
promptLevel$p_datestr <- as.POSIXct(promptLevel$p_created_utc, origin='1970-01-01')
promptLevel$p_hour  <- as.numeric(as.character(substr(promptLevel$p_datestr, 12, 13)))

promptLevel$WorkSafety  <- recode(promptLevel$p_nsfw_flag, "0='Safe'; 1='NSFW'")
ggplot(promptLevel, aes(x=WorkSafety, weight=p_num_comments))+
  geom_bar(aes(fill=WorkSafety))+
  facet_grid(~p_hour)+
  scale_y_continuous(name="Comment Volume")+
  ggtitle("Work-Safety Doesn't Matter")+
  theme_bw()+
  theme(
    strip.text.x = element_text(size = 16),
    legend.title = element_text(size = 18),
    legend.text  = element_text(size = 16),
    legend.position="bottom",
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16, angle=90),
    plot.title   = element_text(size = 20),
    axis.ticks = element_blank(), axis.text.x = element_blank())



#standardized
#lm.beta(modScore2)
ggplot(c2onlyTop, aes(x=score))+geom_bar(binwidth=1)+scale_x_continuous(limits=c(-20,50))

#
# nonparametric regression
#
tempNoNA <- subset(c2onlyTop, is.na(c2onlyTop$word_count)==FALSE)
mod.all     <- loess(highScore2 ~ word_count, span=.7, degree=1, data=tempNoNA)
mod.quest   <- loess(highScore2 ~ word_count+perQ, span=.7, degree=1, data=tempNoNA)
mod.quest2  <- loess(highScore2 ~ word_count+perQ, span=.7, degree=2, data=tempNoNA)

anova(mod.quest, mod.quest2)

wordC  <- seq(from=min(c2onlyTop$word_count, na.rm=TRUE), to=max(c2onlyTop$word_count, na.rm=TRUE), length.out=25)
quest2 <- seq(from=min(c2onlyTop$perQ, na.rm=TRUE), to=max(c2onlyTop$perQ, na.rm=TRUE), length.out=25)
newData <- expand.grid(word_count=wordC, perQ = quest2)
fit.c2onlytop <- matrix(predict(mod.quest, newData), 25, 25)
persp(wordC, quest2, fit.c2onlytop, theta=-45, phi=30, ticktype="detailed", shade=0.5)

plot(highScore ~ word_count, data=tempNoNA)
with(tempNoNA, lines(lowess(word_count, highScore, f=0.5, iter=0), lwd=2))

tapply(tempNoNA$word_count, tempNoNA$highScore, mean)
t.test(word_count~highScore, data=tempNoNA)