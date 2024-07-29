function creategif(hfig,filename)
    data=getframe(hfig);
    RGB=data.cdata;
    [frame,cmap]=rgb2ind(RGB,256,'nodither');
    %write frame to GIF file
    if ~exist(filename,"file")
        imwrite(frame,cmap,filename,"gif","LoopCount",Inf,"DelayTime",0.5)
    else
        imwrite(frame,cmap,filename,"gif",WriteMode="append",DelayTime=0.5)
    end
end