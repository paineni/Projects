close all
clc
clearvars
%% Reading the Excel file ant points of symmetry-axis
pc=xlsread('Point_Clouds.xlsx',3,'A:C');  % read Excel table
x=pc(:,1);
y=pc(:,2);
z=pc(:,3);
centroid=[mean(x),mean(y),mean(z)];
%plot3(x,y,z,'k.');
%hold on
%plot3([max(1,1),min(1,1)],[max(1,2),min(1,2)],[max(1,3),min(1,3)]);

coeff=pca(pc);

newcomponents=coeff*15;
p_rax1=[centroid(1,1)-newcomponents(1,1),centroid(1,2)-newcomponents(2,1),centroid(1,3)-newcomponents(3,1)];    % first point of rotation axis
p_rax2=[centroid(1,1)+newcomponents(1,1),centroid(1,2)+newcomponents(2,1),centroid(1,3)+newcomponents(3,1)];     % second point of rotation axis

%% Plotting point-cloud, the rotation-axis and the z-axis
fig=gcf;
fig.Units='normalized';
fig.OuterPosition=[0 0 1 1];
subplot(1,2,1)
plot3(x,y,z,'.')                        % Plot the point cloud
axis equal
hold on
plot3([p_rax1(1),p_rax2(1)],[p_rax1(2),p_rax2(2)],[p_rax1(3),p_rax2(3)],...
    'r-','LineWidth',1.5)    % Plot rotation-axis
plot3([0,0],[0,0],[0,10],'g-','LineWidth',1.5)    % Plot z-axis
plot3([0,10],[0,0],[0,0],'k-','LineWidth',1.5)    % Plot x-axis
plot3([0,0],[0,10],[0,0],'k-','LineWidth',1.5)    % Plot y-axis
grid on
xlabel('x')
ylabel('y')
zlabel('z')
title('Given point cloud with rotation-axis and z-axis')
%% Coordinate Transformation
%Translation
PC=[x,y,z];             % point cloud in a matrix
p_rax=[p_rax1;p_rax2];   % points of rotation-axis in a matrix
trans=p_rax1-[0,0,0];
p_rax=p_rax-trans;
PC=PC-trans;
% Rotation 1
if p_rax(2,1)>0     % find angle for rotation
        beta=atan(p_rax(2,2)/p_rax(2,1));
    elseif p_rax(2,1)<0 && p_rax(2,2)>=0
        beta=atan(p_rax(2,2)/p_rax(2,1))+pi;
    elseif p_rax(2,1)<0 && p_rax(2,2)<0
        beta=atan(p_rax(2,2)/p_rax(2,1))-pi;
    elseif p_rax(2,1)==0 && p_rax(2,2)>0
        beta=pi/2;
    elseif p_rax(2,1)==0 && p_rax(2,2)<=0
        beta=-pi/2;
end
R_z=[cos(beta),-sin(beta),0;sin(beta),cos(beta),0;0,0,1];   %Rotationmatrix
p_rax=p_rax*R_z;    % Rotation of rotation axis points
PC=PC*R_z;          % Rotation of point cloud
% Rotation 2
if p_rax(2,1)>0         % find angle for rotation
        beta=atan(p_rax(2,3)/p_rax(2,1));
    elseif p_rax(2,1)<0 && p_rax(2,3)>=0
        beta=atan(p_rax(2,3)/p_rax(2,1))+pi;
    elseif p_rax(2,1)<0 && p_rax(2,3)<0
        beta=atan(p_rax(2,3)/p_rax(2,1))-pi;
    elseif p_rax(2,1)==0 && p_rax(2,3)>0
        beta=pi/2;
    elseif p_rax(2,1)==0 && p_rax(2,3)<=0
        beta=-pi/2;
end
beta=beta-pi/2;
R_y=[cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];   %Rotationmatrix
p_rax=p_rax*R_y';   % Rotation of rotation axis points
PC=PC*R_y';         % Rotation of point cloud

%% Ploting
subplot(1,2,2)
plot3(PC(:,1),PC(:,2),PC(:,3),'.')
axis equal
hold on

plot3([0,0],[0,0],[0,10],'g-','LineWidth',1.5)    % Plot z-axis
plot3([0,10],[0,0],[0,0],'k-','LineWidth',1.5)    % Plot x-axis
plot3([0,0],[0,10],[0,0],'k-','LineWidth',1.5)    % Plot y-axis
plot3(p_rax(:,1),p_rax(:,2),p_rax(:,3),...
    'r-','LineWidth',1.5)    % Plot rotation-axis
grid on
xlabel('x')
ylabel('y')
zlabel('z')
title('Third step: Rotation around y-axis')

%% Get new x, y, z of the point cloud
x=PC(:,1);
y=PC(:,2);
z=PC(:,3);