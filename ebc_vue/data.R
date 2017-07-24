library(dplyr)

dat <- readRDS("./data/map_data_final.rds")

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
