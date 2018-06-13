## Code handout for R ecology lesson: http://www.datacarpentry.org/R-ecology-lesson/
## With edits / additional code by Edward Wallace in the DC workshop
## in Edinburgh, June 2018: 
## 

### Creating objects in R
### Challenge
##
## What are the values after each statement in the following?
##
mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass/age  # mass_index?

sqrt_mass_index <- sqrt(mass_index)

seq(1,10)

args(seq)
?seq

round(3.14159, digits=2)
round(3.14159, 2)
round(digits=2, x= 3.14159)
args(round)
?round

onetoten <- seq(1,10)

weight_g <- c(50,60,65,82)
weight_g

weight_g / 1000

animals <- c("mouse", "rat", "dog")

animals
### Vectors and data types
## ## We’ve seen that atomic vectors can be of type character, numeric, integer, and
## ## logical. But what happens if we try to mix these types in a single
## ## vector?
## 
## ## What will happen in each of these examples? (hint: use `class()` to
## ## check the data type of your object)
num_char <- c(1, 2, 3, "a")

num_logical <- c(1, 2, 3, TRUE)

char_logical <- c("a", "b", "c", TRUE)

tricky <- c(1, 2, 3, "4")

simple <- as.integer(tricky)

as.character( onetoten)

class( 2 * onetoten )

class( 2L * onetoten )

## logical conditional selection
 weight_g[weight_g > 55]
 
weight_g2 <- c(weight_g, 21,34, 39,54)
weight_g2 < 35 
weight_g2 < 55 
weight_g2 < 35 & weight_g2 > 55 
weight_g2 < 35 | weight_g2 > 55 
weight_g2[ weight_g2 < 35 | weight_g2 > 55  ]


animals <- c("mouse", "rat", "dog", "cat")
animals == "rat"
animals[animals == "rat" | animals == "cat"]

animals[animals %in% c("rat","cat","goat")]

sum(onetoten)

sum(c(TRUE,FALSE))

sum( animals %in% c("rat","cat","goat") )


heights <- c(2,4,4, NA, 6)
mean(heights)
max(heights)
?mean
mean(heights, na.rm=TRUE)
max(heights, na.rm=TRUE)

is.na(heights)

heights[ !is.na(heights) ]
## 
## ## Why do you think it happens?
## 
## ## You've probably noticed that objects of different types get
## ## converted into a single, shared type within a vector. In R, we call
## ## converting objects from one class into another class
## ## _coercion_. These conversions happen according to a hierarchy,
## ## whereby some types get preferentially coerced into other types. Can
## ## you draw a diagram that represents the hierarchy of how these data
## ## types are coerced?
heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

# 1.
heights_no_na <- heights[!is.na(heights)] 
# or
heights_no_na <- na.omit(heights)

# 2.
median(heights, na.rm = TRUE)

# 3.
heights_above_67 <- heights_no_na[heights_no_na > 67]
length(heights_above_67)

blood_pressure <- c(80,85, 0, 98, 0, 87)
# blood_pressure[blood_pressure == 0] <- NA
# blood_pressure
# mean(blood_pressure,na.rm=TRUE)
blood_pressure[blood_pressure != 0]

## ###Challenge
## 1. Using this vector of heights in inches, create a new vector with the NAs removed.
##
##    heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
##
## 2. Use the function `median()` to calculate the median of the `heights` vector.
##
## 3. Use R to figure out how many people in the set are taller than 67 inches.


### Presentation of the survey data
## download.file("https://ndownloader.figshare.com/files/2292169",
##               "data/portal_data_joined.csv")

## Challenge
## Based on the output of `str(surveys)`, can you answer the following questions?
## * What is the class of the object `surveys`?
## * How many rows and how many columns are in this object?
## * How many species have been recorded during these surveys?

download.file(url = "https://ndownloader.figshare.com/files/2292169",
    destfile="data/portal_data_joined.csv")

