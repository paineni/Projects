function [ssrd, newTitle] = leseData(file,year)
%         yearfile = replace(dtime,startyear,year);
       ssrd = double(ncread(file,'ssrd'))*720/86400000; % in KWh/m2
       
       newTitle = ["Surface Solar Irradiance" + year];
end