#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(NLP)
library(tm)
library(RWeka)
library(DT)

load("unigram.Rda");
load("bigram.Rda");
load("trigram.Rda");
load("fourgram.Rda")

wordproc <- function(sentence){
  value = "next word is..."
  sen = unlist(strsplit(sentence,' '))
  if(length(sen)>3){
    value = fourgram(sen[(length(sen)-2):length(sen)])
  }
  
  if(is.null(value)||length(sen)==3){
    value = trigram(sen[(length(sen)-1):length(sen)])
    
  }
  if(is.null(value)||length(sen)==2){
    value = bigram(sen[length(sen)])
    
  }
  
  if(is.null(value)||length(sen)==1){
   value = unigram(sen[length(sen)])
    
  }
  if(is.null(value)){
    value = "a"
  }
  
  return(value)
}

fourgram <- function(fourg){
  four <- paste(fourg,collapse = ' ')
  four <- tolower(four)
  foursum <- data.frame(fourgram = "test", frequency = 0)
  k <- trigramlist[trigramlist$trigram==four,]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in unigramlist$unigram){
    text = paste(four,string0)
    found <- fourgramlist[as.character(fourgramlist$fourgram)==text,]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      foursum <- rbind(foursum,found)
      
    }
  }
  if(nrow(foursum)==1) return(NULL)
  foursum <- foursum[order(-foursum$frequency),]
  sen <- unlist(strsplit(as.String(foursum$fourgram[1]),' '))
  return (sen[length(sen)])
}

trigram <- function(threeg){
  three <- paste(threeg,collapse = ' ')
  three <- tolower(three)
  threesum <- data.frame(trigram = "test",frequency = 0)
  k <- bigramlist[as.character(bigramlist$bigram)==three,]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in unigramlist$unigram){
    text = paste(three,string0)
    found <- trigramlist[as.character(trigramlist$trigram)==text,]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      threesum <- rbind(threesum,found)
      
    }
  }
  if(nrow(threesum)==1) return(NULL)
  threesum <- threesum[order(-threesum$frequency),]
  sen <- unlist(strsplit(as.String(threesum$trigram[1]),' '))
  return (sen[length(sen)])
}

bigram <- function(twog){
  two <- paste(twog,collapse = ' ')
  two <- tolower(two)
  twosum <- data.frame(bigram = "test",frequency = 0)
  k <- unigramlist[unigramlist$unigram==two,]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in unigramlist$unigram){
    text = paste(two,string0)
    found <- bigramlist[as.character(bigramlist$bigram)==text,]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      twosum <- rbind(twosum,found)
      
    }
  }

  if(nrow(twosum)==1) return(NULL)
  twosum <- twosum[order(-twosum$frequency),]
  sen <- unlist(strsplit(as.String(twosum$bigram[1]),' '))
  return (sen[length(sen)])
}
  
unigram <- function(oneg){
  one <- paste(oneg,collapse = ' ')
  one <- tolower(one)
  onesum <- data.frame(bigram = "test", frequency = 0)
  
  for(string0 in unigramlist$unigram){
    text = paste(one,string0)
    found <- bigramlist[as.character(bigramlist$bigram)==text,]
    n <- as.numeric(found$frequency)
    
    if(length(n)!=0){
      onesum <- rbind(onesum,found)
    }
  }
  
  if(nrow(onesum)==1) return(NULL)
  onesum <- onesum[order(-onesum$frequency),]
  sen <- unlist(strsplit(as.String(onesum$bigram[1]),' '))
  return (sen[length(sen)])
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  mainPanel(
    h2("Predict Next Word"),
    h5("by Miao Wang, 1/15/2019"),
    
    textInput("Tcir",label=h3("Type your sentence here:")),
    submitButton('Submit'),
    h4('string you entered : '),
    verbatimTextOutput("inputValue"),
    h4('next word :'),
    verbatimTextOutput("prediction")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  output$inputValue <- renderPrint({input$Tcir})
  output$prediction <- renderPrint({wordproc(input$Tcir)})
  
}

# Run the application 
shinyApp(ui = ui, server = server)

