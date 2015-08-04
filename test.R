library(AMADA)
library(shiny)
library(mvtnorm)
library(pheatmap)
library(markdown)
library(plotly)
library(circlize)
library(RColorBrewer)
library(shinysky)
options(shiny.maxRequestSize=100*1024^2)

server<-function(input, output, session) {
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
              if(input$data=="ZENS"){
                data(ZENS)
                ZENS     
                
              }}} }         
    }})
  
  
  output$downloadData <- downloadHandler(
    filename = function() {'catalog.dat' },
    content = function(file) {
      tempObj <- selectedData()
      write.table(tempObj, file,sep=" ", row.names = FALSE)
    }
  )
  
  
  output$data2<-reactive({
    selectedData()[,input$variables]}
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
  #output$dist= renderText({
  #  "The plot displays   the color-coded  dissimilarity level for each pair of variables. The bluest squares 
  #  represents parameters with the low dissimilarity or high correlation, conversely the redests squares
  #  parameters wit high dissimilarity or low correlation."
  #})
  
  
  
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
  
  
  
}

ui<-fluidPage(theme = "bootstrapblue.css",
                  
                  headerPanel('AMADA Web User Interface (v0.2)'),
                  img(src='COIN.jpg',height = 95, width = 650,align="right"),
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
                    #    p("AMADA allows an iterative exploration and information retrieval of high-dimensional data sets.
                    #This is done by performing a hierarchical clustering analysis for different choices of correlation matrices and by doing a principal components analysis
                    #in the original data. Additionally, AMADA provides a set of modern  visualization data-mining diagnostics. ", align = "left"),
                    
                    h4("Data Input"),
                    div(div(checkboxInput('dataSourceFlag', label=h5('Available datasets'), T),class="radio"
                    )),
                    selectInput("data", "Dataset:",
                                list("SNe Ia host galaxies" = "SNIa","SNe II host galaxies" = "SNII",
                                     "N-body halo catalog" = "Guo11","ZENS catalog"="ZENS")),
                    checkboxGroupInput("variables", "Choose columns", 
                                       choices  =  colnames("data"),
                                       selected =  colnames("data")),
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
                    #br(), 
                    #downloadButton("downloadPlot1", label = "Download Heatmap"),
                    #br(), 
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
)
shinyApp(ui = ui, server = server)

