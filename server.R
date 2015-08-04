#  R package AMADA 
#  Copyright (C) 2014  COIN
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
palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
library(AMADA)
library(shiny)
library(mvtnorm)
library(pheatmap)
library(markdown)
options(shiny.maxRequestSize=100*1024^2)
  
shinyServer(function(input, output, session) {
  # Now, we need to create the reactive container 
  
  selectedData <- reactive({
    # First we need to have some data
    if(input$dataSourceFlag == F) {
    inFile <- input$file1
    if (is.null(inFile)){
      return(NULL)
    #return("\n GRAD :: No file was uploaded for  estimation! ")
    }
    # Now read the files
    read.table(inFile$datapath, header=T)
    
    }
    
    else{
    if(input$data=="SNII"){
      data(SNII)
      SNII}else{
   if(input$data=="SNIa"){
           data(SNIa)
             SNIa}
   else{
  if(input$data=="Guo11"){
              data(Guo11)
               Guo11}
  else{
  if(input$data=="KiDS_test"){
         data(KiDS_test)
         KiDS_test}
  else{
      if(input$data=="ZENS"){
                   data(ZENS)
                   ZENS     
                 
               }}}} }         
  }})

  
  output$downloadData <- downloadHandler(
    filename = function() {'catalog.dat' },
    content = function(file) {
      tempObj <- selectedData()
      write.table(tempObj, file,sep=" ", row.names = FALSE)
    }
  )
  

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  Temp.cor<-reactive({Corr_MIC(selectedData(),method=input$method)
  })

# Show table

output$mytable1 = renderDataTable({
  nfrac<-(input$ntot/100)*dim(selectedData())[1]
selectedData()[1:nfrac,]
})

# Creat the plot   
# Heatmap
output$plot1 <- renderPlot({
  par(mar = c(0.5, 0.5, 0, 0.5))
  pheatmap(Temp.cor(), display_numbers=input$shown,fontsize=20)
  
},
height = 700, width = 800)

# Correlation Matrix
output$plot2 <- renderPlot({
  par(mar = c(0.5, 0.5, 0, 0.5))
  plotcorrDist(Temp.cor(), labels = NULL)
  
})

# Dendogram
output$plot3 <- renderPlot({
 par(mar = c(3, 3, 3, 3))
  plotdendrogram(Temp.cor(),type=input$type)
},height = 600, width = 800)

  # Graph 
  output$plot4 <- renderPlot({
    par(mar = c(0.5, 0.5, 0, 0.5))
    plotgraph(Temp.cor(),layout=input$layout)
},height = 600, width = 750)



# PCA 
output$plot5 <- renderPlot({
  par(mar = c(0.5, 0.5, 0, 0.5))
  Nightingale(Corr_MIC(selectedData(),method="pearson"),npcs=input$npcs,PCAmethod=input$PCAmethod)},
height = 700, width = 800)

# Chord 
output$plot6 <- renderPlot({
  par(mar = c(0.5, 0.5, 0, 0.5))
  chordDiagram(Temp.cor(),grid.col = "gray70",symmetric = T,transparency = 0.3,
               col = colorRamp2(seq(-1, 1, by = 0.25), rev(brewer.pal(9,input$colour))))

},height = 600, width = 600)



})