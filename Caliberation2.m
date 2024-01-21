I = Lab2DataS1(:,1); % Coil current (A)
I = table2array(I);
err_I = (0.02*I) + 0.002;
V = Lab2DataS1(:,2); % Hall Pontetial (V)
V = table2array(V);
err_V = 0.04*ones(size(V));
[F, gof, F_output] = fit(I, V, '(m*x)+b');

% Extract weighted jacobian
    J_F = F_output.Jacobian;
    
    %Get the covariance and curvature matrix and extract the errors on F
    %parameters from there.
    curvature_matrix_F = J_F'*J_F;
    covariance_matrix_F = inv(curvature_matrix_F);
    
    % Calculate CHI_squared
    min_chi2_F = gof.sse;
    dof_F = gof.dfe;
    
    reduced_chi2_F = min_chi2_F/dof_F;
    
    err_F_m = covariance_matrix_F(1,1);

figure(1)
plot(F,I,V)
hold on;
errorbar(I, V, err_I,'horizontal',"k.",'HandleVisibility','off')
errorbar(I, V, err_V,'vertical',"k.",'HandleVisibility','off')
xlabel('Coil Current (A)','FontSize',18);
ylabel('Hall Potential (V)','FontSize',18);
legend('Slope = 3.51 +/- 0.06 V/A','FontSize',18)
title ('Variation in Hall Potential as a function of Coil Current at 77 Kelvin','FontSize',18)