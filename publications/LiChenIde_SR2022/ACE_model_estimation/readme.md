# ACE model estimation (heritability of ADHD-t score)

Estimates a univariate **ACE twin model** for the ADHD-t score, decomposing variance into:
- **A** — additive genetic (heritability, a²)
- **C** — shared/common environment (c²)
- **E** — unique/non-shared environment (e², includes measurement error)

using the classical twin-design equal-environments assumption (MZ genetic correlation fixed to 1.0, DZ to 0.5).

## Files

| File | Description |
|---|---|
| `twinData_all_residual_R1.csv` | Twin-pair data (1,728 rows), one row per twin/sibling pair, grouped by zygosity. All variables are **residual scores** — age, sex, race, and study site have already been regressed out; for regional GMV columns, scanner model and total intracranial volume (TIV) were also regressed out as additional covariates. |
| `Mplus_ADHD_ACE_all_adhdT.inp` | Mplus script that fits the ACE model to the ADHD-t score (`adhdt1`/`adhdt2`) for all subjects (girls + boys combined). Open as plain text to read/edit. |
| `Mplus_ADHD_ACE_all_adhdT.out` | Mplus output/log from running the `.inp` script above. Open as plain text. |

## Data columns

The CSV has no header row; columns are, in order:
`zyg, adhdt1, adhdt2, gmvposi1, gmvposi2, gmvnega1, gmvnega2, girlexc1, girlexc2, boyexc1, boyexc2, cau1, cau2, lcau1, lcau2, rcau1, rcau2, put1, put2, lput1, lput2, rput1, rput2, pal1, pal2, lpal1, lpal2, rpal1, rpal2`

where `zyg` codes zygosity (1 = MZ, 2 = DZ), the `1`/`2` suffix denotes twin A/twin B, and:
- `adhdt` = ADHD-t score
- `gmvposi`/`gmvnega` = GMV of the whole-brain positive/negative ADHDt-correlate masks (all subjects)
- `girlexc`/`boyexc` = GMV of the girl-specific / boy-specific correlate masks
- `cau`/`put`/`pal` = bilateral caudate / putamen / globus pallidus GMV (with `l`/`r` prefixes for left/right)

The `.inp` script as provided fits the ADHD-t score model only (`USEVARIABLES = adhdt1 adhdt2`); swap in any of the other variable pairs above to fit the same ACE model to a different measure.

## Instructions

1. Run `Mplus_ADHD_ACE_all_adhdT.inp` in Mplus (version 8.6 or later); it expects `twinData_all_residual_R1.csv` in the same working directory.
2. Mplus writes results to a `.out` file — `Mplus_ADHD_ACE_all_adhdT.out` is the one from this run. Open either file as plain text (`.inp`/`.out` aren't recognized MATLAB/Office formats but are just text).
3. The heritability estimates (`pa`, `pc`, `pe` — the proportions of variance from A, C, E respectively) appear under `MODEL CONSTRAINT` results in the output.