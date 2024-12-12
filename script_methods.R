## Script used during the undergrad course on Computational Methods applied to Education.
## Level: Bachelor on Physics Education.
## Federal University of Rio Grande do Sul
## Professor Matheus Monteiro Nascimento
## Update date: June 13, 2023


# Lesson 1 ------------------------------------------------------------------
## 1) Basic commands
## 2) Creating variables
## 3) Basic operations
## 4) Practice exercises

##Some basic commands:
print('Hello world') ## To run a line of code in the console, press Ctrl+Enter 

x <- 1
y <- 2
c <- x^2 + 3*y
c

m <- 350
a <- 0.2
F <- m*a
F

x <- c(1,2,3,4,5,6,7,8,9,10) ##When writing c() we are indicating that the created variable is a vector
y <- x^2 
y
plot(x,y)

##Using the operator ":":
1:10
3:8

##Creating a sequence from 5 to 30 with increments of 5 units:
x <- seq(5, 30, 5) 
x

##Creating repetitions:
a <- rep(4, 5) # Number 4 repeated 5 times
a

v <- rep("hi!", 10) # Text "hi!" repeated 10 times.
v

##Specific items using the function c() (concatenate):
a <- c(3, 45, 234, 2336)
a

b <- c(32, 9, 10, 888)
b

f <- c("blue", "pink", "black", "yellow")
f

##Combining vectors using the functions cbind() (combining vectors by column) or rbind (combining vectors by row):
x <- cbind(a, b)
x

y <- rbind(a,b)

##Creating matrices using the command matrix():
c(1:3, 8) #Row vector 1x4

matrix(c(1:3, 8), 2) #Matrix 2x2

##Operations with matrices/vectors:
A <- matrix(c(1,2,0,4),2)
B <- matrix(c(2,4,1,5),2)

dim(A) #Matrix dimension

A+B

A-B

B-5

A*B

3*B

B^2

##Vector functions:
v <- c(2, 5, 10, 11, 3)
v

max(v) #Getting the maximum value

min(v) #Minimum value

length(v) #Vector length

sum(v) #Sum of elements

cumsum(v) #Cumulative sum

prod(v) #Product of elements

cumprod(v) #Cumulative product

mean(v) #Mean

var(v) #Variance

sd(v) #Standard deviation

sqrt(var(v))

median(v) #Median

summary(v) #Descriptive statistics

sort(v) #Vector sorting

sort(v, decreasing = T)

##Practice exercises
#1) Build a 3x3 matrix with sequential numbers from 1 to 9.
#2) Build a 3x3 matrix with the number 2 repeated 9 times.
#3) Multiply the two matrices.
#4) In an experimental activity, Raskolnikov collected the following distance values, in cm,
#from a moving object in a time interval from 0 to 20 seconds. Measurements were always taken
#at the same time increment: y = c(0.00,2.26,3.59,4.82,6.00,7.15,8.29,9.41,10.52,11.62,12.71). Calculate the mean, median,
#variance, and standard deviation for this data set. Then, plot y as a function of time.



# Lesson 2 ------------------------------------------------------------------
## 1) Opening and exploring a data set
## 2) Working with the dplyr package
## 3) Practice exercises


#Enable an already installed package
library(dplyr)

#Call data set
data("mtcars")

#Exploring data using the $ command (works even without the dplyr package)
mean(mtcars$mpg)
max(mtcars$cyl)

#Summarizing cases
summarize(mtcars, mean=mean(mpg))
summarize(mtcars, max=max(cyl))

count(mtcars, cyl) #returns the frequency of cases in each category
count(mtcars, gear)

#Grouping cases
grouped <- group_by(mtcars, cyl) #Groups cases of a variable
summary <- summarize(grouped, mean=mean(mpg)) #Returns a value for grouped cases

mtcars %>% #Pipes are very useful for simplifying reading and programming 
  group_by(cyl) %>%
  summarize(mean=mean(mpg))

#Manipulate cases
mtcars %>%
  filter(mpg>20) #Filters only cases greater than a specific value

mtcars %>%
  distinct(gear) #Removes rows with duplicate values

