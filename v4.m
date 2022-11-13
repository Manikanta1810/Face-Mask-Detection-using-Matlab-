%FACE MASK DETECTION
%Manikanta N_3BR18EC071
%N Likitha_3BR18EC079
%Naseer Ahammed S A_3BR18EC083
%Nikhita D_3BR18EC088
%Guide_Dr.K M Sadyojatha

clc
clear 
close all

%create a object detector
mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',50);
NoseDetector = vision.CascadeObjectDetector('Nose','MergeThreshold',50);
%create a shape
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 0 0],'LineWidth',5);

%use the connected camera from  system 
cam = webcam('HP Webcam');

%create a video frame of cam
videoFrame = snapshot(cam);

%set the video frame size
frameSize = size(videoFrame);
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);

runLoop = true;
frameCount = 0;

%create a while loop to checked condition until true
while runLoop && frameCount < 20
    videoFrame = snapshot(cam);
    
    %increment the frame count
    frameCount = frameCount + 1;
    
    %set step function to mouth detector
    nosebox=NoseDetector.step(videoFrame);
     mouthbox=mouthDetector.step(videoFrame);
     pause(1.5)
     
     
     if ~isempty(mouthbox)
               msgbox('No Mask')
         %title('No Mask') 
         [x,fs] =audioread('a1.mp3');
         sound(x,fs);
      elseif ~isempty(nosebox)&& isempty(mouthbox)
               msgbox('Partial mask')
                %title('Partial Mask')
                [y,fe]=audioread('a3.mp3');
                sound(y,fe);
     %elseif isempty(nosebox) && isempty(mouthbox)
          %title('Mask Present')
      %msgbox('Mask present')
     else
         %title('Mask Present')
          msgbox('Mask present')
         %msgbox('Mouth or Nose covered without mask')
     end
     videoFrame = step(shapeInserter, videoFrame,int32(nosebox));
     videoFrame = step(shapeInserter, videoFrame,int32(mouthbox));
     step(videoPlayer, videoFrame);
     runLoop = isOpen(videoPlayer);
end
clear cam;
clear
              