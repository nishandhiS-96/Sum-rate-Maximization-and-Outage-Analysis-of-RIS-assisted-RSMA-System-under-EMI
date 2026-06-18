function [SNR_nonoise_vett, SNR_noise_vett,SNR_nonoise_vett_THETA, SNR_noise_vett_THETA] = function_SNR_v2(N,K,Power,SigmaW2,Sigma2A,R,Rh1_sqrt,Rh2_sqrt,betaHd)


% This function computes K times the istantaneous SNR receiving a input the following
% N: the number of array elements
% K: the number of channel realizations
% Power: the scalar value of the transmitted power
% SigmaW2: the scalar value of the thermal noise power
% Sigma2A: the scalar value of the EMI magnitude times the RIS element area
% Rn: the correlation matrix of the EMI
% Rh1_sqrt: the first user channel root correlation matrix
% Rh2_sqrt: the second user channel root correlation matrix
% betaHd: the average magnitude of the direct link amplitude

SNR_nonoise_vett = zeros(K,1);
SNR_noise_vett = zeros(K,1);
SNR_nonoise_vett_THETA = zeros(K,1);
SNR_noise_vett_THETA = zeros(K,1);

Nt=2;
N_user = 2;

for k = 1:K
    h1 = sqrt(.5)*(Rh1_sqrt)*(randn(N,Nt) + 1j*randn(N,Nt)); % BS to IRS - G


    h2 = sqrt(.5)*(Rh2_sqrt)*(randn(N,1) + 1j*randn(N,1)); % IRS to user 1 - h(2,1)
    h2r = sqrt(.5)*(Rh2_sqrt)*(randn(N,1) + 1j*randn(N,1));

    hd = sqrt(.5)*(sqrt(betaHd))*(randn(Nt,1) + 1j*randn(Nt,1)); % BS to user 1 - h(d,1)
    hdr = sqrt(.5)*(sqrt(betaHd))*(randn(Nt,1) + 1j*randn(Nt,1));

    theta_p1 = exp(1i*2*pi.*rand(N,1));
    theta_p2 = exp(1i*2*pi.*rand(N,1));

    h_eff_1 = h2'*diag(theta_p1)*h1 + hd';
    h_eff_2 = h2r'*diag(theta_p2)*h1 + hdr';

%%
    H_tot_eff = [h_eff_1' h_eff_2'];
    P_common_eff = Power * 0.6;
    P_private_k_eff = (Power-P_common_eff)/N_user;
    [U2,~,~] = svd (H_tot_eff);
    hat_p_c_eff = U2(:,1);

    w1=(h_eff_1)' / norm(h_eff_1)* sqrt(P_private_k_eff);
    w2=(h_eff_2)' / norm(h_eff_2)* sqrt(P_private_k_eff);
    wc = hat_p_c_eff*sqrt(P_common_eff);

    Phi_0_p1 = angle(hd'*w1);
    Phi_0_p2 = angle(hdr'*w2);
    for kk = 1:K
        theta_p1 = zeros(N,1);
        theta_p2 = zeros(N,1);
         for n=1:N
        theta_p1(n)=Phi_0_p1+angle(h2(n))-angle(h1(n,:)*w1);
        theta_p2(n)=Phi_0_p2+angle(h2r(n))-angle(h1(n,:)*w2);
         end
        Theta_p1 = diag(exp(1i*theta_p1));
        Theta_p2 = diag(exp(1i*theta_p2));
        h_eff_1 = h2'*(Theta_p1)*h1 + hd';
        h_eff_2 = h2r'*(Theta_p2)*h1 + hdr';

        H_tot_eff = [h_eff_1' h_eff_2'];
        P_common_eff = Power * 0.9;
        P_private_k_eff = (Power-P_common_eff)/N_user;
        [U2,~,~] = svd (H_tot_eff);
        hat_p_c_eff = U2(:,1);
        % Design of MRT
        w1=(h_eff_1)' / norm(h_eff_1)* sqrt(P_private_k_eff);
        w2=(h_eff_2)' / norm(h_eff_2)* sqrt(P_private_k_eff);
        wc = hat_p_c_eff*sqrt(P_common_eff);
        
        Phi_0_p1 = angle(hd'*w1);
        Phi_0_p2 = angle(hdr'*w2);
        % Phi_0_pc = angle(h_sd_1'*W_C + h_sd_2'*W_C);

        %%

        T_1=abs(h_eff_1*w1)^2+abs(h_eff_1*w2)^2+SigmaW2;
        T_2=abs(h_eff_2*w1)^2+abs(h_eff_2*w2)^2+SigmaW2;
        T_c_1=abs(h_eff_1*wc)^2+T_1;
        T_c_2=abs(h_eff_2*wc)^2+T_2;
        I_1=T_1-abs(h_eff_1*w1)^2;
        I_2=T_2-abs(h_eff_2*w2)^2;

        R_c_1=(T_c_1/T_1);
        R_c_2=(T_c_2/T_2);

        %Private Rate
        R_1=(T_1/I_1);
        R_2=(T_2/I_2);

        % Capacity_1(k)=R_1+min(R_c_1,R_c_2);
        % Capacity_2(k)=R_2;

        %%
        %% With EMI
    T_1_E=abs(h_eff_1*w1)^2+abs(h_eff_1*w2)^2+(Sigma2A*((diag(theta_p1')*h2)'*R*(diag(theta_p1')*h2)) + SigmaW2);
    T_2_E=abs(h_eff_2*w1)^2+abs(h_eff_2*w2)^2+(Sigma2A*((diag(theta_p1')*h2)'*R*(diag(theta_p1')*h2)) + SigmaW2);
    T_c_1_E=abs(h_eff_1*wc)^2+T_1_E;
    T_c_2_E=abs(h_eff_2*wc)^2+T_2_E;
    I_1_E=T_1_E-abs(h_eff_1*w1)^2;
    I_2_E=T_2_E-abs(h_eff_2*w2)^2;

    R_c_1_E=(T_c_1_E/T_1_E);
    R_c_2_E=(T_c_2_E/T_2_E);

    %Private Rate
    R_1_E=(T_1_E/I_1_E);
    R_2_E=(T_2_E/I_2_E);

    % Capacity_1(k)=R_1+min(R_c_1,R_c_2);
    % Capacity_2(k)=R_2;
    end


    SNR_nonoise_vett(k) = Power*abs(R_1+min(R_c_1,R_c_2));
    SNR_noise_vett(k) = Power*abs(R_1_E+min(R_c_1_E,R_c_2_E)); %Power*sum(abs(h.*g)+abs(hd),1).^2./((g'*betaN*g) + Sigma2);
     
    
end

end

