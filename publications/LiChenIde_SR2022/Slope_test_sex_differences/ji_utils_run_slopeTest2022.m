function [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2)
% ========================================================================
%     Copyright (c) 2020, Yale University, Li Lab
%                     All Rights Reserved
% ========================================================================
% @DATE (created)       : 12/20/2019
% @DATE (last modified) : 12/20/2019
% @AUTHOR      : Jaime S Ide
%                jaime.ide@yale.edu
% ========================================================================

% After Nov 15 2020
Y.v.g1 = vy1; % regressor
X.v.g1 = vx1; % GMV
Y.v.g2 = vy2; %
X.v.g2 = vx2; %

%% Slope Analysis
min2exclude = -100;
r1 = ji_utils_regress(Y.v.g1,X.v.g1);
r2 = ji_utils_regress(Y.v.g2,X.v.g2);
resp_slope = ji_utils_comp_regress(r1,r2);

%% Correlation
[corr1.r corr1.p] = corr(vx1',vy1');
[corr2.r corr2.p] = corr(vx2',vy2');