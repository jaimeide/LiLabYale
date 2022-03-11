 function resp = ji_utils_comp_regress(r1,r2)

if(nargin<1)
    r1.xx = 1470.8712;
    r1.xy = 4363.1627;
    r1.yy = 13299.5296;
    r1.res_ss = 356.7317;
    r1.res_df = 24;
    
    r2.xx = 2272.4750;
    r2.xy = 4928.81;
    r2.yy = 10964.0947;
    r2.res_ss = 273.9142;
    r2.res_df = 28;
    
end

    ss = (r1.res_ss + r2.res_ss)/(r1.res_df + r2.res_df);
    s_b1_b2 = sqrt(ss/r1.xx + ss/r2.xx);

    b1 = r1.xy/r1.xx;
    b2 = r2.xy/r2.xx;
    t = (b1-b2)/s_b1_b2;
    t = abs(t);
    df = r1.res_df + r2.res_df;
    p = 2*(1-tcdf(t,df)); % 2-tails t-test!!
    
    %%zz
    
    resp.t = t;
    resp.p = p;
    resp.df = df;
    resp.info = 'Use 2-tails t-Student test';