# csdvr
 CalSim data vis in R | 
 version 1.0_8.10.2018 | 
 filter and visualize CalSim output for any number of variables and reasonable number of CalSim scenarios | 
 export report or presentation ready plot images (eg jpgs, pdfs) or interactive plots (html)  | developed by Bureau of Reclamation staff 
 
### uses ###

- WRIMS CalSim decision variable ("DV") output in `.csv` format (not `.dss`). If csv file needed, specify `outputfilename.csv` instead of `outputfilename.dss` in WRIMS2' `Dvar DSS file:`'s field in versions from 2018 or later (free from California Dept. of Water Resources, see link at bottom for request - currently through email list distribution)
- R, and R libraries specified in `libs.r`. Probably relies most on `dplyr` and `ggplot2` libraries of the `tidyverse`

### steps ###

1. Download  most recent `csdvr_mm.dd.yyyy.zip` (~30 kb) 
3. Place your CalSim csvs in the `csv` folder 
2. In `csv_list.r`, enter your complete csv file names (eg `040812_BO_Y1a1.csv`) and enter scenario nicknames (eg `Scen1_Y1A1`). Short labels make room for plot space


4. If scenario/legend order matters for on-the-fly plots or batch plots, enter same nicknames in `scenfacts.r` in order you prefer: top to bottom in `scenfacts.r` yields top to bottom order in legend. Otherwise skip step; default order without specification in `scenfacts.r` is alphabetic

5. In `control.r`: enter same working folder path in three places (blocks) at the top of the file (first ~20 lines)

6. In `control.r`, run these blocks from top down as needed: single clicks here let you read in csvs (run "block 1"; do sparingly as ~1/6 min read-in time per scenario), build `data.frame`s, and generate plots in batches with pre-defined templates (run "block 2"), or individually (with some pre-defined tables too, eg `tibble`,`.csv`) with individual functions (run "block 3" and any function listed below).

#### notes ####
- assumes you know names of DVs to view, eg Folsom Lake is `S8`. If not consult `.wresl` or `.dss` files. To-do: auto-fill DV names while typing. `varcodes.csv` identifies some dvname-commonname pairs, add more as needed. Some plots label the `df$dv`, the actual CalSim name, and others the `df$dv_name`, the common name 
- save new finished plot scripts in `plotexportscripts` folder to add to collection of templates
- currently assumes all scenarios are under same climate scenario (tied to wyt.csv - adjustment needed to accomodate more for any water  year type functions - other functions still applicable as is if multiple climate scenarios used) (sample's uses Q5 Early Long Term)
- default plot size is widescreen to exactly fit default `.pptx`. To change, search and replace all (from Ctrl-F) `width = 13.333, height = 7.5`, to desired dimensions, eg `width = 10, height = 6` , same with desired filetype, eg `.jpg`, `.pdf`, `.html`)
- accepts either CalSimII or CalSim 3.0 output, but set up currently for CalSimII's time range only
- currently lacks any diagnostics on "controls" - hoping to add directly in `.wresl` files for ease in csdvr, other post-processors, in future
- currently lacks any geospatial ability
  
  Access CalSim benchmark studies and contact info for WRIMS software:
  
  https://water.ca.gov/Library/Modeling-and-Analysis/Central-Valley-models-and-tools/CalSim-2

