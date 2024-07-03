close all
clc
clearvars
%% Read and plot the pointcloud

Pointcloud=xlsread('Point_Clouds.xlsx',3,'A:C');
x=Pointcloud(:,1);
y=Pointcloud(:,2);
z=Pointcloud(:,3);
centroid=[mean(x),mean(y),mean(z)];
figure(1);
plot3(x,y,z,'k.');
xlabel('x')
ylabel('y')
zlabel('z')
title('Given point cloud without axis')


%% Applying Principal Component Analysis to get the direction

[coeff,score,latent,tsquared] = pca(Pointcloud);
[maxvar,Index]=max(latent);
newcomponents=coeff*15;
figure(2);
subplot(1,2,1)%plotting the axis direction about the centroid 
plot3([centroid(1,1)-newcomponents(1,Index),centroid(1,1),centroid(1,1)+newcomponents(1,1)],[centroid(1,2)-newcomponents(2,1),centroid(1,2),centroid(1,2)+newcomponents(2,1)],[centroid(1,3)-newcomponents(3,1),centroid(1,3),centroid(1,3)+newcomponents(3,1)],'linewidth',5);
hold on
plot3(x,y,z,'k.')
plot3([centroid(1,1)-newcomponents(1,2),centroid(1,1),centroid(1,1)+newcomponents(1,2)],[centroid(1,2)-newcomponents(2,2),centroid(1,2),centroid(1,2)+newcomponents(2,2)],[centroid(1,3)-newcomponents(3,2),centroid(1,3),centroid(1,3)+newcomponents(3,2)],'linewidth',5);
plot3([centroid(1,1)-newcomponents(1,3),centroid(1,1),centroid(1,1)+newcomponents(1,3)],[centroid(1,2)-newcomponents(2,3),centroid(1,2),centroid(1,2)+newcomponents(2,3)],[centroid(1,3)-newcomponents(3,3),centroid(1,3),centroid(1,3)+newcomponents(3,3)],'linewidth',5);
xlabel('x')
ylabel('y')
zlabel('z')
title('Results of PCA')

%plot3(x,y,z,'k.');

%% Translating and Rotating the axis and the point cloud

B=[centroid(1,1)-newcomponents(1,1),centroid(1,2)-newcomponents(2,1),centroid(1,3)-newcomponents(3,1)];
A=[centroid(1,1)+newcomponents(1,1),centroid(1,2)+newcomponents(2,1),centroid(1,3)+newcomponents(3,1)];
% I want B to be shifte to origin
trans_X=[A(1,1)-B(1,1),B(1,1)-B(1,1)];
trans_Y=[A(1,2)-B(1,2),B(1,2)-B(1,2)];
trans_Z=[A(1,3)-B(1,3),B(1,3)-B(1,3)];
% subplot(2,2,2)
% axis equal
% plot3(trans_X,trans_Y,trans_Z,"r",'linewidth',3);
% hold on
% % Translating the whole pointcloud along with the axis
% plot3(x-B(1,1), y-B(1,2), z-B(1,3),'b.');
% plot3([-15,15],[0,0],[0,0],"k",'linewidth',3);
% plot3([0,0],[-15,15],[0,0],"g",'linewidth',3);
% plot3([0,0],[0,0],[-15,15],"b",'linewidth',3);
 ptX=x-B(1,1);
 ptY=y-B(1,2);
 ptZ=z-B(1,3);
% hold off

%Rotating the translated axis about y axis
Translated_point=[trans_X;trans_Y;trans_Z];
alpha=-atand(Translated_point(1,1)/Translated_point(3,1)); 
Rotation_Y=[cosd(alpha),0,sind(alpha);0,1,0;-sind(alpha),0,cosd(alpha)];
New_point=Rotation_Y*Translated_point;
yrot_x=New_point(1,:);
yrot_y=New_point(2,:);
yrot_z=New_point(3,:);

%Rotating point cloud about y axis
yPCR_X=ptX*cosd(alpha)+ptZ*sind(alpha);
yPCR_Y=ptY;
yPCR_Z=ptX*-sind(alpha)+ptZ*cosd(alpha);

%Plotting the point cloud and axis after rotating about Y axis 
% subplot(2,2,3)
% axis equal
% plot3(yrot_x,yrot_y,yrot_z,"r",'linewidth',5);
% hold on
% plot3([-15,15],[0,0],[0,0],"k",'linewidth',3);
% plot3([0,0],[-15,15],[0,0],"g",'linewidth',3);
% plot3([0,0],[0,0],[-15,15],"b",'linewidth',3);
% plot3(yPCR_X,yPCR_Y,yPCR_Z,"b.");
% hold off