surveys <- read.csv("data/portal_data_joined.csv")

dim
nrow
ncol
head
tail
names
rownames

summary(surveys)

surveys[1,3]
surveys[1,"species_id"]
surveys[,"species_id"]

unique(surveys[,"species_id"])

mensnames <- factor( c("David","John","William","David"))
mensnames

levels(mensnames)
?factor
nlevels(mensnames)

as.character(mensnames)
as.numeric(mensnames)

surveys[,"sex"]

levels( surveys[,"sex"] ) <- c("undetermined","F","M")
table( surveys[,"sex"] )

sex <- surveys[,"sex"]

sex
surveys[,"sex"]

surveys[1:10,"sex"]
surveys$sex

## Indexing and subsetting data frames
### Challenges:
###
### 1. Create a `data.frame` (`surveys_200`) containing only the
###    data in row 200 of the `surveys` dataset.
###
### 2. Notice how `nrow()` gave you the number of rows in a `data.frame`?
###
###      * Use that number to pull out just that last row in the data frame
###      * Compare that with what you see as the last row using `tail()` to make
###        sure it's meeting expectations.
###      * Pull out that last row using `nrow()` instead of the row number
###      * Create a new data frame object (`surveys_last`) from that last row
###
### 3. Use `nrow()` to extract the row that is in the middle of the
###    data frame. Store the content of this row in an object named
###    `surveys_middle`.
###
### 4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
###    `head(surveys)`, keeping just the first through 6th rows of the surveys
###    dataset.

### Factors
sex <- factor(c("male", "female", "female", "male"))
year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)               # Wrong! And there is no warning...
as.numeric(as.character(year_fct)) # Works...
as.numeric(levels(year_fct))[year_fct]    # The recommended way.
## bar plot of the number of females and males captured during the experiment:
plot(surveys$sex)
## Challenges
##
## * Rename "F" and "M" to "female" and "male" respectively.
## * Now that we have renamed the factor level to "undetermined", can you recreate the
##   barplot such that "undetermined" is last (after "male")

