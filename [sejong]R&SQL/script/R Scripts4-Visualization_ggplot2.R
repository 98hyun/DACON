##################################################
# R Scripts 4: Data Visualization (ggplot2)      # 
#               & Reports (RMarkdown)            #
#  (Selected Topics from                         #
#     UC Business Analytics R Programming Guide) #
##################################################

####################################
# Data Visualization using ggplot2 #
####################################
browseURL("http://uc-r.github.io/ggplot")

# Packages Utilized
# install.packages("dplyr")
# install.packages
library(dplyr)
library(ggplot2)
# Cheatsheet for ggplot2: Help -> Cheatsheets -> Data Visualization with ggplot2

## ggplot2 Basics
####################

## The Grammar of Graphics
# 1. the data being plotted
# 2. the geometric objects (circles, lines, etc.) that appear on the plot
# 3. a set of mappings from variables in the data to the aesthetics (appearance) of the geometric objects
# 4. a statistical transformation used to calculate the data values used in the plot
# 5. a position adjustment for locating each geometric object on the plot
# 6. a scale (e.g., range of values) for each aesthetic mapping used
# 7. a coordinate system used to organize the geometric objects
# 8. the facets or groups of data shown in different plots

## The minimum component in order to create a plot
# 1. Call the ggplot() function which creates a blank canvas
# 2. Specify aesthetic mappings, which specifies how you want to map variables to visual aspects. In this case we are simply mapping the displ and hwy variables in the 'mpg' dataset to the x- and y-axes.
# 3. You then add new layers that are geometric objects which will show up on the plot. In this case we add geom_point to add a layer with points (dot) elements as the geometric shapes to represent the data.

# check the datasets available from packages
data()

mpg # one of ggplot2 built-in datasets
str(mpg)
?mpg # get descriptions

## Scatter plot: 
##       -- examine association between two numeric variables 
##############################################################

## Creating scatter plot 
# calling ggplot() function -- creating canvas
ggplot(mpg)

# specifying aesthetic mappings -- declaring variables of interest mapped
ggplot(mpg, aes(x = displ, y = hwy))

# adding geometric layer -- data plotted
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

# changing color, shape or size of dots                  !
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = factor(class)))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(shape = factor(class)))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(size = factor(class)))

# adding a mapping from the 'class' of the cars to color characteristic   !
ggplot(mpg, aes(x = displ, y = hwy, color = factor(class))) +
  geom_point()

# using default color brewer
ggplot(mpg, aes(x = displ, y = hwy, color = factor(class))) +
  geom_point() +
  scale_color_brewer()

# R Color Brewer's palettes
browseURL("https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html")
#install.packages("RColorBrewer")
library(RColorBrewer)
par(mar=c(3,4,2,2))
display.brewer.all()

# specifying color palette
ggplot(mpg, aes(x = displ, y = hwy, color = factor(class))) +
  geom_point() +
  scale_color_brewer(palette = "Set3") # [inserted into the dashboard]

# applying an aesthetic property to an entire geometry -- set that property as an argument to the geom method, outside of the aes() call
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") #setting color

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue", size = 4) #setting size

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue", size = 4, alpha = 1/10) #setting transparency

## adding multiple geometries to a plot -- adding a smooth line
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# specify unique colors with each geom 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +
  geom_smooth(color = "red")

# color aesthetic passed to each geom layer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(se = FALSE) # se = FALSE -- remove confidence bands on the smooth line

# color aesthetic specified for only the geom_point layer     !
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) # [inserted into the dashboard]

## faceting: grouping a data plot into multiple different pieces (subplots)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(~ class)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ class)

# faceting data by more than one categorical variable. 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(year ~ cyl) # [inserted into the dashboard]

## adding labels & annotations
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel Efficiency by Engine Power",
       subtitle = "Fuel economy data from 1999 and 2008 for 38 popular models of cars",
       x = "Engine power (litres displacement)",
       y = "Fuel Efficiency (miles per gallon)",
       color = "Car Type")

# even adding labels into the plot itself (e.g., to label each point or line)

# a data table of each car that has best efficiency of its type
best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)
best_in_class

# install.packages("ggrepel") 
library(ggrepel)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) +
  geom_text_repel(data = best_in_class, aes(label = model))

## Bar plot 
##  -- examine frequencies (or counts) of 
##       a categorical (or discrete or factor) variable
#########################################################

# No y mapping needed: geom_bar() -- default is stat = "bin" 
#############################################################
# count (or frequency) is not a variable of the dataset, but is instead a statistical transformation. geom_bar automatically applies to the data
ggplot(data = mpg, aes(x = class)) +
  geom_bar() # by default, geom_bar() uses stat="bin" -- the height of each bar equal to the number of cases in each group

# changing outline and fill color of bars, and transparency
ggplot(data = mpg, aes(x = class)) +
  geom_bar(fill="dodgerblue", colour="grey40", alpha = .5) # [inserted into the dashboard]

# changing bar width
ggplot(data = mpg, aes(x = class)) +
  geom_bar(fill="pink", colour="black", alpha = .5, width = .5) #default width is 0.9 and max width is 1

# bar chart of class, colored by drive (front, rear, 4-wheel)
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar() # the default position adjustment is "stack" [inserted into the dashboard]

# Alternatively, position = "dodge": values next to each other
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "dodge") # [inserted into the dashboard]

# flip x an y axis with coord flip
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "dodge") +
  coord_flip() # [inserted into the dashboard]

