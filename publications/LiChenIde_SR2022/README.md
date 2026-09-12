# Scripts — Li, Chen & Ide (2022), Scientific Reports

Analysis code supporting:

Li, C.S., Chen, Y., Ide, J.S. Gray matter volumetric correlates of attention deficit and hyperactivity traits in emerging adolescents. *Scientific Reports* **12**, 11367 (2022). https://doi.org/10.1038/s41598-022-15124-7

This folder covers the statistical analyses reported in the paper (heritability, sex-difference, and medication-effect tests) run on top of the ABCD gray matter volume (GMV) and ADHD-t score data. It does **not** include the VBM/CAT12 preprocessing pipeline or the pediatric template construction (see the [`pediatric_template_ABCD1000`](../pediatric_template_ABCD1000) folder for the latter) — inputs here are already-extracted, covariate-residualized values.

## Folder overview

| Folder | What it does | Tooling |
|---|---|---|
| [`ACE_model_estimation/`](./ACE_model_estimation) | Univariate ACE twin model estimating heritability (a²), shared- (c²) and unique-environment (e²) variance of the ADHD-t score | Mplus 8.6 |
| [`Slope_test_sex_differences/`](./Slope_test_sex_differences) | Tests whether the ADHDt–GMV correlation slope differs significantly between boys and girls | MATLAB |
| [`Slope_test_twins/`](./Slope_test_twins) | Compares ADHDt/GMV correlations across MZ twin, DZ twin/sibling, and unrelated pairs (the evidence for heritability in Fig. 3) | MATLAB |
| [`Tukey_test/`](./Tukey_test) | Tukey's HSD comparing GMV (caudate, putamen, globus pallidus) and ADHD-t across medication groups (stimulant / antidepressant / unmedicated) | Python (Jupyter, `pingouin`) |

Each subfolder has its own README with input/output details and run instructions.

## Data

Inputs are derived from the ABCD Study (Release 2.0) after covariate regression (age, sex, race, study site, scanner model, TIV as applicable — see Methods in the paper). Raw ABCD imaging/behavioral data are not redistributed here; access is through the [NDA](https://abcdstudy.org/).

## Known gaps

- `Tukey_test/tukeys_test_adhd_medication.ipynb` loads `0_list_Q11502_age_gender_adhd_t_GMV_caudPutGP.csv` and `0_df_ABCD_ADHDt_GMV_forANCOVA_Aug14_2020.csv`. These are individual-level data derived from the ABCD Study (controlled-access via the NDA), so they can't be included here. See the [Tukey_test README](./Tukey_test) for how to request them.

## Requirements

- MATLAB (tested scripts have no toolbox-specific calls beyond base MATLAB)
- Mplus 8.6+ (for the ACE model)
- Python 3 with `pandas`, `numpy`, and [`pingouin`](https://pingouin-stats.org/) (for the Tukey test notebook)

## Citation

If you use this code, please cite the paper above.

## Contact

- **PI:** Chiang-shan R. Li ([chiang-shan.li@yale.edu](mailto:chiang-shan.li@yale.edu))
- **Maintainer:** Jaime Ide ([jaime.ide@yale.edu](mailto:jaime.ide@yale.edu))