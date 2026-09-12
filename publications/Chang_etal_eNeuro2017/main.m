%% correlates DBM-predicted p(stop) with go-trial RT
% For each subject, sweeps over prior mean (m), prior scale (s), and
% reset rate (alpha) for the Dynamic Belief Model, then checks which
% parameter combo gives the best correlation between p(stop) and go RT.
clear all

%% Test for a fixed set of parameters
% sub = [1:3];
% m = 0.01;
% s = 10;
% alpha = 0.12;

%% Test the sweep of parameter for a single subject
sub = [1];
m = 0.01:0.05:0.5;      % prior mean for p(stop)
s = 10;                 % prior scale (bscale) - fixed here
alpha = 0.02:0.05:0.98; % belief reset rate


%% Main sweep: load individual data and compute pstop, perror
sizz = [length(m),length(s),length(alpha)]; % grid size, used for ind2sub below
for nSub = 1:length(sub)
    fileName = ['sub',num2str(sub(nSub))]
    load(fileName)

    fitRsquare_RT = zeros(sizz);
    fitCorr_RT = fitRsquare_RT;
    fitPval_RT = fitRsquare_RT;

    %% loops of parameters
    for n1 = 1:length(m)
       % n1
        for n2 = 1:length(s)
            for n3 = 1:length(alpha)
    
                % perform the Dynamic Belief Model
                flag.Nr = 1000;
                flag.pmean = m(n1);
                flag.pmean_e = 0.125; % not used (p(error) branch not analyzed here)
                flag.bscale = s(n2); 
                flag.bscale_e = 10; % not used (p(error) branch not analyzed here)
                flag.alpha = alpha(n3);
                flag.alpha_e = 0.2; % not used (p(error) branch not analyzed here)
                flag.esttype = 'bayes';
                %flag.esttype = 'map';
                [pstop, ~] = ji_seqeff_get_pstop_perror(vc,flag);
                fprintf('Subj#%d: P(stop) mean=%2.4f, std=%2.4f \n',nSub,mean(pstop),std(pstop));
                % NOTE: p_mean/p_std just hold the last (n1,n2,n3) combo tried,
                % not a summary over the whole sweep - only useful for a quick sanity check.
                p_mean(nSub) = mean(pstop);
                p_std(nSub) = std(pstop);


                %% go-RT & p(stop)
                goRT = rtVector(vc==1);
                % pstop(k) is the belief entering trial k (i.e. before trial k's
                % outcome is observed), so this lines up p(stop) with the RT it
                % should predict without leaking in that trial's own outcome.
                goRT_pstop = pstop(vc==1);


                % exclude the error responses...
                goRT_pstop(goRT<100)=[];
                goRT(goRT<100)=[];


                %% GLM: goRT with pstop
                [r, p] = corr(goRT',goRT_pstop');
                fitRsquare_RT(n1,n2,n3)=r^2;
                fitCorr_RT(n1,n2,n3)=r;
                fitPval_RT(n1,n2,n3)=p;


            end
        end
    end
    res.fitRsquare_RT = fitRsquare_RT;
    res.fitCorr_RT = fitCorr_RT;
    res.fitPval_RT = fitPval_RT;
    res.id = fileName;
    [vmax imax] = max(fitCorr_RT(:)); % best-fitting parameter combo (by raw correlation, not R^2)
    [ipm,iscale,ialpha] = ind2sub(sizz,imax);
    res.rmax = fitCorr_RT(imax);
    res.pmax = fitPval_RT(imax);
    res.parmax = [m(ipm) s(iscale) alpha(ialpha)];
    save(['res_' fileName '_' flag.esttype '_' num2str(sizz(1)) 'x' num2str(sizz(2)) 'x' num2str(sizz(3))],'res');
    res;
end

% % these two lines only reflect the last parameter combo tested for each
% % subject (see note above) - not an average over the sweep
% mean(p_mean)
% mean(p_std)