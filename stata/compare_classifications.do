
* PLS and GFE (not in table)
use ${project_path}/data/FG2010, clear
merge n:1 playerID using ${project_path}/data/FG2010_PLS
drop _merge
merge n:1 playerID using ${project_path}/data/FG2010_GFE
drop _merge

recode GFE_group (1=2) (2=1)
tab GFE_group PLS_group

* GFE and FGF
use ${project_path}/data/FG2010, clear
merge n:1 playerID using ${project_path}/data/FG2010_GFE
drop _merge
tab preftype GFE_group

* GFE and PLS
use ${project_path}/data/FG2010, clear
merge n:1 playerID using ${project_path}/data/FG2010_PLS
drop _merge
tab preftype PLS_group

* GFE and Fallucci
use ${project_path}/data/FG2010, clear
merge n:1 playerID using ${project_path}/data/FG2010_GFE
drop _merge
merge n:1 idsubj using ${project_path}/data/F-and-G-2010
drop _merge
tab clusters GFE_group

* PLS and Fallucci
use ${project_path}/data/FG2010, clear
merge n:1 playerID using ${project_path}/data/FG2010_PLS
drop _merge
merge n:1 idsubj using ${project_path}/data/F-and-G-2010
drop _merge
tab clusters PLS_group






