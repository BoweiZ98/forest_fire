# packages
library('tidyverse')

# Import Data
df_raw = read_csv('../data/forest_fire.csv')

# preprocessing month and day
months <- c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
days <- c("mon", "tue", "wed", "thu", "fri", "sat", "sun")

df <- df_raw %>%
  dplyr::select(-id) %>%
  mutate(month = case_when(
    month %in% months ~ match(month, months)
  )) %>%
  mutate(day = case_when(
    day %in% days ~ match(day, days)
  ))

df$month <- factor(df$month,
                   levels = 1:12,
                   labels = months)
df$day <- factor(df$day,
                 levels = 1:7,
                 labels = days)

# Change X and Y into factor
df$X <- as.factor(df$X)
df$Y <- as.factor(df$Y)

# dataframe for logistic regression
# change the outcome to binary
df <- df %>% 
  mutate(area_size = case_when(
    area == 0.1 ~ 0,
    TRUE ~ 1
  ))

# remove everything in the environment except 'df'
rm(list = ls()[!ls() %in% "df"])


