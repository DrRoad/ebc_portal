library(dplyr)
library(tidyr)
library(readr)

profor <- readRDS("../../profor/map_data_final.rds")

# remove row 55089 which is a blank row
#   until this row is removed from the RDS or other source data
profor <- profor[-55089,]

articles <- read.csv(
  "../../profor/Data_Final_PROFOR.csv",
  stringsAsFactors = FALSE
)

codes <- read.csv(
  "../../profor/codes.csv",
  stringsAsFactors = FALSE
)
codes_int <- codes[,1:3]
codes_out <- codes[,4:6]

unique_col <- colnames(profor)[colnames(profor) %in% colnames(articles)]

### check country names for matches with topo ----
countries <- read.delim(
  "https://gist.githubusercontent.com/mbostock/4090846/raw/07e73f3c2d21558489604a0bc434b3a5cf41a867/world-country-names.tsv"
)

profor %>%
  group_by(Study_country.x) %>%
  summarize(n = n()) %>%
  left_join(countries, by = c("Study_country.x"="name")) %>%
  filter(is.na(id))

# use to verify in JavaScript
profor %>%
  group_by(Study_country.x, id) %>%
  summarize(n = length(unique(aid))) %>%
  arrange(desc(n))

# manual adjust NA
profor$country <- profor$Study_country.x
replace_country <- function(orig, repl) {
  profor[which(profor$country==orig), "country"] <- repl
  profor
}
profor <- replace_country("Bolivia", "Bolivia, Plurinational State of")
profor <- replace_country("Congo, The Democratic Republic Of The", "Congo, the Democratic Republic of the")
#cote de ivorie profor <- replace_country("","")
profor <- replace_country("Iran, Islamic Republic Of","Iran, Islamic Republic of")
profor <- replace_country("Saint Vincent And The Grenadines","Saint Vincent and the Grenadines")
profor <- replace_country("Taiwan, Province Of China","Taiwan, Province of China")
profor <- replace_country("Tanzania, United Republic Of","Tanzania, United Republic of")
profor <- replace_country("Tanzania","Tanzania, United Republic of")
profor <- replace_country("Venezuela", "Venezuela, Bolivarian Republic of")

profor <- profor %>%
  left_join(countries, by = c("country"="name")) %>%
  select(-country)


get_first <- function(row) {
  head(row,1)
}

profor %>%
  group_by(aid) %>%
  summarize(
    geo = list(unique(tibble(
      Study_country.x,
      id,
      region,
      subregion
    ))),
    outcome = list(unique(tibble(
      Out_type.inc_con,
      Out_type.cap_asset,
      Indicators,
      Outcome.data_type,
      Outcome.direction,
      Outcome.direction_notes,
      Out_subtype,
      Out_type_assigned
    ))),
    intervention = list(unique(tibble(
      Int_type
    ))),
    habitat = list(unique(tibble(
      Biome.
    ))),
    comparator = list(unique(tibble(
      Comps_type
    )))
  ) %>%
  ungroup() %>%
  # join back columns with one value per articl
  inner_join(
    profor  %>%
      select(
        # the following will be summarized so that
        #  we will have one row for each article
        # remove geographic columns
        -Study_country.x, -id, -region, -subregion,
        # remove outcome columns
        -Out_type.inc_con,
        -Out_type.cap_asset,
        -Indicators,
        -Outcome.data_type,
        -Outcome.direction,
        -Outcome.direction_notes,
        -Out_subtype,
        -Out_type_assigned,
        # remove intervention 
        -Int_type,
        # remove habitat/biome
        -Biome.,
        # remove comparator
        -Comps_type
      ) %>%
      group_by(aid) %>%
      summarise_all(funs(get_first)) %>%
      ungroup(),
    by=c("aid"="aid")
  ) %>%
  rename(study = Study_type) %>%
  select(
    aid, Authors, Pub_year, geo, outcome, intervention, study,
    everything()
  ) %>%
  {
    colnames(.) <- gsub(x=colnames(.), pattern="\\.", replacement="_")
    .
  } %>%
  jsonlite::toJSON(dataframe="rows", na="string") %>%
  cat(file="../../ebc_vue/static/data_profor.json")


profor[,unique_col] %>%
  group_by(aid) %>%
  summarise_all(funs(get_first)) %>%
  ungroup() %>%
  jsonlite::toJSON(dataframe="rows") %>%
  cat(file="../profor/static/articles_profor.json")



