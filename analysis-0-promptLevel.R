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


# have i imported prompts? if yes, skip iterator
if(is.na(file.info(file.path(baseDir, 'allPrompt.csv'))$size)) {
  prompt1     = read.csv(file.path(baseCSV, listCSV[1]))
  for(i in 2:length(listCSV)){
    thisPrompt <- read.csv(file.path(baseCSV, listCSV[i]))
    prompt1    <- rbind(prompt1, thisPrompt)
    rm(thisPrompt)
  }
  colnames(prompt1)[46] <- 'nsfw_flag'
  write.csv(prompt1, file.path(baseDir, 'allPrompt.csv'))
  
} else {
  prompt1 <- read.csv(file.path(baseDir, 'allPrompt.csv'))
}

prompt1 <- read.csv(file.path(baseDir, 'allPrompt.csv'))
prompt1$genre <- gsub('^ ', '', prompt1$link_flair_text, perl=TRUE)
prompt1$genre <- gsub(' $', '', prompt1$genre, perl=TRUE)
prompt1$genre <- recode(prompt1$genre, "'Established Universe?'='Established Universe';
                        'Constrained Writing/Media Prompt'='Constrained Writing';
                        'NSFW?'='NSFW'; 'Writing prompt'='Writing Prompt';
                        'Writing Prompt - DID NOT ACTUALLY HAPPEN'='Writing Prompt';
                        'Writing Prompt - Not Actual News'='Writing Prompt';
                        'Writing Prompt NOT /R/ASKREDDIT'='Writing Prompt';
                        'Writing Prompt SHUT UP ABOUT THE WIRE'='Writing Prompt';
                        'Writing Prompt [WP]'='Writing Prompt';
                        'Flash Fiction CONTEST!'='Flash Fiction';
                        'ALL THE PROMPTS'='Writing Prompt';
                        'Poetry Prompt'='Poetry'")
levels(as.factor(prompt1$genre))
prompt1$editRec  <- as.numeric(as.character(recode(prompt1$edited, "' false'=0; else = 1")))
prompt1$editNum  <- gsub('^ ', '', prompt1$edited, perl=TRUE)
prompt1$editNum  <- as.numeric(as.character(recode(prompt1$editNum, "'false'=0")))
prompt1$created  <- prompt1$created_utc * prompt1$editRec
prompt1$editTime <- prompt1$editNum - prompt1$created
prompt1$editTime <- recode(prompt1$editTime, "50000:hi=50000")
prompt1$isAmod   <- recode(prompt1$author_flair_css_class, "' MOD'=1; else=0")

#drop variables i don't need
prompt1 <- subset(prompt1, select = -c(X, domain, banned_by, media_embed, subreddit, selftext_html, likes, suggested_sort,
                             user_reports, secure_media, link_flair_text, clicked, report_reasons, media, approved_by,
                             hidden, thumbnail, subreddit_id, editNum, link_flair_css_class, author_flair_css_class,
                             downs, mod_reports, secure_media_embed, saved, removal_reason, stickied, created,
                             permalink, visited, num_reports, nsfw))


########################################
#
# recodes go here
#

#time descriptives
prompt1$datestr <- as.POSIXct(prompt1$created_utc, origin='1970-01-01')
prompt1$year    <- substr(prompt1$datestr, 0, 4)
prompt1$month   <- substr(prompt1$datestr, 6, 7)
prompt1$day     <- substr(prompt1$datestr, 9, 10)
prompt1$wDay    <- as.POSIXlt(prompt1$created_utc, origin='1970-01-01')$wday

#prompt descriptives
prompt1$num_comments <- recode(prompt1$num_comments, "-1=0")
prompt1$promptLength <- nchar(as.character(prompt1$title))
prompt1$allLength    <- nchar(as.character(prompt1$selftext)) + prompt1$promptLength

#
# rename some prompt-level variables
#
colnames(prompt1) <- paste('p_', colnames(prompt1), sep="")
write.csv(prompt1, file.path(baseDir, 'allPrompt_edited.csv'))
#promptNormal <- subset(prompt1, prompt1$num_comments < 100)
#commentTest <- read.csv(file.path(commentCSV, list.files(commentCSV)[1]))
