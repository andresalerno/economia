
# Document Information ----
my.d <- rstudioapi::getActiveDocumentContext()

# Document Path ----
my.file.location <- rstudioapi::getActiveDocumentContext()$path

# Directory Path ----
my.dir <- dirname(my.file.location)

# Setting up the working directory ----
setwd(my.dir)

# Required Packages

library(sidrar)
library(ggplot2)
library(scales)
library(dynlm)
library(png)
library(gridExtra)
library(grid)
library(magick)
library(here) # For making the script run without a wd
library(magrittr) # For piping the logo
library(png)
library(xlsx)
library(openxlsx)

# Fetching the data via API ----
tabela = get_sidra(api='/t/1419/p/201201-201810/v/63/C315/7169/n7/3501')

times = seq(as.Date('2016-01-01'), as.Date('2018-10-01'), 
            by='month')

ipca = data.frame(time=times, ipca=tail(tabela$Valor, 34))

# Plotting ----

ggplot(ipca, aes(x=time, y=ipca))+
  geom_line(size=.8, colour='darkblue')+
  scale_x_date(breaks = date_breaks("1 months"),
               labels = date_format("%b/%Y"))+
  theme(axis.text.x=element_text(angle=90, hjust=1))+
  geom_point(size=9, shape=21, colour="#1a476f", fill="white")+
  geom_text(aes(label=round(ipca,1)), size=3, 
            hjust=0.5, vjust=0.5, shape=21, colour="#1a476f")+
  xlab('')+ylab('%')+
  labs(title='IPCA Variação Mensal',
       subtitle='Índice Geral para a Região Metropolitana de São Paulo',
       caption='Fonte: AS Partners Finance & Tech Solutions (IBGE.)')

# Exporting to Excel ----

writexl::write_xlsx(ipca, path = "my.data.xls")
