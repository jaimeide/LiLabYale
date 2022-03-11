function ji_utils_slope_twins(group,index,set2run)
    %% Set variables to compute
    iix = group{index}.iix;
    iroi = group{index}.iroi;
    vDZ = group{index}.vDZ;
    vMZ = group{index}.vMZ;
    notF = group{index}.notF;
    
    set2runx = [];
    
    i=1; set2runx{i}.iSex = iix ; set2runx{i}.reg = set2run{i}.reg(iix); set2runx{i}.reg_label = 'adhd_t';
    if index==1
        i=2; set2runx{i}.iSex = iix ; set2runx{i}.reg = set2run{iroi(1)}.gmv(iix)'; set2runx{i}.reg_label = set2run{iroi(1)}.gmv_label; %
        i=3; set2runx{i}.iSex = iix ; set2runx{i}.reg = set2run{iroi(2)}.gmv(iix)'; set2runx{i}.reg_label = set2run{iroi(2)}.gmv_label; %
    else
        i=2; set2runx{i}.iSex = iix ; set2runx{i}.reg = set2run{iroi}.gmv(iix)'; set2runx{i}.reg_label = set2run{iroi}.gmv_label; %
    end
    
    
    resout = [];
    for i=1:length(set2runx)
        
        % UPDATE
        iSex = set2runx{i}.iSex;
        reg = set2runx{i}.reg;
        reg_label = set2runx{i}.reg_label;
        
        fprintf('\n*********** %s ************ \n', reg_label);
        
        % SLOPE TEST WITHIN TWIN PAIRS
        yesPlotSlope = 0;
        plot_3in1 = 1;
        xlabel = 'Subject 1';
        ylabel = 'Subject 2';
        ttitle = reg_label;
        
        %% MZ x DZ
        % Pair 1
        vx1 = reg(vMZ(:,1));
        vy1 = reg(vMZ(:,2));
        % Pair 2
        vx2 = reg(vDZ(:,1));
        vy2 = reg(vDZ(:,2));
        labels = {'MZ','DZ'};
        [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2);
        % Store to print later
        resout{i}.title = ttitle;
        ii = 1; 
        resout{i}.pair{ii}.labels = labels;
        resout{i}.pair{ii}.resp_slope = resp_slope;
        resout{i}.pair{ii}.corr1 = corr1;
        resout{i}.pair{ii}.corr2 = corr2;
        
        multiple_samples = 1;
        vxnotF = [];
        vynotF = [];
        if multiple_samples
            
            for k = 1:100
                %% MZ x Unrelat
                % Pair 1
                vx1 = reg(vMZ(:,1));
                vy1 = reg(vMZ(:,2));
                % Pair 2
                iaux = randperm(length(notF));
                ihalf = fix(length(notF)/2);
                vx2 = reg(notF(iaux(1:ihalf)));
                vy2 = reg(notF(iaux(ihalf+1:2*ihalf)));
                labels = {'MZ','Unrelated'};
                [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2);
                rslopeMZxUn(k) = resp_slope.t;
                pslopeMZxUn(k) = resp_slope.p;
                rcorrUn(k) = corr2.r;
                pcorrUn(k) = corr2.p;
                corrMZ = corr1;
                %% DZ x Unrelat
                % Pair 1
                vx1 = reg(vDZ(:,1));
                vy1 = reg(vDZ(:,2));
                % Pair 2
                %iaux = randperm(length(notF));
                %ihalf = fix(length(notF)/2);
                vx2 = reg(notF(iaux(1:ihalf)));
                vy2 = reg(notF(iaux(ihalf+1:2*ihalf)));
                labels = {'DZ','Unrelated'};
                [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2);
                corrDZ = corr1;
                rslopeDZxUn(k) = resp_slope.t;
                pslopeDZxUn(k) = resp_slope.p;
                % Store all notF vector
                vxnotF = [vxnotF; vx2];
                vynotF = [vynotF; vy2];
                
            end
            % Store to print later (MZxUn): median over 100 samples for the unrelated
            resout{i}.title = ttitle;
            ii = 2; % MZ x Un
            resout{i}.pair{ii}.labels = {'MZ','Unrelated'};
            resp_slopex.r = median(rslopeMZxUn);
            resp_slopex.p = median(pslopeMZxUn);
            resout{i}.pair{ii}.resp_slope = resp_slopex;
            corr2.r = median(rcorrUn);
            corr2.p = median(pcorrUn);
            resout{i}.pair{ii}.corr1 = corrMZ;
            resout{i}.pair{ii}.corr2 = corr2;
            
            % Store to print later (DZxUn): median over 100 samples for the unrelated
            ii = 3; % DZ x Un
            resout{i}.pair{ii}.labels = {'DZ','Unrelated'};
            resp_slopex.r = median(rslopeDZxUn);
            resp_slopex.p = median(pslopeDZxUn);
            resout{i}.pair{ii}.resp_slope = resp_slopex;
            corr2.r = median(rcorrUn);
            corr2.p = median(pcorrUn);
            resout{i}.pair{ii}.corr1 = corrDZ;
            resout{i}.pair{ii}.corr2 = corr2;
            
        else
            %% MZ x Unrelat
            
            % Pair 1
            vx1 = reg(vMZ(:,1));
            vy1 = reg(vMZ(:,2));
            % Pair 2
            iaux = randperm(length(notF));
            ihalf = fix(length(notF)/2);
            vx2 = reg(notF(iaux(1:ihalf)));
            vy2 = reg(notF(iaux(ihalf+1:2*ihalf)));
            labels = {'MZ','Unrelated'};
            [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2);
            % Store to print later
            ii = 2;
            resout{i}.pair{ii}.labels = labels;
            resout{i}.pair{ii}.resp_slope = resp_slope;
            resout{i}.pair{ii}.corr1 = corr1;
            resout{i}.pair{ii}.corr2 = corr2;
            
            %% DZ x Unrelat
            
            % Pair 1
            vx1 = reg(vDZ(:,1));
            vy1 = reg(vDZ(:,2));
            % Pair 2
            %iaux = randperm(length(notF));
            %ihalf = fix(length(notF)/2);
            vx2 = reg(notF(iaux(1:ihalf)));
            vy2 = reg(notF(iaux(ihalf+1:2*ihalf)));
            labels = {'DZ','Unrelated'};
            [resp_slope, corr1, corr2] = ji_utils_run_slopeTest2022(vx1,vy1,vx2,vy2);
            % Store to print later
            ii = 3;
            resout{i}.pair{ii}.labels = labels;
            resout{i}.pair{ii}.resp_slope = resp_slope;
            resout{i}.pair{ii}.corr1 = corr1;
            resout{i}.pair{ii}.corr2 = corr2;
        end
        
    end
    fprintf('Regressor \t\t Pair \t Slope-T \t Slope-pvalue \t Corr1 \t Corr2 \n');
    for r=1:length(resout)
        rsel = r;
        ii=1;fprintf('%s \t\t MZxDZ  \t %2.2f \t %1.4e \t Corr1(%s): r=%1.4f, p=%1.4e \t Corr2(%s): r=%1.4f, p=%1.4e \n',resout{rsel}.title ,resout{rsel}.pair{ii}.resp_slope.t,resout{rsel}.pair{ii}.resp_slope.p,resout{rsel}.pair{ii}.labels{1},resout{rsel}.pair{ii}.corr1.r,resout{rsel}.pair{ii}.corr1.p,resout{rsel}.pair{ii}.labels{2},resout{rsel}.pair{ii}.corr2.r,resout{rsel}.pair{ii}.corr2.p);
        ii=2;fprintf('%s \t\t MZxUnr \t %2.2f \t %1.4e \t Corr1(%s): r=%1.4f, p=%1.4e \t Corr2(%s): r=%1.4f, p=%1.4e \n',resout{rsel}.title,resout{rsel}.pair{ii}.resp_slope.r,resout{rsel}.pair{ii}.resp_slope.p,resout{rsel}.pair{ii}.labels{1},resout{rsel}.pair{ii}.corr1.r,resout{rsel}.pair{ii}.corr1.p,resout{rsel}.pair{ii}.labels{2},resout{rsel}.pair{ii}.corr2.r,resout{rsel}.pair{ii}.corr2.p);
        ii=3;fprintf('%s \t\t DZxUnr \t %2.2f \t %1.4e \t Corr1(%s): r=%1.4f, p=%1.4e \t Corr2(%s): r=%1.4f, p=%1.4e \n',resout{rsel}.title,resout{rsel}.pair{ii}.resp_slope.r,resout{rsel}.pair{ii}.resp_slope.p,resout{rsel}.pair{ii}.labels{1},resout{rsel}.pair{ii}.corr1.r,resout{rsel}.pair{ii}.corr1.p,resout{rsel}.pair{ii}.labels{2},resout{rsel}.pair{ii}.corr2.r,resout{rsel}.pair{ii}.corr2.p);
        fprintf('\n');
    end
end