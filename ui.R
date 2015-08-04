#  R package AMADA 
# Copyright (C) 2014  COIN
# Author : Rafael S. de Souza (rafael.2706@gmail.com)
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License version 3 as published by
#the Free Software Foundation.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/
#
library(shiny)
library(mvtnorm)
library(pheatmap)
library(markdown)
#library(shinyIncubator)
#library(shinysky)
library(circlize)
library(RColorBrewer)
#library(shinysky)


shinyUI(fluidPage(theme = "bootstrapblue.css",
 
  headerPanel('AMADA Web User Interface (v0.2) : Adapted for KiDS Project'),
#  img(src='COIN.jpg',height = 95, width = 650,align="right"),
  # Sidebar with controls
  sidebarPanel(
  
 #   tags$head(tags$style(
#type="text/css", "
            #loadmessage {
#               position: fixed;
#               top: 50%;
#               left: 0px;
#               width: 100%;
#               padding: 5px 0px 5px 0px;
#             text-align: center;
#               font-weight: bold;
#               font-size: 125%;
#              color: #FFFFFF;
#               background-color: #B22222;
#               z-index: 105;
#             }
#          ")),
#h3("Overview"),
#    p("AMADA for KiDS allows an iterative exploration and information retrieval of the high-dimensional data set in the KiDS catalogues.
#This is done by performing a hierarchical clustering analysis for different choices of correlation matrices and by doing a principal components analysis
#in the original data. Additionally, AMADA provides a set of modern visualization data-mining diagnostics. ", align = "left"),
   
h4("Data Input"),
    div(div(checkboxInput('dataSourceFlag', label=h5('Available datasets'), T),class="radio"
        )),
    selectInput("data", "Dataset:",
                list("KiDS_test"="KiDS_test")),
fileInput('file1', 'Import dataset (CSV/TXT)', accept=c('.dat', '.txt','.csv')),

h4("Control  options"),

h5("Correlation"),
selectInput("method", "Method:",
            list("Pearson" = "pearson",
                 "Spearman" = "spearman",
                 "MIC" = "MIC")),
h5("Dataset"),
sliderInput('ntot', 'Fraction of data to display (%)', 10,
            min = 10, max = 100,step=10),
br(), 
downloadButton("downloadData", label = "Download Data"),
br(), 


h5("Heatmap"),
selectInput("shown", "Display Numbers?",
            list("No" = "F",
                 "Yes" = "T"
                )),

h5("Dendrogram"),
selectInput("type", "Type:",
            list("Phylogram" = "phylogram",
                 "Cladogram" = "cladogram",
                 "Fan" = "fan")),
h5("Graph"),
selectInput("layout", "Layout:",
            list("Spring" = "spring",
                 "Circular" = "circular")),

h5("Chord diagram"),
selectInput("colour", "Colour:",
            list("Red-Blue" = "RdBu",
                 "Yellow-Green" = "YlGn","Purple-Green"="PRGn", "Orange-Red"="OrRd")),

h5("Nightingale chart"),
selectInput("PCAmethod", "PCA Method:",
            list("PCA" = "PCA",
                 "Robust PCA" = "RPCA"
                 )),
sliderInput('npcs', 'Number of PCs', 1,
            min = 1, max = 10,step=1),
    br(), 
submitButton("Make it so!", icon("refresh")),

br(),
wellPanel(
  helpText(HTML("<b>Authors</b>")),
  HTML('Rafael S. de Souza'),
  HTML('<br>'),
  HTML('Benedetta Ciardi'),
  HTML('<br>'),
  HTML('<a href="https://github.com/RafaelSdeSouza" target="_blank">Code on GitHub</a>')
)
  ),
  #Show output plot
mainPanel(
    
  tabsetPanel(
    tabPanel("Introduction", includeMarkdown("README.md")),
    tabPanel('Dataset',
             dataTableOutput("mytable1")),
    tabPanel("Heatmap",plotOutput('plot1')),
      tabPanel(title="Distogram",plotOutput('plot2')),
      tabPanel("Dendrogram",plotOutput('plot3')),
      tabPanel("Graph",plotOutput('plot4')),
      tabPanel("Chord diagram",plotOutput('plot6')),
      tabPanel("Nightingale chart",plotOutput('plot5',width = "100%")),
      tabPanel("Copyright", includeMarkdown("Copyright.md")),
     tabPanel("COIN", includeMarkdown("COIN.md"))
      )),
div(class="progress-bar",class="progress progress-striped active",style="width: 70%;",
    conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                     tags$div("Calculating... wait a minute.",align="top")))
#,busyIndicator("Calculating... wait a minute.",wait = 0)
))
