library(naniar)
library(tidyverse)
library(skimr)
library(superheat)
library(ggalluvial)
library(corrr)

data("riskfactors")


# 簡便なデータ形式の調べ方
riskfactors %>% 
  dplyr::glimpse()


# データのスキミング

riskfactors %>% 
  skimr::skim()



# 欠損値の集計と可視化

riskfactors %>% 
  naniar::miss_var_summary() %>% 
  filter(n_miss > 0)

riskfactors %>% 
  naniar::gg_miss_var()


riskfactors %>% 
  naniar::gg_miss_var(facet = health_general, 
                      show_pct = TRUE)

riskfactors %>% 
  naniar::gg_miss_upset()


# UpSet Plot (Lex & Gehlenborg, 201?, Nature Methods)


# 欠損パターンの可視化



riskfactors %>% 
  select_if(is.numeric) %>% t() %>% 
  superheat::superheat(scale = TRUE, 
                       heat.na.col = "white",
                       row.dendrogram = TRUE,
                       col.dendrogram = TRUE)

# riskfactors %>% 
#   select_if(negate())


# Alluvial diagram 
# 
# riskfactors %>% 
#   select(sex, smoke_100, drink_any, health_general) %>% 
#   group_by(sex, smoke_100, drink_any, health_general) %>% 
#   summarise(Freq = n()) %>% 
#   ggplot()

# 相関係数行列

riskfactors %>% 
  select_if(is.numeric) %>% 
  corrr::correlate() %>% 
  corrr::shave() %>% 
  corrr::fashion() %>% 
  knitr::kable()


# riskfactors %>% 
#   select_if(is.numeric) %>% 
#   corrr::correlate() %>% 
#   corrr::stretch() %>% 
#   ggplot() + 
#   geom_tile(aes(x =x, y =y, fill))


# 相関ネットワーク

riskfactors %>% 
  select_if(is.numeric) %>% 
  corrr::correlate() %>% 
  corrr::network_plot(min_cor = 0.1, 
                      colours = c("skyblue", "white", "indianred2"))

# 
