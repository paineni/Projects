%%Setup and initialize
clc
clearvars
close all hidden
%%   Find the necessary files in Netcdf format
if ~exist('data','dir')
    error('You need to create a data folder and copy the downloaded file to the data folder and extract contents.')
end
datafolder = fullfile(pwd,"data");
t = struct2table(dir(fullfile(datafolder,"*")));
files = string(t.name(contains(t.name,'adaptor.mars.internal-1641745508.6597095-21465-12-09ba1208-0e9d-4e19-b095-9227b0c26fdd') & contains(t.name,'.nc')));
%%  Examine the contents of the netcdf file
file = fullfile(datafolder,files(1));
ncdisp(file)
lat = double(ncread(file,'latitude'));
lon = double(ncread(file,"longitude"));
si = double(ncread(file,'ssrd'));
time = double(ncread(file,'time'));
k=zeros(1440,721);
for i=1:length(time)
    k=k+(si(:,:,i));
    
end
b=si(:,:,1)'+si(:,:,2)'+si(:,:,3)'+si(:,:,4)'+si(:,:,5)'+si(:,:,6)'+si(:,:,7)'+si(:,:,8)'+si(:,:,9)'+si(:,:,10)'+si(:,:,11)'+si(:,:,12)';
k=k'*720/86400000;
time = ncread(file,'time');dtime=datetime(1900,1,1,time,0,0);
% ssr= ones(length(lon),length(lat));
% for n = 1:size(time)
%     ssr =

gcolor = [1 1 1];
latlim = double([min(lat(:)) max(lat(:))]);
f = figure;

% colormap(f,cmap);
titlestr = " Surface Solar irradiance " 
ax = axesm('robinson','Frame','on',Grid='on',MapLatLimit=latlim,GColor=gcolor);
% caxis(ax,[min(levels) max(levels)])
load coastlines
surfm(lat,lon,k);
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
bordersm('countries','k')
colorbar
h.Label.String = "Surface solar radation downwards";
title(titlestr)

figure(3)
worldmap("Europe")
surfm(lat,lon,k);
plotm(coastlat,coastlon,'LineWidth',2,'Color','black')
colorbar
