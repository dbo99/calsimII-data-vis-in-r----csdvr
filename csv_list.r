setwd("./csv")
# list CalSim dv .csv file name and name scenarios on each line
# use any number (32 scenarios is most tried - formatting challenges there - use no label functions)
# note column "ID" vs "id" - older WRIMS outputs "ID", newer"id" - need to match them below as necessary)
# for shasta raises, add `%>% adds44tos4()` to end of line

#csv0  <- read_csv ("filename.csv"   )  %>% mutate(scen = "nickname") %>% select(-id, -Timestep)
csv1  <- read_csv ("0_FO_04012018_b2fix.csv"   )  %>% mutate(scen = "baseline") %>% select(-id, -Timestep)
csv2  <- read_csv ("2_SHA_TF.csv"   )  %>% mutate(scen = "2_SHA_TF") %>% select(-ID, -Timestep) %>% adds44tos4()
csv3  <- read_csv ("3_SHA_SL_TF_NDD.csv"   )  %>% mutate(scen = "3_SHA_SL_TF_NDD") %>% select(-ID, -Timestep) %>% adds44tos4()
#csv4  <- read_csv ("4_SHA_TF_NDD.csv"   )  %>% mutate(scen = "4_SHA_TF_NDD") %>% select(-ID, -Timestep) %>% adds44tos4()
#csv5  <- read_csv ("5_SHA_SL_NDD.csv"   )  %>% mutate(scen = "5_SHA_SL_NDD") %>% select(-ID, -Timestep) %>% adds44tos4()
csv6  <- read_csv ("6_SL_NDD.csv"   )  %>% mutate(scen = "6_SL_NDD") %>% select(-ID, -Timestep)
#csv7  <- read_csv ("7_SL_TF_NDD.csv"   )  %>% mutate(scen = "7_SL_TF_NDD") %>% select(-ID, -Timestep)
#csv8  <- read_csv ("8_SHA_NDD.csv"   )  %>% mutate(scen = "8_SHA_NDD") %>% select(-ID, -Timestep) %>% adds44tos4()
#csv9  <- read_csv ("9_SHA_SL.csv"   )  %>% mutate(scen = "9_SHA_SL") %>% select(-ID, -Timestep) %>% adds44tos4()
#csv10 <- read_csv ("10_TF_NDD.csv"   )  %>% mutate(scen = "10_TF_NDD") %>% select(-ID, -Timestep)
#csv11 <- read_csv ("11_SL_TF.csv"   )  %>% mutate(scen = "11_SL_TF") %>% select(-ID, -Timestep)
#csv12 <- read_csv ("12_SHA_SL_TF.csv"   )  %>% mutate(scen = "12_SHA_SL_TF") %>% select(-ID, -Timestep )%>% adds44tos4()
csv13 <- read_csv ("omr_Act1only_min2k.csv"   )  %>% mutate(scen = "OMRAct1OnlyMin2k") %>% select(-id, -Timestep )%>% adds44tos4()
#csv14 <- read_csv ("omr_Act1only_min5k.csv"   )  %>% mutate(scen = "OMRAct1OnlyMin5k") %>% select(-id, -Timestep )%>% adds44tos4()


df_csv <- mget(ls(pattern="csv*")) %>%  bind_rows()  # recognizes above new csv# data.frames and combines into one
rm(list = ls()[grep("^csv", ls())])  #removes single csvs to unclutter (deletes everything starting with `csv`)
setwd('..')

# if just appending to df_csv to an already big list, can avoid re-reading in all with:

#df_csv_toadd <- read_csv("scenariofilename.csv") %>% mutate(scen = "newscenname") %>% select(-ID, -Timestep)
#df_csv <- rbind(df_csv, df_csv_toadd)




