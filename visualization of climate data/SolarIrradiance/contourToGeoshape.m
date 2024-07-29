function s = contourToGeoshape(c)
    lon = c(1,:);
    lat = c(2,:);
    n = length(lat);
    k = 1;
    index = 1;
    S = struct("Lat",[],"Lon",[],"Level",[]);
    while k < n
        level = lon(k);
        numVertices = lat(k);
        S(index).Lat = lat(k+1:k+numVertices);
        S(index).Lon = lon(k+1:k+numVertices);
        S(index).Level = level;
        k = k + numVertices + 1;
        index = index + 1;
    end
    
    % Remove single vertex.
    s = geoshape(S);
    index = false(length(s),1);
    for k = 1:length(s)
        if isscalar(s(k).Latitude)
            index(k) = true;
        end
    end
    s(index) = [];
end