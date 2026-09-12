# Tukey's HSD test: medication effects on GMV and ADHD-t

Jupyter notebook comparing gray matter volume (bilateral caudate, putamen, globus pallidus) and ADHD-t scores across three medication groups — psychostimulant, antidepressant, and unmedicated ("nondrug") children — using Tukey's honestly significant difference (HSD) test with Cohen's d effect sizes (`pingouin.pairwise_tukey`).

## File

| File | Description |
|---|---|
| `tukeys_test_adhd_medication.ipynb` | Loads and merges the GMV and medication datasets, then runs pairwise Tukey tests for caudate GMV, putamen GMV, globus pallidus GMV, and ADHD-t score across the three medication groups. |

## Instructions

1. Open the notebook in Jupyter (or any `.ipynb`-compatible viewer/editor).
2. Requires Python 3 with `pandas`, `numpy`, and [`pingouin`](https://pingouin-stats.org/) installed (`pip install pingouin`).
3. Run all cells top to bottom.

## ⚠️ Restricted-access data

The notebook expects two CSV files that are **not included in this folder**:
- `0_list_Q11502_age_gender_adhd_t_GMV_caudPutGP.csv` — per-subject age, sex, ADHD-t, and GMV (caudate/putamen/globus pallidus) for the 11,502-subject cohort.
- `0_df_ABCD_ADHDt_GMV_forANCOVA_Aug14_2020.csv` — per-subject medication flags (`F_antidepressant`, `F_stimulant`, `F_nondrug`) merged in by subject `ID`.

Both are individual-level data derived from the ABCD Study, which is controlled-access (via the NDA) rather than public. They can't be posted here; if you need them to reproduce this analysis, please reach out to the authors (see contact info in the top-level README) to request access.