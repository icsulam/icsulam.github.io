library(pscl) #for glm validation
library(coefplot)
library(QuantPsyc) #for standardized coefficients
library(np)

thisFile <- subset(prompt1, prompt1$p_year == 2014)
thisFile <- subset(prompt1, prompt1$p_year == 2014)
thisFile <- subset(thisFile, thisFile$p_month == '07')
thisFile$p_cleanID <- gsub(' ', '',as.character(thisFile$p_id))
thisFile$p_exists  <- file.info(file.path(commentCSV, paste(thisFile$p_cleanID, '.txt', sep="")))$size
thisFile$file      <- paste(thisFile$p_cleanID, '.txt', sep="")

#############################
#create comment sample
#############################
if(is.na(file.info(file.path(baseDir, 'commentFile_reduce.csv'))$size)) {
  tempPath    <- file.path(commentCSV, paste(thisFile$cleanID[i], '.txt', sep=""))
  commentFile <- read.csv(tempPath)
  for(i in 2:dim(thisFile)[1]) {
    if(!is.na(thisFile$exists[i])){
      #print(thisFile$cleanID[i])
      tempPath <- file.path(commentCSV, paste(thisFile$cleanID[i], '.txt', sep=""))
      tempFile <- read.csv(tempPath)
      commentFile <- rbind(tempFile, commentFile)
      print(i)
    }>
  }
  write.csv(commentFile, file.path(baseDir, 'commentFile_reduce.csv'))
} else {
  commentFile <- read.csv(file.path(baseDir, 'commentFile_reduce.csv'))
}

# clean up the stories by stripping out unformatted junk
commentFile$body          <- as.character(commentFile$body)
commentFile$body          <- gsub('\\u201c', '', commentFile$body)
commentFile$body          <- gsub('\\u201d', '', commentFile$body)
commentFile$body          <- gsub('\\u2019d', '', commentFile$body)
commentFile$body          <- gsub('\\u2019t', '', commentFile$body)
commentFile$body          <- gsub('\\u2019s', '', commentFile$body)
commentFile$body          <- gsub('\\[', '', commentFile$body)
commentFile$body          <- gsub('\\]', '', commentFile$body)

