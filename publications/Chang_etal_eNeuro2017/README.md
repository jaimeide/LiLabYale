# Scripts — Chang, Ide, Li, Chen & Li (2017), eNeuro

Analysis code supporting:

Chang, A., Ide, J.S., Li, H.H., Chen, C.C., Li, C.S.R. Proactive Control: Neural Oscillatory Correlates of Conflict Anticipation and Response Slowing. *eNeuro* **4**(3), ENEURO.0061-17.2017 (2017). https://doi.org/10.1523/ENEURO.0061-17.2017

## Origin of the model

This code is not original to the 2017 paper — the Dynamic Belief Model (DBM) and its implementation here originate from:

Ide, J.S., Shenoy, P., Yu, A.J., Li, C.S.R. Bayesian Prediction and Evaluation in the Anterior Cingulate Cortex. *Journal of Neuroscience* **33**(5), 2039–2047 (2013). https://doi.org/10.1523/JNEUROSCI.2201-12.2013

The 2013 paper introduces the same DBM formulation (belief update, reset rate α, Beta-distribution prior parameterized by mean and scale) used to estimate P(stop) and P(error) from a stop-signal task sequence. The 2017 eNeuro paper reuses this model to generate the P(stop) regressor for its EEG time-frequency analysis of proactive control.

This folder implements the DBM used to estimate each participant's trial-by-trial belief about the likelihood of a stop signal, P(stop), in the stop-signal task (SST), and to test whether that belief predicts go-trial reaction time (RT) slowing — the behavioral signature of proactive control reported in the 2017 paper.

## What the model does

For each trial, the DBM maintains a running belief distribution over the stop-signal rate. Rather than a plain running average, the belief can also probabilistically "reset" toward a fixed prior — this reset mechanism (Yu & Cohen, 2009) is what lets the model capture sequential/adaptation effects instead of a static estimate. Three parameters control the fit for each subject:
- **α (alpha)** — the weight/influence of past trials (reset rate)
- **pm (prior mean)** — the fixed belief's mean stop-signal probability
- **sc (prior scale)** — how peaked/skewed the fixed belief is around its mean

For each subject, the parameters are grid-searched to maximize the Pearson correlation between the model's trial-by-trial P(stop) and observed go-RT (the "sequential effect" / proactive slowing signature).

## Files

| File | Description |
|---|---|
| `main.m` | **Run this one.** For each subject, sweeps over (pm, sc, α), computes P(stop) via the DBM, correlates it with go-trial RT (excluding RTs < 100 ms), and saves the best-fitting parameters and fit statistics to `res_*.mat`. |
| `ji_seqeff_get_pstop_perror.m` | Given a subject's trial sequence and model parameters, runs the DBM trial-by-trial to produce the P(stop) and P(error) trajectories. |
| `rdist_update.m` | Core Bayesian belief-update step: blends the previous belief with the fixed prior at rate α, updates with the current trial's outcome, and returns both a Bayes-estimate and a MAP-estimate of the belief. |
| `getprior_r.m` | Builds the discretized Beta-distribution prior (the "fixed belief") from (pm, sc). |
| `sub1.mat`, `sub2.mat`, `sub3.mat` | Per-subject trial data (400 trials each): `vc` (trial condition code: 1 = go-correct, 2 = go-error, 3 = stop-correct, 4 = stop-error) and `rtVector` (RT in ms per trial). |

## Instructions

1. Open `main.m` in MATLAB — it expects `sub1.mat`, `sub2.mat`, `sub3.mat` in the working directory.
2. Set `sub` to the subject(s) to run, and `m` (pm), `s` (sc), `alpha` to the parameter range(s) to sweep.
3. Run. For each subject, this saves `res_sub<N>_bayes_<sizes>.mat` containing the fit statistics (`fitCorr_RT`, `fitRsquare_RT`, `fitPval_RT`) across the grid, plus the best-fitting parameter set (`res.parmax`) and its correlation/p-value (`res.rmax`, `res.pmax`).

## Notes for anyone extending this code

- **P(stop) is causally aligned to avoid leakage:** the belief used to predict RT on trial *t* is the belief entering trial *t* (before that trial's outcome is observed), not one that's already seen it.
- **Best fit is currently selected by raw correlation (`fitCorr_RT`), not R².** A strong negative correlation could lose out to a weak positive one under this convention — worth deciding deliberately if you extend the parameter range.

## Citation

If you use this code, please cite both:
- Chang, A., Ide, J.S., Li, H.H., Chen, C.C., Li, C.S.R. (2017). *eNeuro* 4(3), ENEURO.0061-17.2017.
- Ide, J.S., Shenoy, P., Yu, A.J., Li, C.S.R. (2013). *Journal of Neuroscience* 33(5), 2039–2047. (original DBM formulation)
