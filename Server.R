shinyServer(function(input,output){
  
  
  selectedData <- reactive({
    if (is.null(input$file))
      return()
    in.file<-input$file
    read.csv(in.file$datapath, header=input$chkbox)
                            })
  output$DropList<-renderUI({
    a<-selectedData()
    if (is.null(a))
      return()
    names2<-names(a)
    selectInput("depvar", 
                label = "Choose a dependent variable",
                choices=as.list(names2))
  }
  )
  output$GroupedCheckbox<-renderUI({
    a<-selectedData()
    if (is.null(a))
      return()
    names2<-names(a)
    if (is.null(input$depvar))
      return()
    indep<-input$depvar
    names2<-names2[!names2==indep]
    checkboxGroupInput("IndepVar", 
                       label = h3("Checkbox group"), 
                       choices = names2,
                       selected=names2)
  }
  )
  
  output$text1 <- renderTable({
    cx<-input$radio
    if (cx==4){
      in.1<-selectedData()
    }
    else if (cx==1){
      in.1<-selectedData()
      data.frame(summary(mtcars))
    }
    else if (cx==2){
      in.1<-selectedData()
      as.data.frame(head(in.1,n=10))
    }
    
    else {
      return()
    }
    
  })
  
  output$text2 <- renderPrint({
    cx<-input$radio
    if (cx==3){
      if (is.null(selectedData()))
      {return()}
      if (is.null(input$IndepVar))
        return()
      if (is.null(input$depvar))
        return()
      in.1<-selectedData()
      y<-input$depvar
      if (is.null(y))
      {exp1<-paste(input$depvar,1,sep='~')}
      else {
        if (is.null(input$IndepVar))
          return()
        v2<-gsub(", ","+",toString(input$IndepVar))
        exp1<-paste(input$depvar,v2,sep='~')
      }
      model<-lm(exp1,data=in.1)
      summary(model)
      }
  }
    )
  
  output$plot <- renderPlot({
    cx<-input$radio
    
    if (cx==3){
      if (is.null(selectedData()))
      {return()}
      if (is.null(input$IndepVar))
        return()
      if (is.null(input$depvar))
        return()
      in.1<-selectedData()
      y<-input$depvar
      if (is.null(y))
        {exp1<-paste(input$depvar,1,sep='~')}
      else {
        v2<-gsub(", ","+",toString(input$IndepVar))
          exp1<-paste(input$depvar,v2,sep='~')
      }
      model<-lm(exp1,data=in.1)
      plot(resid(model),in.1$y,ylab="residual",xlab=y)
    }
  }
  )
  
}

)