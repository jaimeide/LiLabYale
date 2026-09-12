function [pstop perror] = ji_seqeff_get_pstop_perror(vc,flag)
% INPUT
% vc: vector with SST conditions (1c,2c,3c,4c)
% flag: contain the model parameters
% OUTPUT
% p(stop): based on DBM
% p(error): based on DBM
% % ========================================================================
% %     Copyright (c) 2012, Yale University
% %                     All Rights Reserved
% % ========================================================================
% % @DATE (created)       : 02/14/2012
% % @DATE (last modified) : 05/14/2016
% % @AUTHOR      : Jaime S Ide
% %                jaime.ide@yale.edu
% % ========================================================================
% Based on Pradeep's code rdist_test

%% Set model parameters (EXACTLY HOW PRADEEP SET.. IT GIVES THE SAME p(stop) AND p(error)
if (nargin<2)
    Nr = 1000;
    pmean = 0.25;
    pmean_e = 0.15;
    bscale = 10; % ASK PRADEEP... WHY HE SET THIS VALUE??!
    bscale_e = 1; % ASK PRADEEP... WHY HE SET THIS VALUE??!
    alpha = 0.2;
    alpha_e = 0.2;
    esttype = 'bayes';
else
    Nr = flag.Nr;
    pmean = flag.pmean;
    pmean_e = flag.pmean_e;
    bscale = flag.bscale; 
    bscale_e = flag.bscale_e; 
    alpha = flag.alpha;
    alpha_e = flag.alpha_e;
    esttype = flag.esttype;
end
rprior = getprior_r(pmean, Nr,bscale);
rprior_e = getprior_r(pmean_e, Nr,bscale_e);

%% Compute belief
rval_traj(1) = pmean;
rdist_traj(:,1) = rprior;
rval_traj_e(1) = pmean_e;
rdist_traj_e(:,1) = rprior_e;

%M = behavdata.subj{j}.ses{s};
ntrials = length(vc);
trials = -1*ones(ntrials,1);
etrials = -1*ones(ntrials,1);
i1c = find(vc==1);
i2c = find(vc==2);
i3c = find(vc==3);
i4c = find(vc==4);
trials([i1c;i2c]) = 0; % go trials
trials([i3c;i4c]) = 1; % stop trials
etrials([i2c;i4c]) = 1; % error trials
etrials([i1c;i3c]) = 0; % correct trials

for t = 1:length(trials)
    [bayesr mapr rdpost] = rdist_update(rdist_traj(:,t), trials(t), rprior, alpha);
    [bayesr_e mapr_e rdpost_e] = rdist_update(rdist_traj_e(:,t), etrials(t), rprior_e, alpha_e);
    if (strcmp(esttype,'map'))
        rval_traj(t+1) = mapr;
        rval_traj_e(t+1) = mapr_e;
    else
        rval_traj(t+1) = bayesr;
        rval_traj_e(t+1) = bayesr_e;
    end
    rdist_traj(:,t+1) = rdpost;
    rdist_traj_e(:,t+1) = rdpost_e;
end;

% figure;
% imagesc(rdist_traj); hold on; plot(Nr*rval_traj, 'r');
% figure;
% bar(1:ntrials,10*trials);

pstop = rval_traj;
perror = rval_traj_e;
end

