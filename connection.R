
# Document Information ----
my.d <- rstudioapi::getActiveDocumentContext()

# Document Path ----
my.file.location <- rstudioapi::getActiveDocumentContext()$path

# Directory Path ----
my.dir <- dirname(my.file.location)

# Setting up the working directory ----
setwd(my.dir)

# install.packages("devtools") ----
devtools::install_github("r-dbi/DBI")
devtools::install_github("r-dbi/RMySQL")

# Loading required packages ----
library(RMySQL)
library(DBI)

# Connection ----

con <- dbConnect(MySQL(), host = "127.0.0.1", port = 3306, user = "root", password = "Sucesso2018!")

# Creating a database using RMySQL in R ----

dbSendQuery(con, "CREATE DATABASE researchdb;")

# Use DataBase ----
dbSendQuery(con, "USE researchdb")

# Reconnecting to database we just created using following command in R ----

con <- dbConnect(MySQL(), host = "127.0.0.1", port = 3306, user = "root", password = "Sucesso2018!", dbname = "researchdb")

# Creating table ----

dbSendQuery(con, "
CREATE TABLE sensordevice (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
deviceid INT,
temperature FLOAT,
humidity FLOAT,
light_intensity FLOAT,
pressure FLOAT);")

# Inserting data ----

deviceid <- 7
for (i in 1:10) {
  text <- sprintf("insert data %d", i)
  print(text)
  temperature <- runif(1,20.5,32.56)
  humidity <- runif(1,10.3,15.68)
  light_intensity <- runif(1,5.8,12.23)
  pressure <- runif(1,50.11,70.65)
  
    query <- paste("INSERT INTO sensordevice(deviceid, temperature, humidity, light_intensity, pressure) VALUES (", deviceid,",", temperature,",", humidity,",", light_intensity,",", pressure,")")

  dbGetQuery(con, query)
}

# Show table using R ----

dbListTables(con)
dbHasCompleted(con)
dbGetRowsAffected(con)
dbClearResult(con)
dbDisconnect(con)