%Rotation of axis about x axis to coincide about z axis
if New_point(2,1)>0 && New_point(3,1)<0
beta=180-atand(abs(New_point(2,1)/New_point(3,1)));
elseif New_point(2,1)<0 && New_point(3,1)<0
beta=180+atand(abs(New_point(2,1)/New_point(3,1)));
elseif New_point(2,1)>0 && New_point(3,1)>0
beta=atand(abs(New_point(2,1)/New_point(3,1)));
elseif New_point(2,1)<0 && New_point(3,1)>0
beta=-atand(abs(New_point(2,1)/New_point(3,1)));
end

Rotation_X=[1,0,0;0,cosd(beta),-sind(beta);0,sind(beta),cosd(beta)];
Req_point=Rotation_X*New_point;
Reqaxis_X=Req_point(1,:);
Reqaxis_Y=Req_point(2,:);
Reqaxis_Z=Req_point(3,:);

%rotation of point cloud about x axis after rotating it about y axis
ReqPC_X=yPCR_X;
ReqPC_Y=yPCR_Y*cosd(beta)-yPCR_Z*sind(beta);
ReqPC_Z=yPCR_Y*sind(beta)+yPCR_Z*cosd(beta);

%plotting Required Point cloud and axis
subplot(1,2,2)
axis equal
plot3(ReqPC_X,ReqPC_Y,ReqPC_Z,"g.");
hold on
plot3(Reqaxis_X,Reqaxis_Y,Reqaxis_Z,"b",'linewidth',5);
plot3([-15,15],[0,0],[0,0],"k",'linewidth',3);
plot3([0,0],[-15,15],[0,0],"k",'linewidth',3);
plot3([0,0],[0,0],[-15,15],"k",'linewidth',3);
xlabel('x')
ylabel('y')
zlabel('z')
title('Transformed Point Cloud')


%% Converting the 3D pointcloud to 2D pointcloud and plotting the 2D pointcloud
R= sqrt(ReqPC_X.^2 + ReqPC_Y.^2);
Z=ReqPC_Z(:,1);
%plotting the 2D pointcloud
figure(3)
plot(R,Z,'.');
hold on
plot([0,0],[0,28],'color',[0,0.5,0],'LineWidth',1.5)
plot([6.5,6.5],[0,28],'r-')
plot([0,15],[3,3],'r-')
plot([0,15],[8,8],'r-')
plot([0,15],[12,12],'r-')
plot([0,15],[16,16],'r-')
plot([0,15],[20,20],'r-')
plot([0,15],[23,23],'r-')
plot([0,15],[28,28],'r-')
axis equal
ylim([0 28])
xlim([-2 15])
xlabel('R')
ylabel('Z')
title('distance of all points to z-axis')

%% Range of movement
r=-1:5;
s=-1:5;
p=0.3:0.1:0.6; %Range of movement of the pointcloud in y direction
q=2:0.1:2.5;   %Range of movement of the pointcloud in x direction
pq=length(p)*length(q)*length(r)*length(s);

%% Initilization of variables
k=1; 
t=zeros(pq,4);

%% Checking the sum of variances at different positions and angles by dividing the 2D Pointcloud into 12 sections
for c=-1:5
    for d=-1:5
        for    u=0.3:0.1:0.6
            for    j=2:0.1:2.5
                Rot_X=[1,0,0;0,cosd(c),-sind(c);0,sind(c),cosd(c)];
                Rot_Y=[cosd(d),0,sind(d);0,1,0;-sind(d),0,cosd(d)];
                newpc_X=ReqPC_X-j;
                newpc_Y=ReqPC_Y-u;
                PC=[newpc_X,newpc_Y,ReqPC_Z];
                RPC=PC*Rot_X*Rot_Y;
                M= sqrt(RPC(:,1).^2 + RPC(:,2).^2);
                N=RPC(:,3); 
