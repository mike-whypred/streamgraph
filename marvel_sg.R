
#install.packages('scales')
#install.packages('tidyr')
#install.packages('dplyr')
#install.packages('streamgraph')
#install.packages('RColorBrewer')

library(dplyr)
library(RColorBrewer)
library(streamgraph)
library(scales)
library(tidyr)



#####
#function to generate palette

getPalette = colorRampPalette(brewer.pal(11, "Spectral"))
#show_col(getPalette(28),labels=FALSE)

#####
#transform occurence matrix into tidy dataset

marvel<-read.csv('marvel2.csv', header = TRUE)

long_marvel<-marvel%>%gather(Hero,Appearance,Ant.Man:Winter.Soldier)
long_marvel$Date<-as.Date(long_marvel$Date, format = "%d/%m/%Y")
#long_marvel[order(as.Date(long_marvel$X, format="%d/%m/%Y")),]

#####
#generate viz with labels for notable movies in MCU timeline

sg<-streamgraph(long_marvel, key= 'Hero', value = 'Appearance', date='Date', width = NULL, height = NULL,
            offset = "silhouette", interpolate = "cardinal", interactive = TRUE)

sg

%>%
  sg_axis_x(5, "Year", "%Y") %>%

  sg_fill_manual(values = getPalette(28)) %>%

  sg_annotate(label="Iron Man", x=as.Date("2008-05-01"), y=14, color="black", size=11) %>%

  sg_annotate(label="Thor", x=as.Date("2011-04-29"), y=16, color="black", size=10) %>%

  sg_annotate(label="The Avengers", x=as.Date("2012-04-25"), y=17, color="black", size=18) %>%

  sg_annotate(label="Avengers: Age of Ultron", x=as.Date("2015-04-23"), y=20, color="lightcoral", size=16) %>%

  sg_annotate(label="Captain America: Civil War", x=as.Date("2016-04-28"), y=19, color="maroon", size=15) %>%

  sg_annotate(label="Avengers: Infinity War", x=as.Date("2018-04-23"), y=22, color="maroon", size=20) %>%

  sg_annotate(label="Avengers: EG", x=as.Date("2019-04-24"), y=24, color="maroon", size=25)%>%


  sg_annotate(label="[Phase 1", x=as.Date("2008-04-24"), y=2, color="black", size=30)%>%
  sg_annotate(label="[Phase 2", x=as.Date("2013-04-01"), y=2, color="lightcoral", size=30)%>%
  sg_annotate(label="[Phase 3", x=as.Date("2016-04-01"), y=2, color="maroon", size=30)%>%
  sg_annotate(label="[Phase 4", x=as.Date("2020-01-01"), y=2, color="paleturquoise", size=30)%>%
  sg_annotate(label="$590mn", x=as.Date("2008-05-01"), y=13.75, color="black", size=9)%>%
  sg_annotate(label="$450mn", x=as.Date("2011-04-25"), y=15.75, color="black", size=8)%>%
  sg_annotate(label="$1.5bn", x=as.Date("2012-04-25"), y=16.5, color="black", size=14)%>%
  sg_annotate(label="$1.4bn", x=as.Date("2015-04-23"), y=19.5, color="lightcoral", size=13)%>%
  sg_annotate(label="$1.2bn", x=as.Date("2016-04-28"), y=18.5, color="maroon", size=12)%>%
  sg_annotate(label="$2.0bn", x=as.Date("2018-04-23"), y=21.5, color="maroon", size=15)%>%
  sg_annotate(label="$2.8bn", x=as.Date("2019-04-24"), y=23.25, color="maroon", size=19)%>%
  sg_legend(show = FALSE, label = "Hero")

sg




