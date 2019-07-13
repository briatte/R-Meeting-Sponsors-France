library(dplyr)

d <- "R-Meeting-Sponsors-France.tsv" %>% 
  readr::read_tsv(col_types = "iccccccccccii")

nrow(d) # 201 (v0.2)

# 10 conferences, 8--46 sponsors (except 2020, 1 sponsor for now)
group_by(d, year, event) %>% 
  tally

# 1--4 organisers
group_by(d, year, event) %>% 
  filter(organiser == 1) %>% 
  tally

# top sponsors by occurrence
group_by(d, sponsor, sponsor_sector) %>% 
  tally(sort = TRUE) %>% 
  filter(n >= 4) # %>% knitr::kable()

# sponsor sectors
group_by(d, sponsor_role) %>% 
  tally(sort = TRUE)

# sponsor types
group_by(d, sponsor_type) %>% 
  tally(sort = TRUE) %>% 
  filter(n >= 10)

# sponsor domains
t <- na.omit(d$sponsor_domain) %>% 
  strsplit(",") %>% 
  unlist %>% 
  as_tibble %>% # exported by `dplyr`, column named `value`
  group_by(value) %>% 
  tally(sort = TRUE)

nrow(t) # 20 different domains
filter(t, n > 5)

# have a nice day
