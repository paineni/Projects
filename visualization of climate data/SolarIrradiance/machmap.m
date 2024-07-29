function hfig=machmap(latlim,varargin)
    levels=0:300:2800;
    gcolor = [1 1 1];
    hfig=figure(varargin{:});
    ax=axesm('robinson','Frame','on',Grid='on',MapLatLimit=latlim,GColor=gcolor);
     caxis(ax,[min(levels) max(levels)])
    axis(ax,'on')
    h = colorbar('Ticks',levels);
    h.Label.String="Surface solar radation downwards KWh/m^2";
end

