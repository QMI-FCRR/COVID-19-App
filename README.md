# COVID-19-App
All code for COVID-19 shiny app

  Function for how the graph is created.
  
  Also found in the server.R file

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