mtcars %>%
  slice(10:15) #Selects specific rows

mtcars %>%
  slice_min(mpg, prop = 0.1) #Selects only rows with the lowest values

mtcars %>%
  slice_max(mpg, prop = 0.1) #Selects only rows with the highest values

mtcars %>%
  arrange(drat) #Sorts rows by the value of a column

mtcars %>%
  add_row(cyl=1,disp=3) #Adds a row (if no value is provided, NA's are inserted)

#Manipulate variables
mtcars %>%
  pull(wt) #Extracts column values as a vector

mtcars %>%
  select(mpg,wt) #Extracts columns from a table

mtcars %>%
  mutate(var=mpg/cyl) #Creates a new variable (same-size vectors)

mtcars %>% 
  rename(km_l=mpg) #Renames variable (column)

mtcars %>% #Rename categories using recode
  mutate(cylinders = recode(cyl, "4"='A',"6"='B', "8"='C'))


##Practice exercises
#Open the dataset available on Moodle. 
#1) Create a new variable with the average grade of each student for the semester. Know that tests
#are worth 70% and assignments 30%.
#2) Which students scored above 7 on average?
#3) Which students scored below 5 on average?
#4) Which group obtained a higher average score, M or F?



# Lesson 3 ------------------------------------------------------------------
## 1) Data Visualization
## 2) Working with the ggplot package
## 3) Practice Exercises

#Graphs with R's basic plotting
library(readr)
exemplo_notas <- read_delim("exemplo_notas.csv", #Opening example data
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

names(exemplo_notas)

plot(P1~P2, data=exemplo_notas) #Plotting grades in P1 and P2
plot(P1~P2, data=exemplo_notas,main="Prova 1 versus Prova 2", xlab="Prova 2", ylab = "Prova 1")
plot(P1~P2, data=exemplo_notas,main="Prova 1 versus Prova 2", xlab="Prova 2", ylab = "Prova 1",
     col="red")
plot(P1~P2, data=exemplo_notas,main="Prova 1 versus Prova 2", xlab="Prova 2", ylab = "Prova 1",
     col="red",pch="*")

#ggplot package
library(ggplot2)

ggplot(exemplo_notas) +
  geom_point(aes(P1,P2))

ggplot(exemplo_notas) +
  geom_point(aes(P1,P2)) +
  labs(title="Prova 1 versus Prova 2", x="Prova 2", y = "Prova 1")

ggplot(exemplo_notas) +
  geom_point(aes(P1,P2, color="red")) +
  labs(title="Prova 1 versus Prova 2", x="Prova 2", y = "Prova 1")

#Scatter plot: two numerical variables
data("mtcars")


ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point()


ggplot(mtcars, aes(x=wt, y=mpg)) + #Changing point shape and size
  geom_point(size=2, shape=15)

ggplot(mtcars, aes(x=wt, y=mpg)) + #Adding labels to the points
  geom_point() + 
  geom_text(label=rownames(mtcars))


ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() + 
  geom_smooth(method = lm) #Adding trend line to the plot

##Exercise
#1) Using the data from the last lesson, create a graph of P1 by P2 adding a trend line

ggplot(exemplo_notas, aes(x=P2, y=P1))+ 
  geom_point()+ 
  geom_smooth(method = lm)


#Boxplot: numerical variable on y and categorical on x

ggplot(mtcars)+ #Both numerical, unlike geom_point, doesn't work
  geom_boxplot(aes(x=cyl,y=mpg))

mtcars$cyl <- as.factor(mtcars$cyl) #Converting cyl to categorical variable

ggplot(mtcars)+
  geom_boxplot(aes(x=cyl,y=mpg))

##Changing line colors (color)
ggplot(mtcars)+ #Setting colors manually
  geom_boxplot(aes(x=cyl,y=mpg,color=cyl))+
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) 


ggplot(mtcars)+ #Using a color palette
  geom_boxplot(aes(x=cyl,y=mpg,color=cyl))+
  scale_color_brewer(palette="Dark2")

##Changing fill colors
ggplot(mtcars)+ #Setting colors manually
  geom_boxplot(aes(x=cyl,y=mpg,fill=cyl))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) 