# Or, position = "fill": percentage chart -- making it easy to compare proportions
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill")

# flip x and y axis with coord_flip
ggplot(mpg, aes(x = class, fill = drv)) +
  geom_bar(position = "fill") +
  coord_flip()

# Y mapping available: geom_bar(stat = "identity") 
####################################################
# if we have any value that represents the bar height as a variable, we can plot our bar height values to this variable 

## Example 1: count or frequency 
# preparing count table
class_count <- count(mpg, class) # count {dplyr}
class_count

ggplot(class_count, aes(x = n, y = class)) +
  geom_bar(stat = "identity") # Here y mapping needed, we now include n for our y variable

## Example 2: summary statistics (e.g., average) 
# calculating the average mpg across different cyl categories (4, 6, 8 cylinder categories)
# Let's working with the 'mtcars' dataset
mtcars
str(mtcars)
?mtcars

cyl_mpg <- mtcars %>% 
group_by(cyl) %>%
  summarise(avg_mpg = mean(mpg, na.rm = TRUE))
cyl_mpg

ggplot(cyl_mpg, aes(x = factor(cyl), y = avg_mpg)) +
  geom_bar(stat = "identity")

# calculating average mpg across different cyl categories and am (0 = automatic, 1 = manual)
avg_mpg <- mtcars %>%
  group_by(cyl, am) %>% #grouping by cyl and am
  summarise(mpg = mean(mpg, na.rm = TRUE))
avg_mpg

ggplot(avg_mpg, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge")

# more pleasing colors
ggplot(avg_mpg, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge", color = "grey40") +
  scale_fill_brewer(palette = "Pastel1")

# labeling grouped bars
ggplot(avg_mpg, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge", color = "grey40") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9))

ggplot(avg_mpg, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9),
            vjust = 1.5, color = "white")

## Example 3: any numeric variable in the dataset
ggplot(mtcars, aes(x = row.names(mtcars), y = mpg)) +
  geom_bar(stat = "identity")

# rotating the text
ggplot(mtcars, aes(x = row.names(mtcars), y = mpg)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5))

# rotating to make more readable
ggplot(mtcars, aes(x = row.names(mtcars), mpg)) +
  geom_bar(stat = "identity") +
  coord_flip()

# ordering bars
ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg)) +
  geom_bar(stat = "identity") +
  coord_flip()

# comparing mpg across all cars and color based on cyl
ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg, fill = factor(cyl))) +
  geom_bar(stat = "identity") +
  coord_flip()

# adding value markers
ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg, fill = factor(cyl))) +
  geom_bar(stat = "identity") +
  coord_flip()+
  geom_text(aes(label = mpg), nudge_y = 2)

ggplot(mtcars, aes(reorder(row.names(mtcars), mpg), mpg)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  geom_text(aes(label = mpg), nudge_y = -2, color = "white")


## Histogram and density plot: 
##  -- examine frequencies (or counts) of 
##    a numeric (or continuous) variable
###########################################

## basic histograms
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram() 

# changing bin width, outline and fill color
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") 

# adding mean line 
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") +
  geom_vline(xintercept = mean(mpg$hwy), color = "red", linetype = "dashed", size = 1) # [incerted into dashboard]

## comparing groups using fill
# overlaying histograms
ggplot(data = mpg, aes(x = hwy, fill = drv)) +
  geom_histogram(binwidth = 1.5, alpha = .5) 

# adding average lines for grouped data by drv
# calculating group means
compare_mean <- mpg %>%
  group_by(drv) %>%
  summarise(Mean = mean(hwy))

ggplot(data = mpg, aes(x = hwy, fill = drv)) +
  geom_histogram(binwidth = 1.5, alpha = .5) +
  geom_vline(data = compare_mean, aes(xintercept = Mean, color = drv),
             linetype = "twodash", size = 1)

# interweaving histograms
ggplot(data = mpg, aes(x = hwy, fill = drv)) +
  geom_histogram(binwidth = 1.5, position = "dodge") # [inserted into dashboard]

## comparing groups using faceting by drv
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") +
  facet_grid(factor(drv) ~ .)

# adding average lines
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") +
  geom_vline(data = compare_mean, aes(xintercept = Mean, color = drv),
             linetype = "dotted", size = 2) +
  facet_grid(factor(drv) ~ .)

## comparing groups using faceting by drv and cyl
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") +
  facet_grid(factor(drv) ~ factor(cyl)) # [inserted into dashboard]

# adding average lines
# calculating group means
compare_mean2 <- mpg %>%
  group_by(drv, cyl) %>%
  summarise(Mean = mean(hwy))

ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 1.5, color = "grey30", fill = "white") +
  geom_vline(data = compare_mean2, aes(xintercept = Mean, color = drv),
             linetype = "dotdash", size = 1.5) +
  facet_grid(factor(drv) ~ factor(cyl))

## density plots
ggplot(data = mpg, aes(x = hwy)) +
  geom_density()

ggplot(data = mpg, aes(x = hwy)) +
  geom_density(alpha = .2, fill = "red")

ggplot(data = mpg, aes(x = hwy, fill = drv)) +
  geom_density(alpha = .5) 

## overlap density & histogram
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram(aes(y = ..density..), binwidth = 1.5, color = "grey30", fill = "white") + 
  geom_density(alpha = .2, fill = "red") #[inserted into dashboard]
  


