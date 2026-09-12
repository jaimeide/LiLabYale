%% twin correlations - Slope Tests: MZ x DZ x unrelated
load('groups_DZ_MZ_unr_Q11502_SR2022.mat');
load('extracted_11502imgs_GMV_9rois_SR2022.mat');
% ROI 1        'mask_neg_adhdt_ALL';
% ROI 2        'mask_pos_adhdt_ALL';
% ROI 3        'mask_neg_adhdt_Boys';
% ROI 4        'mask_neg_adhdt_Girls';
% ROI 5        'mask_neg_adhdt_Boys_excl';
% ROI 6        'mask_neg_adhdt_Girls_excl';
% ROI 7        'aal_biCaud';
% ROI 8        'aal_biPut';
% ROI 9        'aal_biGP';

group{1}.iroi = [1 2]; % Girl+Boys neg and pos masks
group{2}.iroi = 6; % Girls' excl mask
group{3}.iroi = 5; % Boys' excl mask

%% Choose the group
   % g = 1; % B+G
     g = 2; % G
   % g = 3; % B
    
index = g;

ji_utils_slope_twins(group,index,set2run)