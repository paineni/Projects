%% pc1_raw_data
 T1=pc1_data.TWF_raw(1,:);
 Klicker1=pc1_data.TWF_raw(2,:);
 z_table=pc1_data.TWF_raw(3,:);
 x_spindle=pc1_data.TWF_raw(4,:);
 y_spindle=pc1_data.TWF_raw(5,:);
 z_spindle=pc1_data.TWF_raw(6,:);
 fs=50000;
%  figure(1)
%  subplot(3,3,2)
%  plot(T1,Klicker1,'-');
%  subplot(3,3,3)
%  plot(T1,z_table,'-');
%  subplot(3,3,4)
%  plot(T1,x_spindle,'-');
%  subplot(3,3,5)
%  plot(T1,y_spindle,'-');
%  subplot(3,3,6)
%  plot(T1,z_spindle,'-');
 %% pc2_raw_data
 T2=pc2_data.TWF_raw(1,:);
 Klicker2=pc2_data.TWF_raw(2,:);
 y_table=pc2_data.TWF_raw(3,:);
 x_table=pc2_data.TWF_raw(4,:);
 spindle=pc2_data.TWF_raw(5,:);
%  figure(2)
%  subplot(2,2,1)
%  plot(T2,Klicker2,'-');
%  subplot(2,2,2)
%  plot(T2,y_table,'-');
%  subplot(2,2,3)
%  plot(T2,x_table,'-');
%  subplot(2,2,4)
%  plot(T2,spindle,'-');
 
 f=fs*(0:length(T1)-1)/length(T1);
 %% Aligning Klickers Data
k=find(Klicker1);
l=find(Klicker2);
m=Klicker1(k);
n=Klicker2(l);

T1_new= T1-(T1(k(1))-T1(l(1)));
% figure(3)
% plot(T1_new,Klicker1,'-');
% hold on
% plot(T2,Klicker2,':');

% Kalman Filter
 



%% estimation of S based on observations X

% % initialize
N= length(T2);
% State  = zeros(1,N+1);
% StateP =zeros(1,N+1); % prediced state
% M =     zeros(1,N+1); % 
% Mp=     zeros(1,N+1); % predicted covriance
% K=      zeros(1,N+1); % Kalman gain
% 
% M(1)=1;
% for t=2:N+1
%     StateP(t)=a*State(t-1); % predic
%     Mp(t)=(a^2)*M(t-1) + sigma2_u; % covariance of prediction
%     K(t)=Mp(t)/(sigma2_w^(t-2)+Mp(t));% Kalman gain
%     M(t)=(1-K(t))*Mp(t); 
%     State(t)=StateP(t)+K(t)*(y_table(t-1)-StateP(t)); % update 
% end
% %%
% % subplot(1,3,1)
% % plot(K(2:N+1))
% % legend('Kalman Gain');
% % xlabel('time, n')
% % ylabel('K')
% % 
% % subplot(1,3,2)
% % plot(M(2:N+1),'r');
% % legend('Mean Square Error');
% % xlabel('time, n')
% % ylabel('MSE')
% 
% figure(4)
% subplot(2,1,1)
% plot(T2,y_table,'b')
% subplot(2,1,2)
% plot(T2,State(2:N+1),'r')
% legend('Actual signal','Estimated signal');
% xlabel('time, n')
% ylabel('signal')

Q = 10;
R = 0.2;
A = 1;
T_start = y_table(1);
P_start = 1;
T_kalman(1) = T_start; 
P_kalman(1) = P_start;
for k = 2:N
    T_pre(k) = A * T_kalman(k-1);
    P_pre(k) = P_kalman(k-1) + Q;
    K(k) = P_pre(k) / (P_pre(k) + R);
    T_kalman(k) = T_pre(k) + K(k) * (y_table(k)-T_pre(k));
    P_kalman(k)=P_pre(k)-K(k)*P_pre(k);
end
% figure(4);
% subplot(2,1,1);
% plot(T2,T_kalman, 'r');
% hold on
% subplot(2,1,2);
% plot(T2,y_table, 'g');
% hold on

fft_filter = abs(fft(T_kalman));
y = abs(fft(y_table));

figure(5);
subplot(2,1,1);
plot(f,fft_filter, 'r');

subplot(2,1,2);
plot(f,y, 'g');


