%Superconductivity 
%Importing values

coil_V = Lab2DataS3(:,2); % Coil current (A)
coil_V = table2array(coil_V);
hall_V = Lab2DataS3(:,3); % Hall Pontetial (V)
hall_V = table2array(hall_V);
Vch = 0.2121; % Vc/Vh for caliberation 3
err_Vch = 0;
figure (1)
plot (coil_V, hall_V)

mcal2 = 3.5141; % Vc/Ic for caliberation 2
err_mcal2 = 0.06;
mcal1 = 0.034669339; % B/I for caliberation 1
err_mcal1 = 0.03;
mcal3 = 0.212;
err_mcal3 = 0.003;

Bint = hall_V*Vch*mcal1/mcal2;
Bapp = coil_V*mcal1/mcal2;

err_int = sqrt(((0.0016.*mcal1./(mcal2.*mcal3)).^2)+((hall_V.*err_mcal1./(mcal2.*mcal3)).^2)+ ...
    ((hall_V.*mcal1.*err_mcal2./(mcal2.*mcal2.*mcal3)).^2)+((hall_V.*mcal1.*err_mcal3./(mcal2.*mcal3.*mcal3)).^2));
err_app = sqrt(((0.0016.*mcal1./mcal2).^2)+((coil_V.*err_mcal1./mcal2).^2)+((coil_V.*mcal1.*err_mcal2./(mcal2.*mcal2)).^2));

figure (2)
plot (Bapp, Bint)
hold on
errorbar(Bapp, Bint, err_app,'horizontal',"k.",'HandleVisibility','off')
hold on 
errorbar(Bapp, Bint, err_int,'vertical',"k.",'HandleVisibility','off')
hold on
xlabel('Magnetic Field Applied (T)','FontSize',18);
ylabel('Magnetic Field Interinsic (T)','FontSize',18);
title ('Variation in Interinsic magnetic field against Applied magnetic field at 77 Kelvin with a superconductor covering','FontSize',18)

