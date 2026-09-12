%%% code for updating the distribution over the bernoulli parameter $r$. 
% Input: distribution before current trial, current binary obs ($obs)
% a "reset probability" alpha, and a "prior" distribution to reset to.
% (both distributions are discretized representations.)

function [bayes_r map_r rdist_post] = rdist_update(rdist_pre, obs, betaprior, alpha)

global params; % model-specific code; ignore.
if nargin < 4; alpha = params.rdist.alpha; end;

rdist_post = compute_rpost(rdist_pre, obs, betaprior,alpha);
bayes_r = getBayesEst(rdist_post);

map_r = getMAPest(rdist_post);
% if abs(map_r - bayes_r) > 0.01; % dbg
% 	% disp(['Est diff:' num2str(map_r-bayes_r)]);
% end;

return;

function map_r = getMAPest(rdist);
    map_r = find(max(rdist) == rdist);
    map_r = map_r(1)/(length(rdist)-1);
return;

function bayes_r = getBayesEst(rdist);
    N = length(rdist)-1;
    prob = [0:N]/N;
    bayes_r = sum(prob.*rdist);
return;



%% sequential nonstationary update (DBM, yu/cohen09).
% straightforward numerical calculations:
% 1. discretized representation of estimated pdf for bernoulli parameter $r$
% 2. 0/1 observation on current trial
% 3. probability of "reset" $alpha$, to a distribution $betaprior$
% normalize and return discretized/approximate posterior distribution.

function rdist_post = compute_rpost(rdist_pre, obs_t, betaprior, alpha);

rdist_pre = rdist_pre(:)';

Nr = length(rdist_pre)-1;

% possibly resample from prior.
% p(rt|x1..t-1) = (1-alpha)*p(rt-1|x1..t-1) + alpha*p0(rt);
newp_r = (1-alpha)*rdist_pre + (alpha)*betaprior;
newp_r = newp_r/sum(newp_r); % normalize (is this step necessary?)

% compute likelihood of current obs
% P(xt|rt) = xt.*rt + (1-xt).*(1-rt);
x=[0:Nr]/Nr;
obslik = obs_t*x + (1-obs_t)*(1-x);

%% update with current data point.
% p(rt|x1..t) = p(xt|rt).*p(rt|x1..t-1); 
% p(rt|x1..t) = p(rt|x1..t)/sum(p(rt|x1..t));

rdist_post = newp_r.*obslik;  %% the equals should be proportional
rdist_post = rdist_post./sum(rdist_post); % normalize.

% % jaime.ide to understand...
% figure(3)
% rr = 0:0.001:1;
% plot(rr,rdist_pre,'k'); title('Empirical prior'); 
% plot(rr,betaprior,'b'); title('Fixed prior: Beta(mean=0.25,scale=10)');
% plot(rr,newp_r,'g'); title('Updated prior: p(belief) = alpha*(p_{empirical}) + (1-alpha)*p_{fixed}');
% plot(rr,rdist_post,'r'); title('Posterior: p(belief/data) = p(data/belief)*p(belief)');
% hold off;
% 
% figure(4)
% rr = 0:0.001:1;
% plot(rr,rdist_pre,'k'); hold on;
% plot(rr,betaprior,'b');
% plot(rr,newp_r,'g');
% plot(rr,rdist_post,'r');
% legend('p_{empirical}','prior_{fixed}','p_{belief}','p_{posterior}');
% hold off;
return;
