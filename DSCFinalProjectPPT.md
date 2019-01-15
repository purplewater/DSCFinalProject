---
title: "Shiny App -- Predict Next Word"
author: Miao Wang
date: 1/15/2019
output: 
  ioslides_presentation: 
    keep_md: yes
    smaller: yes
    widescreen: yes
---



setwd("~/R_MW_20180914/DSC Final Project")

## Introduction

This is an RStudio shiny application developed as a part of final project in the data science capstone course in Coursera Data Science Specialization track. The application predict the next word of a sentence.


**First Objective for this assignment: to create a Shiny Application**

* The file is available at a Github: https://github.com/purplewater/DDPWeek4Assignment
* The APP can be found at: https://purplewater.shinyapps.io/DDPWeek4Assignment/
     + Form of input used: text box, action button
     + Using function to predict the next word

**Second Objective for this assignment: to create a R Presentation**

* The presentation is available at Rpubs:http://rpubs.com/purplewater/DDPWeek4Assignment


## Methodology

* Remove punctuation, links, white space, numbers and other special characters
* Sample size: 500 per set (total three datasets)
* Tokenized text data sample into n-grams
* compute 1-4 grams, used **back-off model**: 
    + select last 3 words user entered and search for 4 gram
    + if not found, search 3-gram and so on
    + if not found in all the grams, use most frequent unigram as next word

## How to use

1. visit 
2. Enter a phrase in the provided text box and click SUBMIT
3. The predicted word will be shown in the next word section

<img src="screenshot2.jpg" width="900px" />

## ...

<img src="Thank.jpg" width="1000px" />

