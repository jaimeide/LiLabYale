# Slope test: sex differences in ADHDt–GMV correlation

Tests whether the correlation between ADHD-t score and regional gray matter volume (GMV) differs significantly in *slope* between boys and girls, using a regression slope-difference test (equivalent to comparing two independent regression coefficients via a pooled-variance t-test).

## Files

| File | Description |
|---|---|
| `res_ADHDt_GMV_boys.mat` | Residualized ADHDt/GMV values for boys (n = 6,033 rows × 9 columns). |
| `res_ADHDt_GMV_girls.mat` | Same, for girls (n = 5,464 rows × 9 columns). |
| `batch_slope_test_sexDiff.m` | Main script — loads both files, runs the regression for boys and girls separately, then the slope-difference test. |
| `ji_utils_regress.m` | Computes the sums of squares (`xx`, `xy`, `yy`), residual SS, and residual df for a simple linear regression of `y` on `x`. |
| `ji_utils_comp_regress.m` | Takes the two regression outputs from `ji_utils_regress.m` and computes the t-statistic and two-tailed p-value for the difference in slopes (pooled residual variance across both groups). |

## Data columns

Both `.mat` files contain a `res_ADHDt_GMV` matrix with columns:
1. ADHD-t score (6 covariates regressed out)
2. GMV, whole-brain positive ADHDt-correlate mask (6 cov.)
3. GMV, girl-specific correlate mask (6 cov.)
4. GMV, boy-specific correlate mask (6 cov.)
5. GMV, girl-specific "excl." mask (6 cov.)
6. GMV, boy-specific "excl." mask (6 cov.)
7. GMV, bilateral caudate (AAL mask, 6 cov.)
8. GMV, bilateral putamen (AAL mask, 6 cov.)
9. GMV, bilateral globus pallidus (AAL mask, 6 cov.)

("6 covariates" = age, race, twin status, study site, scanner model, and TIV regressed out beforehand — see paper Methods.)

## Instructions

1. Open `batch_slope_test_sexDiff.m` in MATLAB.
2. As provided, it runs the example for column 7 (bilateral caudate); change the column indices (`x1,y1,x2,y2`) to test any other regional GMV column against ADHD-t.
3. Run the script. It prints:
   - `r1`, `r2`: regression stats for boys and girls separately
   - `resp_slope_PES1`: the slope-difference test result (`.t`, `.p` for the t-statistic and two-tailed p-value)