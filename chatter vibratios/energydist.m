
clear var
clc
load vmd;
E=trapz(y_spindle.^2);
E_imfs=trapz(imfs.^2);
energyratio=E_imfs/E;

x_axis=categorical({'u1','u2','u3','u4','u5','u6','u7','u8','u9'});
bar(x_axis,energyratio)
rms(imfs(:,9))
figure(2)
subplot(2,1,1)
plot(T1,imfs(:,9));
subplot(2,1,2)
plot(T1,y_spindle);
    





