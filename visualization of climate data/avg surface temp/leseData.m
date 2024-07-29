function [Avg_Temperature, newTitle] = leseData(file,startyear,year)
       yearfile = replace(file,startyear,year);
       Avg_Temperature = ncread(yearfile,"t2m")-273;
       Avg_Temperature=Avg_Temperature';
       newTitle = ["Surface Air Temperature" + year];
end