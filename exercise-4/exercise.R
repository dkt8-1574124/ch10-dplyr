# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`


# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the
# columns represent)
dim(flights)
#print(paste(nrow(flights), "rows"))
#print(paste(ncol(flights), "columns"))
colnames(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- mutate(flights, change = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, desc(change))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- mutate(flights, change = arr_delay - dep_delay) %>%
  arrange(desc(change))


# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$change)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
# WRONG summarise(flights, average = mean(flights$change), na.rm = TRUE)
mean(flights$change, na.rm = TRUE) # gained 5 minutes

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
df_SEA <- filter(flights, dest == "SEA") %>%
          select(origin, dest, change)

# On average, did flights to SeaTac gain or loose time?
mean(df_SEA$change, na.rm = TRUE) #gained 11 minutes

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
#summarise(flights, origin == "JFK") %>%
#filter(dest == "SEA") %>%
#select(average == mean(flights$change),
#       min == min(flights$change),
#       max == max(flights$change))
filter(flights, origin == "JFK" , dest == "SEA") %>%
summarise(
  average = mean(flights$change, na.rm = TRUE),
  min = min(flights$air_time, na.rm = TRUE),
  max = max(flights$air_time, na.rm = TRUE)
)

