close all
    clear all
    clc

    %defining variables
    N = 1; % N value is Group Number
    d_km = 50; % Distance between two planes in km
    cable_loss_tx = .8; % Transmitting cable loss in dB
    cable_loss_rx = .8; % Receiving cable loss in dB
    fc = (0.9 + (N*0.05)); % Carrier frequency
    Gt =(1.10 + (N*0.05)); % Transmitting antenna gain in dBi
    Gr = (1.10 + (N*0.05)); % Receiving antenna gain in dBi
    N_fig = 6; % Receiver noise figure
    rec_BW = 50*10^3; % Receiver bandwidth
    Tempr = 243; % Ambient temperature
    k_bol_cons=1.3803*10^-23; % Boltzman constant J/K
    fade_mar = 38; % Fade margin
    C_N_ratio = 17; % Receiver SNR (15~20) dB

    % Free space path loss
    L_dB_km=92.4+20*log10(fc)+20*log10(d_km);

    % Noise threshold at the output end of the receiver
    N_thres_dBW=10*log10(k_bol_cons*Tempr*rec_BW)+N_fig;

    % Received power sensitivity
    Pr_sen_dB = C_N_ratio + N_thres_dBW;

    % Calculating the EIRP
    EIRP_dBW = Pr_sen_dB + (L_dB_km+fade_mar) - Gr + cable_loss_rx;




    % Output
    disp(['EIRP = ', num2str(EIRP_dBW)]);
    disp(' ');
    disp(['Antenna Gain = ', num2str(Gt)]);
    disp(' ');
    disp(['Free-Space-Loss = ', num2str(L_dB_km)]);
    disp(' ');
    disp(['Fading Margin = ', num2str(fade_mar)]);
    disp(' ');
    disp(['Receiver Sensitivity = ', num2str(Pr_sen_dB)]);
    disp(' ');
    disp(['Noise Figure = ', num2str(N_fig)]);
    disp(' ');
    % Calculating the Transmit power
    Pt = EIRP_dBW + cable_loss_tx - Gt; %in dBW       
                                                                                                                                                                                                                                           Pt_abs = 10^(Pt/10); %in watt
   
% Link budget
LB1=Pt;
LB2=LB1-cable_loss_tx;
LB3=EIRP_dBW;
LB4=LB3-L_dB_km-fade_mar;
LB5=LB4+Gr;
LB6=LB5-cable_loss_rx;
LB7=C_N_ratio;
Link_Budget=[LB1 LB2 LB3 LB4 LB5 LB6 LB7];
plot(Link_Budget);
xlabel('distance')
ylabel('Powerlevel (dbm)')
grid on
