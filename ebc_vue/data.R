library(dplyr)

dat <- readRDS("./data/map_data_final.rds")
codes <- readr::read_csv("./data/codes.csv")

cat(
  jsonlite::toJSON(
    dat,
    auto_unbox = TRUE,
    dataframe = "rows",
    pretty = TRUE
  ),
  file="../ebc_vue/data/data.json"
)

geo <- unique(dat[,c("region","subregion")])
cat(
  sprintf(
"
export default function() {
  return %s
}
"
,d3r::d3_nest(geo)
  ),
  file="../ebc_vue/src/geofilters.js"
)

readr::read_csv("data/biomelabels.csv") %>%
  left_join(codes, by=c("mht" = "code")) %>%
  mutate(habitat = code_def, code=mht) %>%
  select(habitat, code, ecoregion) %>%
  {
    cat(
      sprintf(
"
export default function() {
  return %s
}
"
,d3r::d3_nest(., value_cols="code")
      ),
      file="../ebc_vue/src/habitatfilters.js"
    )    
  }
  
unique(dat[,c("int_group","Int_type")]) %>%
  left_join(codes, by=c("int_group"="code")) %>%
  mutate(group=code_def, group_code=int_group) %>%
  select(group, group_code, Int_type) %>%
  left_join(codes, by=c("Int_type"="code")) %>%
  mutate(type=code_def, type_code=Int_type) %>%
  select(group, group_code, type, type_code) %>%
  {
    cat(
      sprintf(
"
export default function() {
  return %s
}
"
,d3r::d3_nest(., value_cols=c("group_code","type_code"))
      ),
      file="../ebc_vue/src/interventionfilters.js"
    )    
  }


data_frame(outcome=unique(dat[,c("Outcome")])) %>%
  left_join(codes, by=c("outcome"="code")) %>%
  mutate(code=outcome, outcome=code_def) %>%
  unique() %>%
  select(outcome, code) %>%
  {
    cat(
      sprintf(
"
export default function() {
  return %s
}
"
,d3r::d3_nest(., value_cols="code")
      ),
      file="../ebc_vue/src/outcomefilters.js"
    )
  }


dat %>%
  select(int_group, Outcome, aid) %>%
  unique() %>%
  #group_by(int_group, Outcome, aid) %>%
  #do(head(.,1)) %>%
  count(int_group, Outcome, sort=TRUE)

library(d3hierR)
library(d3r)

dat %>%
  select(int_group, Outcome, aid) %>%
  unique() %>%
  #group_by(int_group, Outcome, aid) %>%
  #do(head(.,1)) %>%
  count(int_group, Outcome, sort=TRUE) %>%
  d3_nest(value_cols = "n") %>%
  tree(
    sizeField = "n", paddingOuter=15, clipText=TRUE,
    height=800, styleText = list("font-size" = "70%")
  )

dat %>%
  select(int_group,region, Study_country, aid) %>%
  unique() %>%
  count(int_group,region, Study_country, sort=TRUE) %>%
  d3_nest(value_cols = "n") %>%
  tree(
    sizeField = "n", paddingOuter=15, clipText=TRUE,
    tile = htmlwidgets::JS("d3.treemapBinary"),
    height=800, styleText = list("font-size" = "70%")
  )

dat %>%
  select(int_group,region, Study_country, aid) %>%
  unique() %>%
  count(int_group,region, Study_country, sort=TRUE) %>%
  d3_nest(value_cols = "n") %>%
  tree(
    sizeField = "n", paddingOuter=15, clipText=TRUE,
    tile = htmlwidgets::JS("d3.treemapSliceDice"),
    height=800, styleText = list("font-size" = "70%")
  )

dat %>%
  select(region, Study_country, aid) %>%
  unique() %>%
  count(region, Study_country, sort=TRUE) %>%
  d3_nest(value_cols = "n") %>%
  tree(
    sizeField = "n", paddingOuter=15, clipText=TRUE,
    height=800, styleText = list("font-size" = "70%")
  )


# how would we make network out of this
library(igraph)
ig <- dat %>%
  select(int_group, region, aid) %>%
  unique() %>%
  count(int_group, region, sort=TRUE) %>%
  {graph_from_data_frame(
    .,
    directed = FALSE
  )}


library(rpivotTable)
rp <- rpivotTable(
  dat,
  aggregatorName = "Count Unique Values",
  vals = "aid",
  rows = c("Int_type", "region"),
  cols = c("Outcome"), 
  subtotals = TRUE
)
