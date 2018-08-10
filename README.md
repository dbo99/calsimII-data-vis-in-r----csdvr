# csdvr
 calsimII data vis in r (csdvr). version august beta 18.
 
##### workflow #####
0. requires .csv output by typing `.csv` instead of `.dss` in WRIMS' dv' field (which will still output both if `.csv` used) (requires WRIMS 
   2018 versions or newer)
1. drop calsim csvs in `csv` folder
2. in `csv_list.r`, spell csv file names and give scenarios nicknames

2a.  if order matters for on-the-fly plots or batch plots, remember/cut-and-paste same nicknames to scenfacts.r (scenario factors), in order you prefer, otherwise skip step. default order without 2a is alphabetic or similar)

3. open control.r: in three places at top, spell the working folder path (eg use as a stand alone post-processor location or in a proj-specific folder?)

4. in control.r, run blocks from top down as needed: single clicks there read in csvs, build `data.frames`, and either batch export plots or investigate certain decision variables (dvs). 

#### notes #####
- assumes you know names of variables to search for, ie names of calsim decision variables, eg "s44" (dss records spell names), next steps are for auto-complete of dv names
- as needed spell other name/nickname descriptions for dvs in varcodes.csv - only a few mapped currently, eg "Jones (CVP)" for "d419". some plots label the `df$dv`, the actual calsim name, and other `df$dv_name`, the nickname
- as needed/time allows save/generalize your working plots in plot scripts folder to add to collection of templates
- currently only handles one climate change scenario (ie tied to wyt.csv - adjustment needed to accommodate more)
- default plot size is widescreen powerpoint. to change, search and replace (ie Ctrl-F `width = 13.333, height = 7.5`, replace with 
  desired dimensions, eg `width = 10, height = 6` and filetype, eg .jpg, .pdf)