ggplot(mtcars)+ #Using a color palette
  geom_boxplot(aes(x=cyl,y=mpg,fill=cyl))+
  scale_fill_brewer(palette="Dark2")

ggplot(mtcars)+ #Changing the theme of the plot
  geom_boxplot(aes(x=cyl,y=mpg,fill=cyl))+
  scale_fill_brewer(palette="Dark2")+
  theme_classic()


##Exercise:
#2) Using the data from the previous lesson, create a boxplot for the averages of men and women in the class. Add title and axis labels.
#3) Create the P1 and P2 plot with different colors for men and women. Add title and axis labels.
#4) Include trend lines for men and women in the graph from exercise 3.
#5) Insert student names in the graph from exercise 3.


# Lesson 4 ------------------------------------------------------------------
## 1) More graphs with ggplot
## 2) Practice Exercises

library(readr)
enem_2019_exemplo <- read_delim("enem_2019_exemplo.csv", 
                    delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                    encoding = "ISO-8859-1"), trim_ws = TRUE)
library(ggplot2)

#Histogram: a continuous variable

ggplot(enem_2019_exemplo)+
  geom_point(aes(x=NU_NOTA_CN,y=NU_NOTA_MT,color=TP_SEXO))+ 
  scale_color_manual(values=c("red","blue"))

ggplot(enem_2019_exemplo, aes(x=NU_IDADE))+ #Basic histogram
  geom_histogram()

ggplot(enem_2019_exemplo, aes(x=NU_IDADE))+ #binwidth changes the bar thickness
  geom_histogram(binwidth = 1)

ggplot(enem_2019_exemplo, aes(x=NU_IDADE))+ #Changing colors
  geom_histogram(binwidth = 1, color="red",fill="white")

ggplot(enem_2019_exemplo, aes(x=NU_IDADE))+ #Adding a vertical line at the mean value
  geom_histogram(binwidth = 1, color="red",fill="white")+
  geom_vline(aes(xintercept=mean(NU_IDADE)))
  
ggplot(enem_2019_exemplo, aes(x=NU_IDADE,color=TP_SEXO))+ #Separate histograms by gender
  geom_histogram(binwidth = 1, fill="white")

ggplot(enem_2019_exemplo, aes(x=NU_IDADE,color=TP_SEXO))+ #Overlaying histograms
  geom_histogram(binwidth = 1, fill="white",alpha=0.1, position="identity")


#Barplots: a continuous variable and a discrete one
library(dplyr)

tabela <- enem_2019_exemplo %>% #Create a table with a continuous and a discrete variable
  group_by(SG_UF_RESIDENCIA) %>%
  summarize(media=mean(NU_NOTA_CN))

ggplot(tabela, aes(x=SG_UF_RESIDENCIA, y=media))+ #Each bar indicates the mean of a state
  geom_bar(stat = "identity")

ggplot(tabela, aes(x=reorder(SG_UF_RESIDENCIA,+media), y=media))+ #Increasing order
  geom_bar(stat = "identity")

ggplot(tabela, aes(x=reorder(SG_UF_RESIDENCIA,+media), y=media))+ #Formatting
  geom_bar(stat = "identity",color="red", fill="pink")+
  labs(title = "Average in CN exam by state",x="States",y="Average in CN")+
  theme_classic()

ggplot(tabela, aes(x=reorder(SG_UF_RESIDENCIA,+media), y=media))+ #Adding text to the graph
  geom_bar(stat = "identity",color="red", fill="pink")+
  labs(title = "Average in CN exam by state",x="States",y="Average in CN")+
  theme_classic()+
  geom_text(aes(label=round(media,1)),vjust=1, color="black", size=3)

tabela <- enem_2019_exemplo %>% #Create table with a continuous variable and two discrete variables
  group_by(SG_UF_RESIDENCIA,TP_SEXO) %>%
  summarize(media=mean(NU_NOTA_CN))

ggplot(tabela, aes(x=reorder(SG_UF_RESIDENCIA,+media), y=media,fill=TP_SEXO))+ #Separate bars by gender
  geom_bar(stat = "identity",position = position_dodge())

