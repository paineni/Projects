function hfig=machmap(latlim,varargin)
    levels=-40:10:40;
    gcolor = [1 1 1];
    hfig=figure(varargin{:});
    ax=axesm('robinson','Frame','on',Grid='on',MapLatLimit=latlim,GColor=gcolor);
    caxis(ax,[min(levels) max(levels)])
    axis(ax,'on')
    h=colorbar('Ticks',levels);
    h.Label.String="Average Temperature [0C]";
end