## ## Compare the difference between our data read as `factor` vs `character`.
surveys <- read.csv("data/portal_data_joined.csv", stringsAsFactors = TRUE)
str(surveys)
surveys <- read.csv("data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys)
## ## Convert the column "plot_type" into a factor
surveys$plot_type <- factor(surveys$plot_type)
## ## Challenge:
## ##  There are a few mistakes in this hand-crafted `data.frame`,
## ##  can you spot and fix them? Don't hesitate to experiment!
## animal_data <- data.frame(
##       animal = c(dog, cat, sea cucumber, sea urchin),
##       feel = c("furry", "squishy", "spiny"),
##       weight = c(45, 8 1.1, 0.8)
##       )
## ## Challenge:
## ##   Can you predict the class for each of the columns in the following
## ##   example?
## ##   Check your guesses using `str(country_climate)`:
## ##   * Are they what you expected? Why? why not?
## ##   * What would have been different if we had added `stringsAsFactors = FALSE`
## ##     when we created this data frame?
## ##   * What would you need to change to ensure that each column had the
## ##     accurate data type?
## country_climate <- data.frame(country = c("Canada", "Panama", "South Africa", "Australia"),
##                                climate = c("cold", "hot", "temperate", "hot/temperate"),
##                                temperature = c(10, 30, 18, "15"),
##                                northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
##                                has_kangaroo = c(FALSE, FALSE, FALSE, 1))


paste("2015","1","1",sep="-")
ymd(paste("2015","1","1",sep="-"))

surveys$date <- paste(surveys$year,surveys$month,surveys$day,sep="-")

## Day 2 starts here.



getwd()
setwd("/Users/edwardwallace/carpentry/ecology-2018-06-12/")
getwd()

surveys <- read_csv("data/portal_data_joined.csv")
surveys

nrow(surveys)
quantile(seq(1,nrow(surveys)), c(0.25,0.5))

# Challenge: use quantile, seq, round, and [] notation to
# find the 2nd quarter of the dataset!


select(surveys,plot_id, species_id, weight, taxa)
select(surveys,plot_id,plot_type)

filter(surveys, year == 1995)

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

## Pipe!
 filter( surveys, weight < 5 ) %>% 
     select(species_id, sex, weight)

seq(1,10) %>%
    sum()
sum( seq(1,10) ) # less readable! 

seq(1,10) %>%
    sum() %>%
    sqrt()

surveys_NL_big <- surveys %>%
    filter(species_id == "NL", weight > 100) %>%
    select(sex, weight)

## 
## ## Pipes Challenge:
## ##  Using pipes, subset the data to include individuals collected
## ##  before 1995, and retain the columns `year`, `sex`, and `weight.`


# select(dataset, thing to select, 2nd thing to select,...)
# filter(dataset, thing to filter, 2nd thing to filter,...)

surveys %>%
    mutate(weight_kg = weight / 1000) %>%
    select(species_id, weight, weight_kg) %>%
    filter( !is.na(weight) )

surveys %>%
    mutate(weight_kg = weight / 1000,
           weight_lb = weight / 1000 * 2.2 ) %>%
    select(species_id,weight, weight_kg, weight_lb)

## ## Mutate Challenge:
## ##  Create a new data frame from the `surveys` data that meets the following
## ##  criteria: contains only the `species_id` column and a column that
## ##  contains values that are half the `hindfoot_length` values (e.g. a
## ##  new column `hindfoot_half`). In this `hindfoot_half` column, there are
## ##  no NA values and all values are < 30.
## 

surveys %>%
    group_by(sex) %>%
    summarize(mean_weight = mean(weight,na.rm=TRUE))

surveys %>%
    group_by(sex,species_id) %>%
    summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>%
    filter(species_id %in% c("OL","OT","OX")) %>%
    group_by(sex,species_id) %>%
    summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>%
    filter( ! is.na(weight) ) %>%
    group_by(species_id, sex) %>%
    summarize(mean_weight = mean(weight),
              min_weight = min(weight),
              max_weight = max(weight) ) %>%
    arrange(min_weight,mean_weight)

surveys %>%
    filter( ! is.na(weight) ) %>%
    group_by(species_id, sex) %>%
    summarize(mean_weight = mean(weight),
              min_weight = min(weight),
              max_weight = max(weight) ) %>%
    arrange(desc(min_weight))

surveys %>%
    count(sex)

surveys %>%
    count(sex, species_id)

surveys %>%
    count(sex,species_id) %>%
    arrange(desc(n))
## ##  Hint: think about how the commands should be ordered to produce this data frame!
## ## Count Challenges:
## ##  1. How many individuals were caught in each `plot_type` surveyed?
## 
## ##  2. Use `group_by()` and `summarize()` to find the mean, min, and max
## ## hindfoot length for each species (using `species_id`). Also add the number of
## ## observations (hint: see `?n`).
## 
## ##  3. What was the heaviest animal measured in each year? Return the
## ##  columns `year`, `genus`, `species_id`, and `weight`.

surveys %>%
    filter( !is.na(weight) ) %>% 
    group_by(year) %>%
    filter(weight == max(weight)) %>%
    arrange(year) %>%
    select(year, genus, species_id, weight)

## ## Reshaping challenges
## 
## ## 1. Make a wide data frame with `year` as columns, `plot_id`` as rows, and where the values are the number of genera per plot. You will need to summarize before reshaping, and use the function `n_distinct` to get the number of unique genera within a chunk of data. It's a powerful function! See `?n_distinct` for more.
## 
## ## 2. Now take that data frame, and make it long again, so each row is a unique `plot_id` `year` combination
## 
## ## 3. The `surveys` data set is not truly wide or long because there are two columns of measurement - `hindfoot_length` and `weight`.  This makes it difficult to do things like look at the relationship between mean values of each measurement per year in different plot types. Let's walk through a common solution for this type of problem. First, use `gather` to create a truly long dataset where we have a key column called `measurement` and a `value` column that takes on the value of either `hindfoot_length` or `weight`. Hint: You'll need to specify which columns are being gathered.
## 
## ## 4. With this new truly long data set, calculate the average of each `measurement` in each `year` for each different `plot_type`. Then `spread` them into a wide data set with a column for `hindfoot_length` and `weight`. Hint: Remember, you only need to specify the key and value columns for `spread`.
## 
## ### Create the dataset for exporting:
## ##  Start by removing observations for which the `species_id`, `weight`,
## ##  `hindfoot_length`, or `sex` data are missing:
## surveys_complete <- surveys %>%
##     filter(species_id != "",        # remove missing species_id
##            !is.na(weight),                 # remove missing weight
##            !is.na(hindfoot_length),        # remove missing hindfoot_length
##            sex != "")                      # remove missing sex
## 
## ##  Now remove rare species in two steps. First, make a list of species which
## ##  appear at least 50 times in our dataset:
## species_counts <- surveys_complete %>%
##     count(species_id) %>%
##     filter(n >= 50) %>%
##     select(species_id)
## 
## ##  Second, keep only those species:
## surveys_complete <- surveys_complete %>%
##     filter(species_id %in% species_counts$species_id)

surveys_complete <- read_csv("http://r-bio.github.io/data/surveys_complete.csv")


ggplot(data=surveys_complete,mapping = aes(x = weight, y = hindfoot_length)) + 
    geom_point()

ggplot(data=surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, colour=species_id)) + 
    geom_point()