%                 v(k)=var(M);
                a=ones(12,1);
                %Division of sections
                for i=1:1:10000 
                    if 0<M(i)&& M(i)<7.5 && 3<N(i)&& N(i)<8
                        v1(a(1),1)=M(i);
                        v1(a(1),2)=N(i);
                        a(1)=a(1)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 3<N(i)&& N(i)<8
                        v2(a(2),1)=M(i);
                        v2(a(2),2)=N(i);
                        a(2)=a(2)+1;
                    elseif 0<M(i)&& M(i)<7.5 && 8<=N(i)&& N(i)<12 
                        v3(a(3),1)=M(i);
                        v3(a(3),2)=N(i);
                        a(3)=a(3)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 8<=N(i)&& N(i)<12
                        v4(a(4),1)=M(i);
                        v4(a(4),2)=N(i);
                        a(4)=a(4)+1;
                    elseif 0<M(i)&& M(i)<7.5 && 12<=N(i)&& N(i)<16
                        v5(a(5),1)=M(i);
                        v5(a(5),2)=N(i);
                        a(5)=a(5)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 12<=N(i)&& N(i)<16
                        v6(a(6),1)=M(i);
                        v6(a(6),2)=N(i);
                        a(6)=a(6)+1;
                    elseif 0<M(i)&& M(i)<7.5 && 16<=N(i)&& N(i)<20
                        v7(a(7),1)=M(i);
                        v7(a(7),2)=N(i);
                        a(7)=a(7)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 16<=N(i)&& N(i)<20
                        v8(a(8),1)=M(i);
                        v8(a(8),2)=N(i);
                        a(8)=a(8)+1;
                    elseif 0<M(i)&& M(i)<7.5 && 20<=N(i)&& N(i)<23
                        v9(a(9),1)=M(i);
                        v9(a(9),2)=N(i);
                        a(9)=a(9)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 20<=N(i)&& N(i)<23
                        v10(a(10),1)=M(i);
                        v10(a(10),2)=N(i);
                        a(10)=a(10)+1;
                    elseif 0<M(i)&& M(i)<7.5 && 23<=N(i)&& N(i)<28
                        v11(a(11),1)=M(i);
                        v11(a(11),2)=N(i);
                        a(11)=a(11)+1;
                    elseif 7.5<=M(i)&& M(i)<15 && 23<=N(i)&& N(i)<28
                        v12(a(12),1)=M(i);
                        v12(a(12),2)=N(i); 
                        a(12)=a(12)+1;
                    end
                end
                %calculating the variances at different positions
                v(k)=var(v1(:,1))+ var(v2(:,1))+var(v3(:,1))+var(v4(:,1))+var(v5(:,1))+var(v6(:,1))+var(v7(:,1))+var(v8(:,1))+var(v9(:,1))+var(v10(:,1))+var(v11(:,1))+var(v12(:,1));
                v1=[];v2=[];v3=[];v4=[];v5=[];v6=[];v7=[];v8=[];v9=[];v10=[];v11=[];v12=[];%clearing the array after ecah iteration
                
                %% Constructing the matrix containing all the positions within the range 
                t(k,1)=j;
                t(k,2)=u;
                t(k,3)=c;
                t(k,4)=d;
                if k<pq
                    k=k+1;
                end
            end
        end
    end
end

%% Checking at what position the variation is minimum and plotting the final 2D pointcloud
[b,I]=min(v);
RotF_X=[1,0,0;0,cosd(t(I,3)),-sind(t(I,3));0,sind(t(I,3)),cosd(t(I,3))];
RotF_Y=[cosd(t(I,4)),0,sind(t(I,4));0,1,0;-sind(t(I,4)),0,cosd(t(I,4))];
pc_X=ReqPC_X-t(I,1);
pc_Y=ReqPC_Y-t(I,2);
PCF=[pc_X,pc_Y,ReqPC_Z];
RPCF=PC*RotF_X*RotF_Y;
RX= sqrt(RPCF(:,1).^2 + RPCF(:,2).^2);
RY=RPCF(:,3);

figure(4)
plot(RX,RY,'k.');
%plot(M,N,'k.');
hold on
plot([0,0],[0,max(RY)],'color',[0,0.5,0],'LineWidth',1.5)
%plot([0,0],[0,max(N)],'color',[0,0.5,0],'LineWidth',1.5)
axis equal
ylim([0 max(RY)+2])
xlim([min(RX)-1 max(RX)+2])
%ylim([0 max(N)+2])
%xlim([min(M)-1 max(M)+2])
xlabel('R')
ylabel('Z')
title('distance of all points to z-axis')

%% plotting the variances against the index values of the variance matrix
figure(5)
plot(1:pq,v,'.');

%% Plotting the final 3D pointcloud with the axis

figure(6)
plot3(RPCF(:,1),RPCF(:,2),RPCF(:,3),'.')
%plot3(RPC(:,1),RPC(:,2),RPC(:,3),'.')
hold on
plot3(Reqaxis_X,Reqaxis_Y,Reqaxis_Z,"r",'linewidth',5);
plot3([-15,15],[0,0],[0,0],"k",'linewidth',3);
plot3([0,0],[-15,15],[0,0],"k",'linewidth',3);
plot3([0,0],[0,0],[-15,15],"y",'linewidth',3);
xlabel('x')
ylabel('y')
zlabel('z')
title('Evaluated axis for 3D pointcloud')



















