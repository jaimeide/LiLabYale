function resp = ji_utils_regress(y,x)

%fprintf('(*) Note: dependent variable first (y)!!\n');

xx = 0;
xy = 0;
yy = 0;
aa = x(:);
bb = y(:);
for i=1:length(aa),
    xx = xx + (aa(i)-mean(aa))^2;
    xy = xy + (aa(i)-mean(aa))*(bb(i)-mean(bb));
    yy = yy + (bb(i)-mean(bb))^2;
end

%     yy = 13299.5296
%     xx = 1470.8712
%     xy = 4363.1627
res_ss =  yy - (xy^2/xx);
res_df = length(x)-2;

resp.xx = xx;
resp.xy = xy;
resp.yy = yy;
resp.res_ss = res_ss;
resp.res_df = res_df;