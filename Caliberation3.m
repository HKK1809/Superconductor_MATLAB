%Superconductivity Caliberation PArt 3
%Importing values

coil_V = Lab2DataS2(:,1); % Coil current (A)
coil_V = table2array(coil_V);
hall_V = Lab2DataS2(:,2); % Hall Pontetial (V)
hall_V = table2array(hall_V);

a = 0;
for i = 1:589
    if ((-0.01 > coil_V(i)) &&(coil_V(i) > -4.8))
        a = a+1;
        V_coil(a) = coil_V(i);
        V_hall(a) = hall_V(i);
    else if((0.01 < coil_V(i))&&( coil_V(i) < 4.8))
            a = a+1;
            V_coil(a) = coil_V(i);
            V_hall(a) = hall_V(i);
        end
    end
end
V_coil = transpose(V_coil);
%V_hall = transpose(V_hall);
err_V = 0.04*ones(size(V_hall));
[F,gof,fit_F] = fit( V_coil, V_hall, '(m*x)+b');

% Extract weighted jacobian
    J_F = fit_F.Jacobian;
    
    %Get the covariance and curvature matrix and extract the errors on F
    %parameters from there.
    curvature_matrix_F = J_F'*J_F;
    covariance_matrix_F = inv(curvature_matrix_F);
    
    % Calculate CHI_squared
    min_chi2_F = gof.sse;
    dof_F = gof.dfe;
    
    reduced_chi2_F = min_chi2_F/dof_F;
    
    err_F_m = covariance_matrix_F(1,1);

plot (F,V_coil, V_hall)
hold on;
errorbar(V_coil, V_hall, err_V,'horizontal',"k.",'HandleVisibility','off')
errorbar(V_coil, V_hall, err_V,'vertical',"k.",'HandleVisibility','off')
xlabel('Coil Potential (V)','FontSize',18);
ylabel('Hall Potential (V)','FontSize',18);
legend('Slope = 0.212 +/- 0.003 ','FontSize',18)
title ('Variation in Hall Potential as a function of Coil Potnetial at 77 Kelvin','FontSize',18)