## Filter by species
surveys_complete %>%
    group_by(species_id) %>%
    count() %>%
    arrange(desc(n))

ggplot(data=surveys_complete %>% filter(species_id %in% c("DM","PP","PB")),
       mapping = aes(x = weight, y = hindfoot_length, colour=species_id)) + 
    geom_point()

ggplot(data=surveys_complete %>% filter(species_id == "DM"),
       mapping = aes(x = weight, y = hindfoot_length)) + 
    geom_bin2d()

ggplot(data=surveys_complete %>% filter(species_id %in% c("DM","PP","PB")),
       mapping = aes(x = weight, y = hindfoot_length, colour=species_id)) + 
    geom_point(alpha = 0.1)

ggplot(data=surveys_complete %>% filter(species_id %in% c("DM","PP","PB")),
       mapping = aes(x = weight, y = hindfoot_length)) + 
    geom_point(alpha = 0.1,colour="skyblue")

# rcolorchart

ggplot(data=surveys_complete %>% filter(species_id %in% c("DM","PP","PB")),
       mapping = aes(x = weight, y = hindfoot_length, colour=species_id)) + 
    geom_point(alpha = 0.1) +
    scale_colour_manual(values = c("DM" = "red", "PP" = "purple", "PB" = "royalblue"))

last_plot() +
 scale_x_log10(breaks = c(10,20,30,40,50,60))

ggplot(data=surveys_complete %>% 
           filter(species_id %in% c("DM","PP","PB"),sex %in% c("M","F")),
       mapping = aes(x = weight, y = hindfoot_length, colour=sex)) + 
    geom_point(alpha = 0.1) +
    scale_colour_manual(values = c("M" = "red", "F" = "blue")) +
    facet_wrap(~species_id)

ggplot(data=surveys_complete %>% 
           filter(species_id %in% c("DM","PP","PB"),sex %in% c("M","F")),
       mapping = aes(x = weight, y = hindfoot_length, colour=sex)) + 
    geom_point(alpha = 0.1) +
    scale_colour_manual(values = c("M" = "red", "F" = "blue")) +
    facet_grid(sex~species_id)

ggplot(data=surveys_complete, aes(x=species_id, y= weight)) +
    geom_jitter(alpha=0.1,colour="tomato") +
    geom_boxplot(fill=NA) +
    theme_bw()

