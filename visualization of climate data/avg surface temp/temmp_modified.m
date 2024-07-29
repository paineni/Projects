%% Setup
clc
clearvars
close all hidden

%% Find the necessary files in Netcdf format
if ~exist('tempdata','dir')
    error("You need to create a data folder and copy the downloaded file to the data folder and extract contents.")
end
datafolder = fullfile(pwd,"tempdata");
t = struct2table(dir(fullfile(datafolder,"*")));
files = string(t.name(contains(t.name,'mean_Global') & contains(t.name,'.nc')));

%% Examine the contents of the netcdf file
file = fullfile(datafolder,files(1));
ncdisp(file)
years = extractAfter(files,"ea_2t_");
years = extractBefore(years,"10_v02.nc");
startyear = years(1);

%% Reading the temperature data 
avgtemp = ncread(file,"t2m")-273;
avgtemp = avgtemp';
lat = ncread(file,'latitude');
lon = ncread(file,"longitude");
levels = -40:10:40;
gcolor = [1 1 1];
latlim = double([min(lat(:)) max(lat(:))]);
cmap = parula(length(levels)-1);

%% Surface plot
f = figure;
colormap(f,cmap);
titlestr = " Surface Air Temperature " + startyear;
ax = axesm('robinson','Frame','on',Grid='on',MapLatLimit=latlim,GColor=gcolor);
caxis(ax,[min(levels) max(levels)])
load coastlines
surfm(lat,lon,avgtemp);
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
h = colorbar('Ticks',levels);
h.Label.String = "Average Temperature ^{o}C";
title(titlestr)
subtitle("Surface plot")
axis off

%% Animate Average Temperature over time 
% If using the Live Editor, you could add a control for the year 
hfig = machmap(latlim);
subtitle("Animated")
colormap(hfig,cmap);
TempTexturemap = surfm(lat,lon,avgtemp,FaceColor="texturemap");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
axis off

for k = 1:length(years)
    year = years(k);
    [Avg_Temperature, newTitle] = leseData(file,startyear,year);
    set(TempTexturemap,'CData',Avg_Temperature)
    title(newTitle)
    drawnow 
end

%% filename='Avg_Temperature.gif';
hfig = machmap(latlim,'Visible','off');
colormap(hfig,cmap);
TempTexturemap = surfm(lat,lon,avgtemp,FaceColor="texturemap");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
filename = 'Avg_Temperature.gif';
if exist(filename,'file')
    delete(filename)
end

for k = 1:length(years)
    year = years(k);
    [Avg_Temperature, newTitle] = leseData(file,startyear,year);
    set(TempTexturemap,'CData',Avg_Temperature)
    title(newTitle)
    creategif(hfig,filename)
end

%% Create a contour map
machmap(latlim);
% year=2013;
[Avg_Temperature, newTitle] = leseData(file,startyear,year);
title(newTitle)
subtitle("Contour map")
tempContourMap = contourfm(lat,lon,avgtemp,"LevelList",levels,"Color","k");
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
axis off

%% 3D visualisation
s = contourToGeoshape(tempContourMap);
uif = uifigure;
uif.Name = "AVG TEMP "+startyear;
ug = uigridlayout(uif,[1,2],"ColumnWidth",{'1x','.1x'});
up1 = uipanel(ug,"BackgroundColor",uif.Color,"BorderType","none");
up2 = uipanel(ug,"BackgroundColor",uif.Color,"BorderType","none");
gg = geoglobe(up1,"Terrain","none","Basemap","streets-dark","NextPlot","add","Visible","off");
ax = axes(up2,"Units","normalized","Position",[.05 0.02 .005 .95]);
axis(ax,"off")
caxis(ax,[-40 40])
h = colorbar(ax);
h.Label.String ="Average Temperature [0C]";
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
% Create a datatip to add average temperature
f = figure;
f.Name = "AVG TEMP "+startyear;
gx = geoaxes(Basemap="streets-dark",NextPlot="add");
caxis(gx,[-40 40])
h = colorbar(gx);
h.Label.String ="Average Temperature [0C]";
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
        hline(end+1) = geoplot(gx,slat,slon,Color=color); %#ok<SAGROW>
        dtrow = dataTipTextRow("Temperature",level*ones(1,length(slat)));
        hline(end).DataTipTemplate.DataTipRows(end+1) = dtrow;
    end
end
title("Geographic axes plot")
subtitle("with datatips")

