%%  generate a distribution for the bernoulli rate parater $r$,
% as a broad beta distribution with mean $r0$. used as a prior
% distribution. Dist is returned in discretized form of size N.

function betaprior = getprior_r(rzero, N, bscale)

%if nargin <1
%    rzero = 0.2;
%    N = 100;
%end

if nargin < 3; bscale = 10; end;

betaprior = pdf('beta', [0:N]/N, rzero*bscale+1, (1-rzero)*bscale+1); % Pradeep's original implementation... (CORRECT ONE! TO HAVE THE PEAK AT PRIOR MEAN)
%betaprior = pdf('beta', [0:N]/N, rzero*bscale, (1-rzero)*bscale); % Standard convetion mean=a/(a+b) and scale=(a+b)
betaprior = betaprior/sum(betaprior);

%figure;
%plot([0:N]/N,betaprior); grid on;
%[v,i] = max(betaprior)
%t = [0:N]/N;
%title(sprintf('mean=%2.2f, meanBeta=%2.2f',t(i),mean(betaprior)));

return;

