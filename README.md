# csdvr
 calsim data vis in r. version 1.0_8.10.2018
 
##### workflow #####

0. Requires:
- `.csv` output (not `.dss`). Specifying `.csv` instead of `.dss` in WRIMS' dv field produces both `.csv` and `.dss` output decision variable "dv" files.
- Requires WRIMS versions from 2018 or later.
- Accepts either CalSimII or CalSim 3.0 output, but set up currently only for CalSimII's time range.
1. Download  most recent csdvr_mm.dd.yyyy.zip as entire package to start from (~30 kb) 
3. Drop your CalSim csvs in the `csv` folder 
2. In `csv_list.r`, enter your complete csv file names (eg `040812_BO_Y1a1.csv`) and enter scenario nicknames (eg `Scen1_Y1A1`). Short labels leave room for plot space


4. If scenario order matters for on-the-fly plots or batch plots, enter same nicknames to `scenfacts.r`, in order you prefer (top to bottom here yields top to bottom in legend). Otherwise skip step; default order without `scenfacts.r` tweaks is alphabetic

5. In `control.r`: in three places at top, enter the working folder path (eg, folder could live somewhere as a stand alone post-processor or in a project folder for a specific project

6. In `control.r`, run blocks from top down as needed: single run-clicks here let you read in csvs, build `data.frame`s, and either batch export `ggplot2` or `plotly` plots or see/export tables as `tibble`/`.csv`, to examine certain decision variables (dvs)

#### notes #####
- assumes you know names of variables to search for, ie names of dvs, eg "s17". If not, consult `.wresl` or `.dss` files. Wish list: auto-completion of dv names while typing. `varcodes.csv` identifies some
- as needed enter other name/nickname descriptions for dvs in `varcodes.csv` - only a few mapped currently, eg `Jones (CVP)` for `d419`. Some plots label the `df$dv`, the actual calsim name, and other `df$dv_name`, the nickname 
- as needed/time allows save/generalize your working plots in `plotexportscripts` folder to add to collection of templates
- currently assumes all scenarios are under same climate scenario (tied to wyt.csv - adjustment needed to accomodate more -- for any water  year type functions - other functions still applicable as is if multiple climate scenarios used)
- default plot size is widescreen to exactly fit `.pptx`. To change, search and replace all (from Ctrl-F) `width = 13.333, height = 7.5`, to desired dimensions, eg `width = 10, height = 6` , same with desired filetype, eg `.jpg`, `.pdf`, `.html`)
  
  Access CalSim benchmark studies:
  
  https://water.ca.gov/Library/Modeling-and-Analysis/Central-Valley-models-and-tools/CalSim-2