### Data Visualization with ggplot2
## install.packages("hexbin")
## library(hexbin)
## surveys_plot +
##  geom_hex()
## ### Challenge with hexbin
## ##
## ## To use the hexagonal binning with **`ggplot2`**, first install the `hexbin`
## ## package from CRAN:
## 
## install.packages("hexbin")
## library(hexbin)
## 
## ## Then use the `geom_hex()` function:
## 
## surveys_plot +
##     geom_hex()
## 
## ## What are the relative strengths and weaknesses of a hexagonal bin
## ## plot compared to a scatter plot?

## ## Challenge with boxplots:
## ##  Start with the boxplot we created:
## ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
##   geom_boxplot(alpha = 0) +
##   geom_jitter(alpha = 0.3, color = "tomato")
## 
## ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
## 
## ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
## 
## ##  3. Create boxplot for `hindfoot_length` overlaid on a jitter layer.
## 
## ##  4. Add color to the data points on your boxplot according to the
## ##  plot from which the sample was taken (`plot_id`).
## ##  *Hint:* Check the class for `plot_id`. Consider changing the class
## ##  of `plot_id` from integer to factor. Why does this change how R
## ##  makes the graph?
## 
## ### Plotting time series challenge:
## ##
## ##  Use what you just learned to create a plot that depicts how the
## ##  average weight of each species changes through the years.
## 
## ### Final plotting challenge:
## ##  With all of this information in hand, please take another five
## ##  minutes to either improve one of the plots generated in this
## ##  exercise or create a beautiful graph of your own. Use the RStudio
## ##  ggplot2 cheat sheet for inspiration:
## ##  https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf


## SQL databases and R
## install.packages(c("dbplyr", "RSQLite"))
library(dplyr)
library(dbplyr)
mammals <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")
src_dbi(mammals)
tbl(mammals, sql("SELECT year, species_id, plot_id FROM surveys"))
surveys <- tbl(mammals, "surveys")
surveys %>%
    select(year, species_id, plot_id)
## with dplyr syntax
species <- tbl(mammals, "species")

left_join(surveys, species) %>%
  filter(taxa == "Rodent") %>%
  group_by(taxa, year) %>%
  tally %>%
  collect()

## with SQL syntax
query <- paste("
SELECT a.year, b.taxa,count(*) as count
FROM surveys a
JOIN species b
ON a.species_id = b.species_id
AND b.taxa = 'Rodent'
GROUP BY a.year, b.taxa",
sep = "" )

tbl(mammals, sql(query))


### Challenge
## Write a query that returns the number of rodents observed in each
## plot in each year.

##  Hint: Connect to the species table and write a query that joins
##  the species and survey tables together to exclude all
##  non-rodents. The query should return counts of rodents by year.

## Optional: Write a query in SQL that will produce the same
## result. You can join multiple tables together using the following
## syntax where foreign key refers to your unique id (e.g.,
## `species_id`):

## SELECT table.col, table.col
## FROM table1 JOIN table2
## ON table1.key = table2.key
## JOIN table3 ON table2.key = table3.key

## species <- tbl("mammals", species)
## genus_counts <- left_join(surveys, plots) %>%
##   left_join(species) %>%
##   group_by(plot_type, genus) %>%
##   tally %>%
##   collect()
### Challenge

## Write a query that returns the total number of rodents in each
## genus caught in the different plot types.

##  Hint: Write a query that joins the species, plot, and survey
##  tables together.  The query should return counts of genus by plot
##  type.
species <- read_csv("data/species.csv")
surveys <- read_csv("data/surveys.csv")
plots <- read_csv("data/plots.csv")
my_db_file <- "portal-database.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
my_db
### Challenge

## Add the remaining species table to the my_db database and run some
## of your queries from earlier in the lesson to verify that you
## have faithfully recreated the mammals database.


