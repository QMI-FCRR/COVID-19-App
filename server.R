
library(shiny)
library(R.utils)
library(tidyverse)
library(TTR)
library(ggplot2)


shinyServer(function(input, output, session) {

#Functions
    joe<-as.data.frame(readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"))
    totnew<-function(dat, State) {
        
        dat<-joe[joe$state==State ,]
        dat <- subset(dat, cases > 5)
        totalcase<-as.vector(dat$cases)
        bill<-(diff(totalcase,1))
        change <- insert(bill, ats=1, values=0)
        group<-c(rep(c(1), each = length(change)))
        days<-c(1:length(group))
        first<-as.data.frame(cbind(change,group,days))
        
        first$change_d3<-runMean(first$change,3)
        first$days_d3<-runMean(first$days,3)
        first<-first[!is.na(first$change_d3),]
        
        change <- totalcase
        group<-c(rep(c(2), each = length(change)))
        days<-c(1:length(group))
        second<-as.data.frame(cbind(change,group, days))
        second$change_d3<-runMean(second$change,3)
        second$days_d3<-runMean(second$days,3)
        second<-second[!is.na(second$change_d3),]
        
        dat<-as.data.frame(rbind(first,second))
        
        
        ggplot(dat, aes(x=log(days_d3), y=log(change_d3), group=group, color=as.factor(group))) +
            geom_line() + 
            geom_point() + 
            labs(title=State,
                 x ="Log of 3 Day Rolling Average of New Cases", y = "Log of Cases Confirmed") +
            ylim(0, 12) +
            theme_classic() +
            theme(plot.title = element_text(hjust = 0.05, vjust = -4.5, size = 36, color = "#679cf2"), legend.position = "none")
            #scale_color_discrete(name = "", labels = c("Total Cases", "New Cases for the Day"))
    }
    
    popout <- function(direction)
    {
        if(direction == "out")
        {
            jqui_remove_class("#how-it-works-lrg", className = "hidden", duration = 10)
            delay(200, jqui_hide("#how-it-works-small", effect = "slide", duration = 300))
            delay(500, jqui_show("#how-it-works-lrg", effect = "slide", duration = 1000))
        }
        else
        {
            delay(200, jqui_hide("#how-it-works-lrg", effect = "slide", duration = 1000))
            delay(1200, jqui_show("#how-it-works-small", effect = "slide", duration = 300))
        }
    }
    
    jqui_hide("#how-it-works-lrg", effect = "fade", duration = 10)
    
    shinyjs::onclick("how-it-works-small", popout("out"))
    shinyjs::onclick("how-it-works-lrg", popout("in"))
    
#Server
    
    output$graphic <- renderPlot({
        totnew(state.abb[match(input$state_input, state.name)], input$state_input)
    })
    
    

})
