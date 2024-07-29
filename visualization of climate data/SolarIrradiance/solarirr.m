%% Setup
clc
clearvars
close all hidden

%% Find the necessary files in Netcdf format
if ~exist('data','dir')
    error("You need to create a data folder and copy the downloaded file to the data folder and extract contents.")
end
datafolder = fullfile(pwd,"data");
t = struct2table(dir(fullfile(datafolder,"*")));
files = string(t.name(contains(t.name,'adaptor.mars.internal-1641745508.6597095-21465-12-09ba1208-0e9d-4e19-b095-9227b0c26fdd') & contains(t.name,'.nc')));

%% Examine the contents of the netcdf file
file = fullfile(datafolder,files(1));
ncdisp(file)


%% Reading the SSRD data 
lat = double(ncread(file,'latitude'));
lon = double(ncread(file,"longitude"));
ssrd = double(ncread(file,'ssrd'))*720/86400000; % in KWh/m2
time = double(ncread(file,'time'));

dtime=string(datetime(1900,1,1,time,0,0));
b=length(time)/12;
%% Years extraction
years=zeros(b,1);
x=1;
for i=1:12:length(time)
years(x) = extractAfter(dtime(i),"01-Jan-");
x=x+1;
end
Yrs=string(years);
startyear=Yrs(1);
%% Calculating yearly sum of ssrd
si=zeros(length(lat),length(lon),b);
j=1;
for m=1:b
    while j<= m*12
        si(:,:,m)=si(:,:,m)+ssrd(:,:,j)';
        j=j+1;
    end
    
end

 levels=0:300:2800;
gcolor = [1 1 1];
latlim = double([min(lat(:)) max(lat(:))]);
 cmap = parula(length(levels)-1);

%% Surface plot
f = figure; 
 colormap(f,cmap);
titlestr = " Surface Solar irradiance " + startyear;
ax = axesm('robinson','Frame','on',Grid='on',MapLatLimit=latlim,GColor=gcolor);
 caxis(ax,[min(levels) max(levels)])
load coastlines
surfm(lat,lon,si(:,:,1));
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
bordersm('countries','k')
h = colorbar('Ticks',levels);
h.Label.String = "Surface solar radation downwards KWh/m^2";
title(titlestr)
subtitle("Surface plot")
axis off

%% Animate Average Temperature over time 
% If using the Live Editor, you could add a control for the year 
hfig = machmap(latlim);
subtitle("Animated")
colormap(hfig,cmap);
IrradianceTexturemap = surfm(lat,lon,si(:,:,1),FaceColor="texturemap");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
bordersm('countries','k')
axis off

for k = 1:length(years)
    year = Yrs(k);
     newTitle = ["Surface Solar Irradiance" + year];
    Solar_Irradiance=si(:,:,k);
    set(IrradianceTexturemap,'CData',Solar_Irradiance)
    title(newTitle)
    drawnow 
end

%% filename='Avg_Temperature.gif';
hfig = machmap(latlim,'Visible','off');
colormap(hfig,cmap);
IrradianceTexturemap = surfm(lat,lon,si(:,:,1),FaceColor="texturemap");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
bordersm('countries','k')
filename = 'SSRD.gif';
if exist(filename,'file')
    delete(filename)
end

for k = 1:length(years)
    year = (Yrs(k));
     newTitle = ["Surface Solar Irradiance" + year];
     Solar_Irradiance=si(:,:,k);
    set(IrradianceTexturemap,'CData',Solar_Irradiance)
    title(newTitle)
    creategif(hfig,filename)
end

%% Create a contour map
machmap(latlim);
% year=2013;
[ssrd, newTitle] = leseData(file,year);
title(newTitle)
subtitle("Contour map")
IrradianceContourMap = contourfm(lat,lon,si(:,:,1),"LevelList",levels,"Color","k");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
axis off

%% 3D visualisation
s = contourToGeoshape(IrradianceContourMap);
uif = uifigure;
uif.Name = "Solar Irradiance "+startyear;
ug = uigridlayout(uif,[1,2],"ColumnWidth",{'1x','.1x'});
up1 = uipanel(ug,"BackgroundColor",uif.Color,"BorderType","none");
up2 = uipanel(ug,"BackgroundColor",uif.Color,"BorderType","none");
gg = geoglobe(up1,"Terrain","none","Basemap","streets-dark","NextPlot","add","Visible","off");
ax = axes(up2,"Units","normalized","Position",[.05 0.02 .005 .95]);
axis(ax,"off")
caxis(ax,[0 2800])
h = colorbar(ax);
h.Label.String ="Surface solar radation downwards KWh/m^2";
h.Ticks = levels;
cmap = parula(length(levels)-1);
colormap(uif,cmap)

n = 0;
for level = levels
    index = s.Level == level;
    n = min(n + 1, length(cmap));
    color = cmap(n,:);
    geoplot3(gg,s(index).Latitude,s(index).Longitude,[],Color=color)
end
uif.Visible = "on";
gg.Visible = "on";

%% 2D visualisation
% Create a datatip to add yearly SSRD
f = figure;
f.Name = "Solar Irradiance "+startyear;
gx = geoaxes(Basemap="streets-dark",NextPlot="add");
caxis(gx,[0 2800])
h = colorbar(gx);
h.Label.String ="Surface solar radation downwards KWh/m^2";
h.Ticks = levels;
colormap(gx,cmap)

n = 0;
hline = matlab.graphics.chart.primitive.Line.empty;
for level = levels
    index = s.Level == level;
    n = min(n + 1, length(cmap));
    color = cmap(n,:);
    slat = s(index).Latitude;
    slon = s(index).Longitude;
    if ~isempty(slat) && ~isempty(slon)
        hline(end+1) = geoplot(gx,slat,slon,Color=color); 
        dtrow = dataTipTextRow("Irradiance",level*ones(1,length(slat)));
        hline(end).DataTipTemplate.DataTipRows(end+1) = dtrow;
    end
end
title("Geographic axes plot")
subtitle("with datatips")


