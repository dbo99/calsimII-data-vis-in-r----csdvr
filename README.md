# **csdvr**
 calsim data visualization (post-processor) in R | 
 version 1.0_8.10.2018 | 
 analyze calsim output for large numbers of variables or scenarios | 
 export report or presentation ready plot images (jpgs, pdfs, etc) or interactive html plots  

   key file  | use
------------ | -------------
`csv_list.r` | list csv file names and associate unique scenario nickname
`scen_facts.r` | give an order to plot scenarios in (ie left to right data/top to bottom legend)
`control.r` | main user interface - actually read-in data and analyze or batch export plots
`plotexport.r` | select which plot scripts to run for export (wait 1-2 minutes for a huge set or need some instantly?)
`fun_defs.r` | data summary/plotting function definitions - add new ones here

## Uses ##

- WRIMS2 CalSim decision variable ("DV") output in `.csv` format.
   If csv file(s) needed, enter in 2018 or later versions of WRIMS2's GUI's `Dvar DSS file:`'s field: `outputfilename.csv` instead of: `outputfilename.dss` (both will be created using `.csv` alone). WRIMS2 is free from California Dept. of Water Resources, see link at bottom for request - currently distrubuted via email list
- R, and R libraries specified in `libs.r`. Probably relies most on `dplyr` and `ggplot2` of the [`tidyverse`](https://www.tidyverse.org/)

## Steps ##

**Download** `csdvr_date.zip` (~15 mb: ~30 kb of scripts, ~15 mb of sample plots)
   https://github.com/dbo99/csdvr----calsimII-data-vis-in-r/blob/master/csdvr_aug18.zip

**Drop** your calsim csvs in `csv` folder (or save them there initially from WRIMS2).

**Open RStudio and files** by clicking on `control.r`, then open  `csv_list.r` and `scen_facts.r`

**Point to files and ID scenarios** in **`csv_list.r`**: enter each csv file name (eg `040812_bo_y1a1.csv`) and give unique nickname (eg `Scen1_Y1A1`) for each

**Specify plotting order of scenarios** (groupings to facilitate data vis): in **`scenfacts.r`** enter same nicknames in user-defined order: top to bottom in **`scenfacts.r`** produces top to bottom order in plot legend. Nickname spelling in **`csv_list.r`** must match  in **`scen_facts.r`**

`control.r`  | action
------------ | -------------
`1` | **read in libraries,  functions, and csv data** (do first then sparingly as ~1/6 min read-in time per scenario) (~0.5 gb `.csv` each) (option to append in **`csv._list.r`**). 2a & 2b need 1 run first.
`2a` | **generate plots in batches** with pre-defined templates for common DVs of interest -- call scripts of plots
`2b` | **generate individual data summaries** (ie tabular as `tibble`,`.csv`) **or individual plots** for any DVs of interest by searching for DVs here and by running individual functions listed below this block (~80)

### notes ###
- above steps will export batches of plots. functions are listed below only for reference and new analysis.
- assumes DV name familiarity, eg Folsom Lake is `s8`. If not consult `.wresl` or `.dss` files.  `varcodes.csv` identifies some dvname-commonname pairs, add more as desired. By defaults plots label the `df$dv`, the actual CalSim name, not the `df$dv_name`, the common name (development of a switch is in progress)
- save new finished plot scripts in `plotexportscripts` folder to add to collection of templates & add folder of file name
- currently assumes all scenarios are under same climate scenario (tied to wyt.csv - adjustment needed to accomodate more for any water  year type functions - other functions still applicable as is if multiple climate scenarios used) (sample's uses Q5 Early Long Term)
- default plot size is widescreen to exactly fit default `.pptx`. To change, search and replace all (from Ctrl-F) `width = 13.333, height = 7.5`, to desired dimensions, eg `width = 10, height = 6` , same with desired filetype, eg `.jpg`, `.pdf`, `.html`)
- accepts either CalSimII or CalSim 3.0 output, but set up currently for CalSimII's time range only
- currently lacks any diagnostics on "controls" - hoping to add directly in `.wresl` files for ease in csdvr, other post-processors, in future
- currently lacks any geospatial ability
  
  Access CalSim benchmark studies and contact info for WRIMS software:
  
  https://water.ca.gov/Library/Modeling-and-Analysis/Central-Valley-models-and-tools/CalSim-2
  

#  Data Summary Functions
#### select DVs and run `df_create.r` to create `df` and `df_diff` `data.frame`s ####
- use `df` and `df_diff` interchangeably
- add `%>% write.csv("processedDV(s)ofinterest.csv")` after any to export `processedDV(s)ofinterest.csv` to working directory

### annual avgs  ###
   function  | for
------------ | -------------
mn_ann_perav_taf(df) |  mean annual for period avg (flow/delivery) in taf (if nothing: makes sure dv not storage)
eg mn_ann_perav_taf(df_diff) |  mean annual diff. rel. to baseline for period avg (flow/delivery) in taf
md_ann_perav_taf() |  median annual flow/delivery in taf
md_ann_perav_taf(df_diff) |  median annual diff. rel. to baseline for flow/delivery in taf
mn_ann_eomstor_taf(df) | mean annual end of month storage (if nothing: makes sure a storage term selected)
mn_ann_eomstor_taf(df_diff) | mean annual diff. rel. to baseline for end of month storage (if nothing: makes sure a storage term selected)
mn_ann_perav_native(df) | mean annual flow/delivery in calsim native units
md_ann_perav_native(df) | median annual flow/delivery in calsim native units

### wyt avgs ###
   function  | for
------------ | -------------
mn_ann_scwyt_perav_taf(df) | mean annual flow/delivery total by sacramento year type in taf
mn_ann_scwyt_perav_taf(df_diff) | mean annual difference rel. to baseline for flow/delivery total by sacramento year type in taf
mn_ann_perav_sjwyt_taf(df) | mean annual flow/delivery total by san joaquin year type in taf
mn_ann_perav_sjwyt_taf(df_diff)| meann annual flow/delivery total by san joaquin year type in taf

### global mins and maxs ###
   function  | for
------------ | -------------
max_mon_native(df) | maximum monthly value of all months
min_mon_native(df) | minimum monthly value of all months

### mean end of may, end of september storage ###
   function  | for
------------ | -------------
eo_may_stor_taf(df) | mean end of may storage
eo_sep_stor_taf(df) | mean end of septemeber storage
eo_may_stor_taf(df_diff) | mean difference relative to baseline for mean end of may storage
eo_sep_stor_taf(df_diff) | mean difference relative to baseline for mean end of septemeber storage

### find timesteps - for single DV only! ### 
   function  | for
------------ | -------------
showtstepsallscensunder(df, 800) | shows all time steps all scenarios are under ("find first month all under x")
showtstepsallscensover(df, 10) | shows all time steps all scenarios are over

### Period of Record mean, total ###
   function  | for
------------ | -------------
mn984_taf(df) | mean monthly value
sum984_taf(df) | sum of all months
  
#  Plotting Functions #
#### select DVs and run `df_create.r` to create `df` and `df_diff` `data.frame`s ####
- apply function with suffix *`_d`* (adds appropriate "[difference]" on axis label) on `data.frame` `df_diff` for difference plots (ie `df` and `df_diff` not used interchangeably as in above data summary functions)

## bar plots - annual means and medians ## 
### pb - plot bars - annual mean  ###
   function  | for
------------ | -------------
pb_mn_ann_perav_taf(df) |   bars of mean annuals with vertical labels (good for many scenarios)
pb_mn_ann_perav_taf_nolab(df) | bars of mean annuals without labels
pb_mn_ann_perav_taf_nolab_rank(df) | bar of mean annuals without labels, ranked highest to lowest left to right
pb_mn_ann_perav_taf_hlab(df) | bars of mean annuals with horizontal labels (good for few scenarios)
pb_md_ann_perav_taf(df) | bars of annual medians with vertical labels 

### pb - plot bars - annual mean by wyt ###
   function  | for
------------ | -------------
pb_mn_scwyt_perav_taf(df) | bars of mean annual flow/delivery total by sacramento year type (feb-jan in calsim)
pb_mn_scwyt_perav_taf_nolab(df) | label-less bars of mean annual flow/delivery total by sacramento year type (feb-jan in calsim)
pb_mn_scwyt2_perav_taf(df) | bars of mean annual flow/delivery total by sacramento year type in taf (coerced to oct-sep)
pb_mn_sjwyt_perav_taf(df) | bars of mean annual flow/delivery total by san joaquin year type (feb-jan in calsim)

### pb - plot pars - monthly mean ###
   function  | for
------------ | -------------
pb_mn_eomay_stor_taf(df) | bars of mean end of may storage
pb_mn_eosep_stor_taf(df) | bars of mean end of september storage

### pb - plot bars - annual mean differences   ###
   function  | for
------------ | -------------
pb_mn_ann_perav_taf_d(df_diff) | difference bars of mean annuals with vertical labels (good for many scenarios)
pb_mn_ann_perav_taf_d_hlab(df_diff) | difference bars of mean annuals with horizontal labels (good for few scenarios)
pb_md_ann_perav_taf_d(df_diff) | difference bars of annual medians with vertical labels 
pb_mn_ann_perav_taf_d_nolab_rank(df_diff) | label-less difference bars of mean annuals without labels, ranked highest to lowest left to right (good for very many scenarios)

### pb - plot bars - annual mean by wyt differences ###
   function  | for
------------ | -------------
pb_mn_scwyt_perav_taf_d(df_diff)| difference bars of mean annual flow/delivery total by sacramento year type (feb-jan in calsim)
pb_mn_scwyt_perav_taf_d_nolab(df_diff) | label-less difference bars of mean annual flow/delivery total by sacramento year type (feb-jan in calsim)
pb_mn_scwyt_perav_taf_d_hlab(df_diff) | horizontally labeled difference bars of mean annual flow/delivery total by sacramento year type (feb-jan in calsim)
pb_mn_scwyt2_perav_taf_d(df_diff) | difference bars of mean annual flow/delivery total by sacramento year type in taf (coerced to oct-sep)
pb_mn_sjwyt_perav_taf_d(df_diff) | difference bars of mean annual flow/delivery total by san joaquin year type (feb-jan in calsim)

### month-specific mean difference ###
   function  | for
------------ | -------------
pb_eomay_stor_taf_d(df_diff)  | difference bars of mean end of may storage
pb_eosep_stor_taf_d(df_diff) | difference bars of mean end of september storage

## bar plots - all years - ranked by water year type showing overall and wyt means ## 
   function  | for
------------ | -------------
pb_ann_fjwysum_scwyt_taf(df) | ranked bars of feb-jan totals by sacramento water year type
pb_ann_fjwysum_sjwyt_taf(df) | ranked bars of feb-jan totals by san joaquin water year type
pb_ann_fjwysum_scwyt_taf_d(df_diff) | ranked difference bars of feb-jan totals by sacramento water year type
pb_ann_fjwysum_sjwyt_taf_d(df_diff) | ranked difference bars of feb-jan totals by san joaquin water year type
pb_eomay_stor_scwyt_taf(df) | ranked bars of end of may storages by sacramento water year type
pb_eosep_stor_scwyt_taf(df) | ranked bars of end of september storages by sacramento water year type
pb_eomay_stor_scwyt_taf_d(df_diff) | ranked difference bars of end of may storages by sacramento water year type
pb_eosep_stor_scwyt_taf_d(df_diff) | ranked difference bars of end of may storages by sacramento water year type

## line plots - monthly and annual probability of exceedance ## 

### monthly - line ### 
   function  | for
------------ | -------------
p_mon_excd_taf(df) |   monthly exceedance in taf
p_mon_excd2_taf(df) |  monthly exceedance in taf style 2 (plot for each dv)
p_mon_excd_cfs(df) |   monthly exceedance in cfs
p_mon_excd2_cfs(df) | monthly exceedance in cfs style 2 (plot for each dv)
p_mon_excd_native(df) |  monthly exceedance in calsim native units, eg EC, km get unit 'unassigned'
p_mon_excd2_native(df) | monthly exceedance in calsim native units style 2 eg EC, km get unit 'unassigned'

### annual - line ### 
   function  | for
------------ | -------------
p_ann_wysum_excd_taf(df) |    annual exceedance - 82 oct-sep totals
p_ann_wysum_excd2_taf(df) |   annual exceedance - 82 oct-sep totals, in columns (style 2)
p_ann_wysum_excd3_taf(df) |   annual exceedance - 82 oct-sep totals, in rows (style 3)
p_ann_fjwysum_excd_taf(df) |  annual exceedance - 81 feb-jan totals
p_ann_fjwysum_excd2_taf(df) | annual exceedance - 81 feb-jan totals, style 2
p_ann_mfwysum_excd_taf(df) |  annual exceedance - 81 mar-feb totals (regular cvp contract)
p_ann_mfwysum_excd2_taf(df) | annual exceedance - 81 mar-feb totals (regular cvp contract), style 2
p_ann_jdwysum_excd_taf(df) |  annual exceedance - 81 jan-dec totals (regular cvp contract)
p_ann_jdwysum_excd2_taf(df) | annual exceedance - 81 jan-dec totals (regular cvp contract), style 2
p_ann_wymn_excd_taf(df) |     annual exceedance -  82 oct-sep means
p_ann_wymn_excd2_taf(df) |   annual exceedance -  82 oct-sep means, style 2 

### monthly difference - line ###
   function  | for
------------ | -------------
p_mon_excd_taf_d(df_diff) | monthly exceedance of differences in taf
p_mon_excd2_taf_d(df_diff)| monthly exceedance of differences in taf, style 2 
p_mon_excd_cfs_d(df_diff) | monthly exceedance of differences in cfs
p_mon_excd2_cfs_d(df_diff)| monthly exceedance of differences in cfs, style 2

### annual difference - line ### 
   function  | for
------------ | -------------
p_ann_wysum_excd_taf_d(df_diff) | annual exceedance - differences of 82 oct-sep totals
p_ann_wysum_excd2_taf_d(df_diff)| annual exceedance - differences of 82 oct-sep totals, style 2
p_ann_fjwysum_excd_taf_d(df_diff)| annual exceedance - differences of 82 feb-jan totals
p_ann_fjwysum_excd2_taf_d(df_diff)| annual exceedance - differences of 82 feb-jan totals, style 2
p_ann_mfwysum_excd_taf_d(df_diff) | annual exceedance - differences of 82 mar-feb totals
p_ann_mfwysum_excd2_taf_d(df_diff) | annual exceedance - differences of 82 mar-feb totals, style 2
p_ann_jdwysum_excd_taf_d(df_diff) | annual exceedance - differences of 82 jan-dec totals
p_ann_jdwysum_excd2_taf_d(df_diff) | annual exceedance - differences of 82 jan-dec totals, style 2
p_ann_wymn_excd_taf_d(df_diff) | annual exceedance - differences of 82 oct-sep means
p_ann_wymn_excd2_taf_d(df_diff)| annual exceedance - differences of 82 oct-sep means, style 2


### annual by wyt grid - line###
   function  | for
------------ | -------------
p_ann_fjwysum_scwyt_excd_taf(df) |    6 plots (5 wyts and 1 overall) of feb-jan totals by sac wyt
p_ann_fjwysum_scwyt_excd2_taf(df) |   6 plots (5 wyts and 1 overall) of feb-jan totals by sac wyt, style 2 
p_ann_fjwysum_sjwyt_excd_taf(df) |    6 plots (5 wyts and 1 overall) of feb-jan totals by sj wyt
p_ann_fjwysum_sjwyt_excd2_taf(df) |   6 plots (5 wyts and 1 overall) of feb-jan totals by sj wyt, style 2


### annual by wyt grid, difference - line ###
   function  | for
------------ | -------------
p_ann_fjwysum_scwyt_excd_taf_d(df_diff) |  difference - 6 plots (5 wyts and 1 overall) of feb-jan totals by sac wyt
p_ann_fjwysum_scwyt_excd2_taf_d(df_diff) | difference - 6 plots (5 wyts and 1 overall) of feb-jan totals by sac wyt, style 2 
p_ann_fjwysum_sjwyt_excd_taf_d(df_diff) | difference - 6 plots (5 wyts and 1 overall) of feb-jan totals by sj wyt
p_ann_fjwysum_sjwyt_excd2_taf_d(df_diff)|  difference - 6 plots (5 wyts and 1 overall) of feb-jan totals by sj wyt, style 2

### plot for each month, linear - line ###
   function  | for
------------ | -------------
p_ann_monfacetg_excd_taf(df) | 12 plots of individual months in a line (Grid) in taf 
p_ann_monfacetg_excd_taf_d(df_diff)| difference - 12 plots of individual months in a line in taf
p_ann_monfacetg_excd_cfs(df) | 12 plots of individual months in a line in cfs
p_ann_monfacetg_excd_cfs_d(df_diff)| difference - 12 plots of individual months in a line in cfs

### plot for each month, matrix - line ###
   function  | for
------------ | -------------
p_ann_monfacetw_excd_taf(df) | 12 plots of individual months in a matrix (Wrap) in taf
p_ann_monfacetw_excd_taf_d(df_diff) | difference - 12 plots of individual months in a matrix in taf
p_ann_monfacetw_excd_cfs(df) | 12 plots of individual months in a matrix in cfs
p_ann_monfacetw_excd_cfs_d(df_diff) | difference - 12 plots of individual months in a matrix in cfs

## tukey box plots - pbp - plot box plots ## 

### monthly - box plots ###
- pbly best for only one dv (too busy) 
- good for plotly/ggplotly - medians/hinges/outliars hoverable
   function  | for
------------ | -------------
pbp_mon_taf(df) |  monthly taf box plots      
pbp_mon_taf_d(df_diff)  | monthly taf box plots of differences
pbp_mon_scwyt_taf(df) |  monthly taf box plots by sacramento water year type
pbp_mon_scwyt_taf_d(df_diff) |  monthly taf box plots of differences by sacramento water year type


### annual - box plots ###
   function  | for
------------ | -------------
pbp_ann_perav_wysum_taf(df) | box plots of water year totals
pbp_ann_perav_wysum_taf_d(df_diff)| box plots of differences of water year totals
pbp_ann_perav_fjwysum_taf(df) | box plots of feb-jan totals
pbp_ann_perav_fjwysum_taf_d(df_diff) | box plots of differences of feb-jan totals
pbp_ann_perav_fjwysum_scwyt_taf(df) | box plots of feb-jan totals by sacramento water year type
pbp_ann_perav_fjwysum_scwyt_taf_d(df_diff)| box plots of differences of feb-jan totals by sacramento water year type
pbp_ann_perav_mfwysum_taf(df) | box plots of mar-feb totals
pbp_ann_perav_mfwysum_taf_d(df_diff) box plots of mar-feb totals



## tukey box plots with data points shown (and mean) - pdp - plot dot plots ## 
   function  | for
------------ | -------------
pdp_ann_perav_wysum_taf(df, binwidth, dotsize) | dot plot of water year totals
pdp_ann_perav_wysum_taf_d(df_diff, 1, 5)| dot plot of difference of water year totals
pdp_ann_perav_mfwysum_taf(df, 1,5)| dot plot of mar-feb year totals
pdp_ann_perav_mfwysum_taf_d(df_diff, 1,5)| dot plot of difference of mar-feb year totals


##   bell plots  (pdfs) - pdr - plot density ridges ##
   function  | for
------------ | -------------
pdr_ann_perav_wysum_taf(df) | bell curve with individual water year distribution shown, .25, .5, & .75 quantiles, w/mean (cirle symbol)
pdr2_ann_perav_wysum_taf(df) | bell curve with individual year distribution shown, .25, .5, & .75 quantiles, w/mean labelled, separate scenario colors
pdr_ann_perav_mfwysum_taf(df) | bell curve with individual mar-feb year distribution shown, .25, .5, & .75 quantiles, w/mean (cirle symbol)
pdr_ann_perav_wysum_taf_d(df_diff)| as above, difference
pdr2_ann_perav_wysum_taf_d(df_diff)|as above,  difference
pdr_ann_perav_mfwysum_taf_d(df_diff)| as above,  difference


# timeseries #

## monthly - line ## 
   function  | for
------------ | -------------
p_mon_ts_taf(df, 1921, 2004)  |
p_mon_ts_may_taf(df, 1929, 1937) |
p_mon_ts_sep_taf(df, 1929, 1937) |
p_mon_ts_taf_maysseps_taf(df, 1922, 2003) |

p_mon_ts_cfs(df, 1920, 2003) |
p_mon_ts_native(df, 1930, 1935) |

## annual - line ## 

p_ann_ts_sum_taf(df, 1977, 1978) |
p_ann_ts_sum_native(df, 1930, 1990)|
p_annmonmean_ts_mn_taf (df, 1922, 1990) |

##################################
## timeseries difference #########
##################################

## monthly - line ## 

#plot monthly timeseries taf difference
p_mon_ts_taf_d (df_diff, 1922, 1925)|
p_mon_ts2_taf_d (df_diff, 1922, 2003)|
p_mon_ts3_taf_d (df_diff, 1922, 2003)|
p_mon_ts_cfs_d (df_diff, 1922, 2003)|
p_mon_ts_native_d(df_diff, 1922, 1923)|
p_mon_ts2_native_d(df_diff, 1921, 1930)|

## annual - line ##

p_ann_ts_sum_taf_d (df_diff, 1975, 1978) |
pb_ann_ts_sum_taf_d(df_diff, 1922, 2003)|
p_ann_ts_mn_taf_d (df_diff, 1955.2, 1956.5)| 


###################################
## timeseries ridges###############  # for one dv only! #
###################################


#plot ridges (plots monthly y, colors by wy sum) (data, yrmin, yrmax, scaling factor). for one dv only (otherwise averaged)
pr_ts_taf(df, 1921, 2007, 0.0003) #+ ggtitle("del_cvp_total_s 1922 - 2003")#will plot up to yrmax-1 (max yr not plotted, doesn't always fit) (ggridges bug)
pr_ts_taf_d(df_diff, 1921, 2007, 0.009)| #+ ggtitle("del_cvp_total_s 1922 - 2003 [difference from baseline]")

pr_ts_eomstormean_taf(df, 1970, 1995, 0.00001)| #will plot up to yrmax-1 (max yr not plotted, doesn't always fit) (ggridges bug)
pr_ts_eomstormean_taf_d(df_diff, 1922, 2004, 0.0005)|

###################################
## timeseries tiles ###############  
###################################

prast_mon_ts_taf(df) |
prast_ann_ts_sum_taf(df) |
prast_annmonmean_ts_mn_taf(df) |

prast_mon_ts_taf_d(df_diff)|
prast_ann_ts_sum_taf_d(df_diff)|
prast_annmonmean_ts_mn_taf_d(df_diff)|

ptile_mon_ts_taf(df) |
ptile_ann_ts_sum_taf(df) |
ptile_annmonmean_ts_mn_taf(df) |

ptile_mon_ts_taf_d(df_diff)|
ptile_ann_ts_sum_taf_d(df_diff)|
ptile_annmonmean_ts_mn_taf_d(df_diff)|

