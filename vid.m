
t = 1000

writerObj = VideoWriter('out/writerrotate.avi');
open(writerObj);

for i = 1:t
   
    frame = getframe(trajectoriyFig);
    writeVideo(writerObj, frame);
    i
end

close(writerObj);