ggplot(tabela, aes(x=reorder(SG_UF_RESIDENCIA,+media), y=media,fill=TP_SEXO))+ #Formatting
  geom_bar(stat = "identity",position = position_dodge())+
  labs(title = "Average in CN exam by state and gender",x="States",y="Average in CN",fill="Gender")+
  theme_classic()


##Lesson 4 Exercises:
#1) With the 2019 ENEM data available on Moodle, create a histogram of students separated by gender, but selecting only candidates aged between 14 and 25.
#2) Create a bar chart for the average in the CN exam by the father's education level (Q001). The meaning of each category of the Q001 variable is:
#A Never studied.
#B Did not complete the 4th grade/5th year of Elementary School.
#C Completed the 4th grade/5th year, but did not complete the 8th grade/9th year of Elementary School.
#D Completed the 8th grade/9th year of Elementary School, but did not complete High School.
#E Completed High School, but did not complete College.
#F Completed College, but did not complete Graduate School.
#G Completed Graduate School.
#H Don't know.
#3) Recreate the graph from question 2 separating the students by gender. Format the graph and save it as jpeg.
#4) Knowing that we use both boxplots and barplots for the same type of data, recreate the graph from question 2 changing the geometry to boxplot. Format the graph and save it as jpeg. 
#5) Discuss what you can conclude from the result of question 4.


# Lesson 5 ------------------------------------------------------------------
##1) Data analysis: comparing means
##2) Practice Exercises

#T-test: for two independent samples
library(readr)
exemplo_notas <- read_delim("exemplo_notas.csv", #Opening example data
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

library(dplyr)

group_by(exemplo_notas, Sexo) %>% #Grouping students by gender and summarizing mean in P1
  summarise(
    count = n(),
    mean = mean(P1, na.rm = TRUE),
    sd = sd(P1, na.rm = TRUE))


library(ggplot2)

ggplot(exemplo_notas, aes(y=P1,x=Sexo,fill=Sexo))+ #Visualizing with a boxplot
  geom_boxplot()+
  scale_fill_manual(values = c("green", "gray"))+
  theme_classic()

with(exemplo_notas, shapiro.test(P1[Sexo == "M"])) #Normality test (p>0.05 assumes normal distribution)
with(exemplo_notas, shapiro.test(P1[Sexo == "F"]))

t.test(P1 ~ Sexo, data = exemplo_notas, var.equal = TRUE) #Test for difference in means



##Exercise
#1) Test the difference in the means of CN exam between men and women in the 2019 ENEM exam
enem_2019_exemplo <- read_delim("enem_2019_exemplo.csv", 
                                delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                                                    encoding = "ISO-8859-1"), trim_ws = TRUE)

ggplot(enem_2019_exemplo, aes(y=NU_NOTA_CN,x=TP_SEXO,fill=TP_SEXO))+ 
  geom_boxplot()+
  scale_fill_manual(values = c("green", "gray"))+
  theme_classic()

wilcox.test(NU_NOTA_CN ~ TP_SEXO, data = enem_2019_exemplo, var.equal = TRUE) #When normality is not guaranteed, use Wilcox instead of t

#ANOVA: compares means between several groups

ggplot(enem_2019_exemplo, aes(x=reorder(Q001,+NU_NOTA_CN),y=NU_NOTA_CN))+ 
  geom_boxplot()+
  theme_classic()

aov(NU_NOTA_CN ~ Q001, data = enem_2019_exemplo)
summary(aov(NU_NOTA_CN ~ Q001, data = enem_2019_exemplo))
TukeyHSD(aov(NU_NOTA_CN ~ Q001, data = enem_2019_exemplo))

##Exercise
#2) Create a bar chart for the averages in the CN exam (NU_NOTA_CN) by the level of education of the students' mothers. Format the graph and save it as jpeg.
#3) Perform a test to check if there is a significant difference in the average CN score between students who have completed High School and those who have completed College.
#4) Check if the distribution of grades in the CN exam is normal for both men and women in the 2019 ENEM exam.










