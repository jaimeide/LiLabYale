## ABCD pediatric template (ABCD1000)
![alt text](https://github.com/jaimeide/LiLabYale/blob/main/figs/Template_Age10.9167-9.75_20mm.gif?raw=true)

In order to perform voxel-based morphometry with appropriate templates, we constructed customized tissue probability maps (TPMs) and DARTEL templates, as well as an average T1 anatomical template for visualization purposes. A cohort of 1000 children (500 girls) was selected from the ABCD dataset according to the following procedure. We generated 10,000 random samples with 1000 children (half girls) and selected the one with age and scan site distributions closest to those of the entire cohort. We used SPM Segment to generate the individual’s tissue maps and the TOM8 Toolbox (http://dbm.neuro.uni-jena.de/software/tom) to create the population TPMs and T1 anatomical template, controlling for the effects of age and gender. DARTEL templates were constructed using utilities available in SPM. This involved creating gray (rp1) and white (rp2) matter segments after affine registration followed by DARTEL nonlinear image registration, whereby all selected images were iteratively aligned with a template generated from their own mean, and finally normalized to the MNI space (ICBM template).

## Reference

Li, C.S., Chen, Y., Ide, J.S. Gray matter volumetric correlates of attention deficit and hyperactivity traits in emerging adolescents. *Scientific Reports* **12**, 11367 (2022). https://doi.org/10.1038/s41598-022-15124-7

[Read the paper](https://www.nature.com/articles/s41598-022-15124-7)