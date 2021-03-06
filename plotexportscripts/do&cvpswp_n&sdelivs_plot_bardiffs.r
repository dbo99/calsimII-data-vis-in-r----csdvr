setwd(here()) 

### Ann sum ###


{dvs <- c( "c406", "del_cvp_total_n", "del_cvp_total_s", "del_swp_tot_n", "del_swp_tot_s")
  source("df_create.r")

  df_diff$dv <- factor(df_diff$dv_name, levels = c("Delta Outflow","CVP NOD", "CVP SOD", "SWP NOD", "SWP SOD"))
 #choose one
  
  #pb_mn_ann_perav_taf_d(df_diff) + 
  #pb_mn_ann_perav_taf_d_hlab(df_diff) +
  p <- pb_mn_ann_perav_taf_d_nolab_rank(df_diff) + 
  
  
  
  ggtitle("Mean Annual Delta Outflow and Project Delivery, Difference from Baseline\n82 CalSim years (Q5E)") +
  theme(plot.margin=grid::unit(c(6,6,6,6), "mm"))+ 
  #scale_color_manual(values=df_diff_cols) + scale_fill_manual(values=df_diff_cols) +
  theme(axis.title.x=element_blank(),axis.text.x=element_blank(), axis.ticks.x=element_blank())
  setwd(here("plots", "do&cvpswp_n&sdelivs_plot_bardiffs"))
  p
ggsave("do&cvpswp_n&sdelivs_plot_bardiffs.jpg", dpi = 300, width = 13.333, height = 7.5, units = "in") 

p <- ggplotly(p)
htmlwidgets::saveWidget(as_widget(p), paste0(paste(dvs,collapse="&"), "_mon_timeseries_taf.html"))
setwd(here())
setwd(here("plotexportscripts"))
}