unique(profor[,c("region","subregion")]) %>%
{
  bind_rows(
    data_frame(
      region = c("NA","NA"),
      subregion = c(NA,"NA")
    ),
    .
  ) 
} %>%
{
  bind_rows(
    data_frame(
      region = .$region
    ),
    .
  )
} %>%
  arrange(region, subregion) %>%
  mutate(id = paste0("geo",1:n())) %>%  
  {  
    cat(
      sprintf(
        "
        export default function() {
        var data = %s;
        data.name = 'Geo';
        data.id = 'geo0'
        return data;
        }
        "
        ,d3r::d3_nest(., value_cols = "id")
      ),
      file="../../profor/static/geofilters.js"
    )
  }

profor %>%
  select(Biome.) %>%
  unique() %>%
  left_join(codes, by=c("Biome." = "code")) %>%
  mutate(habitat = unlist(lapply(code_def,function(x){strsplit(x,"-")[[1]][1]}))) %>%
  mutate(ecoregion = unlist(lapply(code_def,function(x){strsplit(x,"-")[[1]][2]}))) %>%
  rename(code = Biome.) %>%
  select(habitat, ecoregion, code ) %>%
  {
    bind_rows(
      data_frame(
        habitat = c("NA","NA"), 
        ecoregion = c("NA","NA"),
        code = "NA"
      ),
      .
    )
  } %>%
  {
    bind_rows(
      data_frame(
        habitat = .$habitat
      ),
      .
    )
  } %>%
  arrange(desc(habitat), ecoregion) %>%
  # all terrestrial so remove this layer
  select(-habitat) %>%
  # only need one NA since removing top layer
  na.omit() %>%
  unique() %>%
  mutate(id = paste0("habitat",1:n())) %>%
  {
    cat(
      sprintf(
"
export default function() {
  var data = %s;
  data.id = 'habitat0';
  data.name = 'Habitat';
  return data;
}
"
        ,d3r::d3_nest(., value_cols=c("code","id"))
      ),
      file="../../ebc_vue/src/profor/habitatfilters.js"
    )    
  }



profor %>%
  select(Int_type) %>%
  unique() %>%
  left_join(codes_int, by=c("Int_type"="Int_type")) %>%
  mutate(group=Int_group, type_code = Int_type, type = Int_label) %>%
  select(group, type, type_code) %>%
  #{
  #  bind_rows(
  #    data_frame(
  #      group = "NA",
  #      type = c(NA, "NA"),
  #      type_code = c(NA, "NA")
  #    ),
  #    .
  #  )
  #} %>%
  {
    bind_rows(
      data_frame(
        group = .$group
      ),
      .
    )
  } %>%
  # make group factor for PRIME order
  mutate(group = factor(group, levels = c("Productivity","Rights","Investments","Markets","Ecosystems"), ordered=TRUE)) %>%
  arrange(group, type)  %>%
  mutate(id = paste0("intervention",1:n())) %>%
  {
    cat(
      sprintf(
"
export default function() {
  var data = %s;
  data.id = 'intervention0';
  data.name = 'Intervention';
  return data;
}
"
        ,d3r::d3_nest(., value_cols=c("type_code","id"))
      ),
      file="../../ebc_vue/src/profor/interventionfilters.js"
    )    
  }



# debug missing outcome that I think is from "fin"
profor %>%
  group_by(aid) %>%
  summarize(
    n = length(unique(Out_subtype)),
    outcome = paste0(unique(Out_subtype), collapse=",")
  ) %>%
  filter(grepl(x=outcome, pattern="(fin)"))

# assume for now fin should be fin_cap, so make change in codes_out
codes_out[which(codes_out$Out_type=="fin_cap"),"Out_type"] <- "fin"

profor %>%
  select(Out_subtype) %>%
  unique() %>%
  left_join(codes_out, by=c("Out_subtype"="Out_type")) %>%
  rename(code=Out_subtype, outcome=Out_label) %>%
  unique() %>%
  select(out_group, outcome, code) %>%
  {
    bind_rows(
      na.omit(.),
      data_frame(
        out_group = "NA",
        outcome = c(NA, "NA"),
        code = "NA"
      )
    )
  } %>%
  mutate(id=paste0("outcome",1:n())) %>%
  #select(outcome, code) %>%
  {
    cat(
      sprintf(
"
export default function() {
  var data = %s;
  data.id = 'outcome0'
  data.name = 'Outcome'
  return data;
}
"
        ,d3r::d3_nest(., value_cols=c("code","id"))
      ),
      file="../../ebc_vue/src/profor/outcomefilters.js"
    )
  }

