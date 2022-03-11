%% ABCD ADHD-VBM

clc;clear all; close all;

% Note: Covariates including age, race, twin status, study site, 
% scanner model, and TIV have been regressed out 
% before running slope tests

% Input data are residual scores.

load('res_ADHDt_GMV_boys.mat')
boys = res_ADHDt_GMV;
load('res_ADHDt_GMV_girls.mat')
girls = res_ADHDt_GMV;

% Variable list
% column 1-ADHDt_6cov 2-GMV_pos_all_6cov 3-GMV_girl_mask_6cov 
% 4-GMV_boy_mask_6cov 5-GMV_girl_excl_6cov 6-GMV_boy_excl_6cov 
% 7-GMV_aalBiCaud_6cov 8-GMV_aalBiPuta_6cov 9-GMV_aalBiGP_6cov

% Taking correlations between ADHDt score and GMV of bilateral caudate as
% an example
x1 = boys(:,1); % ADHDt score of boys
y1 = boys(:,7); % GMV of bilateral caudate of boys
x2 = girls(:,1); % ADHDt score of girls
y2 = girls(:,7); % GMV of bilateral caudate of girls

%% Regression slope test for sex differences
% correlation between ADHDt and bilateral caudate GMV for boys
r1 = ji_utils_regress(x1,y1) 
% correlation between ADHDt and bilateral caudate GMV for girls
r2 = ji_utils_regress(x2,y2)
% Slope T and p values
resp_slope_PES1 = ji_utils_comp_regress(r1,r2)

