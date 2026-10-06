# Replication Package for "A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil"
by Nima Nonejad

This repository contains data, MATLAB code, numerical reference results, and MATLAB figure files required to reproduce results presented in manuscript and supplementary material.

Replication code developed using MATLAB R2009b with Econometrics Toolbox. Publicly available datasets included in data folder. User-written MATLAB functions provided in functions folder.

Folders `replication_of_submission` and `replication_of_supplementary_material` contain scripts for reproducing manuscript and supplementary results. Reference numerical results provided in `results/results.xls`. Reference figures available in plots folder.

For detailed step-by-step replication instructions, see `readme/readme.txt`.

## 1. Table of Contents
* 1.1 Replication Updates
* 1.2 Script Modifications
* 1.3 Figure Rendering and Formatting Notes

---

## 1.1 Replication Updates
* Parameter grid for g in Supplementary Figure 7: `{0.05, 0.5, 5, 50, 100}`
* Base value in `main_prior.m`: `dg = 0.05`

---

## 1.2 Script Modifications
* `main_real.m`: line 43 deflates prices by CPI (`vp = vyc(2:end,1)./vpc(2:end,1);`), line 48 sets nominal returns (`vy = diff(log(vyc(:,1)));`), line 92 restores full 18 predictor loop
* `figure4_supp_computation.m`: line 21 loads `wti_real_` instead of `wti_`
* `main_sim.m`: sets global stream via `RandStream.setGlobalStream` and saves to `simulation_k.mat`
* `figure7_supp_computation.m`: line 22 loads `wti_prior_` instead of `wti_`
* `figure9_supp_computation.m`: line 14 sets `ih = 2` and line 20 loads `for_<ih>.mat`

---

## 1.3 Figure Rendering and Formatting Notes
* Presentation differences in tick spacing, tick labels, and axis limits arise from manual post-processing for publication and MATLAB version defaults (R2009b versus modern versions)
* Formatting variations concern visual layout only and do not alter underlying numerical results or conclusions