# test outcomes
profor %>%
  group_by(Out_subtype, subregion, Study_country.x) %>%
  summarize(n = length(unique(aid)))
profor %>%
  select(Out_subtype) %>%
  unique() %>%
  left_join(codes_out, by=c("Out_subtype" = "Out_type"))
profor %>%
  left_join(codes_out, by=c("Out_subtype" = "Out_type")) %>%
  group_by(Out_label, subregion, Study_country.x) %>%
  summarize(n = length(unique(aid)))

colnames(codes_int) <- c("code", "code_def", "group")
colnames(codes_out) <- c("code", "code_def", "group")
codes_hab <- profor %>%
  select(Biome.) %>%
  unique() %>%
  left_join(codes, by=c("Biome." = "code"))
colnames(codes_hab) <- c("code", "code_def")

# from email
codes_study <- data.frame(
  code = c("exp", "non_exp", "quas_exp", "imp_ev", "non_sys_rev", "sys_rev", "NA"),
  code_def = c("Experimental", "Non-Experimental", "Quasi-experimental", "Impact Evaluation", "Non-systematic review", "Systematic review/map", "Unknown"),
  stringsAsFactors = FALSE
)

codes_comp = data.frame(
  code = c("ba", "between", "cont", "none", "other", "pa", "punc", "spat"),
  code_def = c("Before/after", "Between groups", "Continuous time scale", "None", "Other", "Presence/absence of the exposure", "Puncturated time scale", "Spatial comparisons (e.g. distance)"),
  stringsAsFactors = FALSE
)

bind_rows(codes_int, codes_out, codes_hab, codes_study, codes_comp) %>%
  {
    cat(
      sprintf(
"
export default function() {
  var data = %s;
  return data;
}
",
        jsonlite::toJSON(., dataframe="rows")
      ),
      file = "../../profor2/src/codes.js"
    )
  }


codes_study %>%
  rename(name = code_def) %>%
  bind_rows(
    data_frame(
      name = "NA",
      code = "NA"
    )
  ) %>%
  mutate(id=paste0("study",1:n())) %>%
  mutate(colname="study") %>%
  #select(outcome, code) %>%
  {
    cat(
      sprintf(
"
export default function() {
  var data = {
    id: 'study0',
    name: 'Study Type',
    children: %s
  };
  return data;
}
"
        ,jsonlite::toJSON(., dataframe="rows")
      ),
      file="../../profor2/src/studyfilters.js"
    )
  }


codes_comp %>%
  rename(name = code_def) %>%
  bind_rows(
    data_frame(
      name = "NA",
      code = "NA"
    )
  ) %>%
  mutate(id=paste0("comparator",1:n())) %>%
  mutate(colname="comparator") %>%
  #select(outcome, code) %>%
  {
    cat(
      sprintf(
        "
export default function() {
  var data = {
    id: 'comparator0',
    name: 'Comparator',
    children: %s
  };
  return data;
}
"
,jsonlite::toJSON(., dataframe="rows")
      ),
file="../../profor2/src/compfilters.js"
    )
  }





## get a file ready to try with upset ----
profor$lgcl <- 1
upset_int <- spread(
  profor %>% select(aid, Int_type, lgcl) %>% unique(),
  Int_type, lgcl,
  fill = 0
)

upset_int %>%
  write.csv("../../profor2/experiments/upset_int.csv", row.names=FALSE)

# json meta file
list(
  "file"= "https://cdn.rawgit.com/timelyportfolio/profor2/ec530764/experiments/upset_int.csv",
  "name"= "Profor Intervention Type",
  "header"= 0,
  "separator"= ",",
  "skip"= 0,
  "meta"= list(
    list( "type"= "id", "index"= 0, "name"= "aid" )
  ),
  "sets"= list(
    list( "format"= "binary", "start"= 1, "end"= ncol(upset_int) - 1 )
  ),
  "author"= "profor",
  "description"= "profor evidence map"
) %>%
  {
    cat(
      jsonlite::toJSON(., auto_unbox=TRUE, pretty=TRUE),
      file = "../../profor2/experiments/upset_int.json"
    )
  }