#calculate language measures i want
#  -- sentence_count
#  -- word_count
#  -- syllable_count
#  -- commentLenght
#  -- fleschKincaid
#  -- top-level data
#  -- extract top sentence
#  -- paragraph_count
commentFile$sentence_count<- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$sentence_count[i] <- length(gregexpr('(\\.|\\!|\\?)', as.character(commentFile$body[i]), perl=TRUE)[[1]])
}
#question mark
commentFile$questionMark <- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$questionMark[i] <- length(gregexpr('\\?', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  if(-1 %in% gregexpr('\\?', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  {
    commentFile$questionMark[i] <- 0
  }
}
#exclaimation mark
commentFile$exclaimMark  <- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$exclaimMark[i] <- length(gregexpr('\\!', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  if(-1 %in% gregexpr('\\!', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  {
    commentFile$exclaimMark[i] <- 0
  }
}
#I-statements
commentFile$i_statement  <- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$i_statement[i] <- length(gregexpr(' I ', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  if(-1 %in% gregexpr(' I ', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  {
    commentFile$i_statement[i] <- 0
  }
}

#you-statements
commentFile$you_statement  <- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$you_statement[i] <- length(gregexpr(' you ', tolower(as.character(commentFile$body[i])), perl=TRUE)[[1]])
  if(-1 %in% gregexpr(' you ', tolower(as.character(commentFile$body[i])), perl=TRUE)[[1]])
  {
    commentFile$you_statement[i] <- 0
  }
}
commentFile$perU <- commentFile$you_statement  / commentFile$sentence_count

commentFile$perQ <- commentFile$questionMark / commentFile$sentence_count
commentFile$perE <- commentFile$exclaimMark  / commentFile$sentence_count
commentFile$perI <- commentFile$i_statement  / commentFile$sentence_count
commentFile$perU <- commentFile$you_statement  / commentFile$sentence_count


#andcount
commentFile$startAnd_count<- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$startAnd_count[i] <- length(gregexpr(' And ', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  if(-1 %in% gregexpr(' And ', as.character(commentFile$body[i]), perl=TRUE)[[1]])
  {
    commentFile$startAnd_count[i] <- 0
  }
}
commentFile$allAnd_count<- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$allAnd_count[i] <- length(gregexpr(' and ', tolower(as.character(commentFile$body[i])), perl=TRUE)[[1]])
  if(-1 %in% gregexpr(' and ', tolower(as.character(commentFile$body[i])), perl=TRUE)[[1]])
  {
    commentFile$allAnd_count[i] <- 0
  }
}
commentFile$allAnd_count_rec <- recode(commentFile$allAnd_count, "0=1")
commentFile$perStartAnd   <- commentFile$startAnd_count / commentFile$allAnd_count

commentFile$word_count    <- word_count(commentFile$body)
commentFile$syllable_count<- syllable_sum(commentFile$body)

commentFile$topLevel      <- recode(substr(commentFile$parent_id,0,2), "'t1'=0; 't3'=1; else=NA")
commentFile$commentLength <- nchar(as.character(commentFile$body))

#write.csv(commentFile, file.path(baseDir, 'commentFile_reduce2.csv'))
commentFile$fleschKincaid <-  0.39 * (commentFile$word_count / commentFile$sentence_count) + 
                             11.80 * (commentFile$syllable_count / commentFile$word_count) -
                             15.59
commentFile$firstSentence <- ''
for(i in 1:dim(commentFile)[1]){
  commentFile$firstSentence[i] <- substr(commentFile$body[i],
                                         0, 
                                         recode(gregexpr('(\\.|\\!|\\?)',commentFile$body[i], perl=TRUE)[[1]][1], "-1=10000"))
}
commentFile$firstLength <- nchar(as.character(commentFile$firstSentence))

commentFile$paragraph_count <- 0
for(i in 1:dim(commentFile)[1]){
  commentFile$paragraph_count[i] <- length(gregexpr('\\\\n',commentFile$body[i], perl=TRUE)[[1]])
}
tolower(commentFile$body)

###########################
# add prompt-level data
###########################
thisFile    <- thisFile[order(thisFile$file), ]
thisFile    <- thisFile[!duplicated(paste(thisFile$p_cleanID,thisFile$file, sep="")), ]  #need to remove duplicates
c2          <- merge(commentFile, thisFile, by.x='file', by.y='file')

cTotesScore     <- data.frame('allScores' = tapply(commentFile$score, commentFile$file, sum))
cTotesScore$file<- row.names(cTotesScore)
c2              <- merge(c2, cTotesScore, by='file')
c2$scoreShare   <- c2$score / c2$allScores
rm(cTotesScore)

#
# relative to prompt
# -- time to create project
#
c2$timeToCreate <- (c2$created - c2$p_created_utc)/3600
c2$timeToCreate <- recode(c2$timeToCreate, "24:hi=24")
c2$highScore    <- recode(c2$score, "lo:3.9=0; else=1")    #dummy for top 20% 
c2$timeSquared  <- c2$timeToCreate * c2$timeToCreate
c2$blockOfText  <- recode(c2$paragraph_count, "1=1; else = 0" )
c2$bigBlockText <- recode(c2$blockOfText * c2$word_count, "100:hi =1; else = 0")

c2$onlyTop        <- recode(c2$topLevel, "1=1; else=NA")                       #only take top-level comments
c2$highScore2     <- recode(c2$score*c2$onlyTop, "lo:4.9=0; NA=NA; else=1")    #dummy for top 20% of top-level comments
c2$author         <- drop.levels(c2$author)

###############################
# make author-level data
###############################
c2author10        <- subset(c2, c2$topLevel ==1)

c2author10$author <- drop.levels(c2author10$author)
c2authorRe        <- subset(c2author10, select=c('author', 'id', 'created_utc', 'score'))
c2authorRe$c_utc  <- c2authorRe$created_utc
c2authorRe        <- c2authorRe[order(c2authorRe$author), ]
oldD  <- ''
for(i in 1:dim(c2authorRe)[1]) {
  newD <- c2authorRe$author[i]
  if(grepl(newD, oldD)){
    c2authorRe$created_utc[i] <- init
    init <- init+1
    oldD <- newD
  } else {
    init <- 1
    c2authorRe$created_utc[i] <- init
    init <- init+1
    oldD <- newD
  }
}
colnames(c2authorRe) <- c('author', 'id', 'order', 'score', 'created_utc')
c2authorRe <- c2authorRe[,-4]

c2 <- merge(c2, c2authorRe, by=c('author', 'id', 'created_utc'), all.x=TRUE)
c2$order[is.na(c2$order)] <- 0
rm(c2author10, c2authorRe)

#commentTemp  <- commentTemp[order(commentTemp$id), ]
#commentTemp  <- commentTemp[order(commentTemp$author), ]
#commentTemp  <- commentTemp[!duplicated(paste(commentTemp$id, commentTemp$body)),]


#cc <- data.frame('cd' = tapply(c2authorRe$score, c2authorRe$author, mean))
#ggplot(cc, aes(x=cd))+
#  geom_bar()
#
#c2wide            <- reshape(c2authorRe, v.names="score", 'idvar'='author', 'timevar'='created_utc', direction="wide")

#c2p <- subset(c2, c2$blockOfText == 1)
#quantile(c2p$blockOfText * c2p$word_count, probs=seq(0,1,0.2), na.rm=TRUE)
#table(c2p$blockOfText * c2p$word_count)

