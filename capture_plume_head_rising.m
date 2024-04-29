% capture plume head rising from images
indir='./auto_frames_0.5s_SC1TK775_J1096';
%graydir='./grayscale_images';
Nrows=2160;
Ncols=3840;
NfilesToProcess=12;

% read rgb images and convert to grayscale
% get a list of files
filelist=dir([indir '/*.jpg']);
Nfiles=length(filelist);
if NfilesToProcess>Nfiles
    fprintf('Not enough files available for request\n')
    return
end
% sort file list to be in numerical order
%   note - need to sort the entire file list to get the right list of files
inindex=zeros(Nfiles,1);
for i=1:Nfiles
    inindex(i)=sscanf(filelist(i).name,'frame%d.jpg');
end
[steplabels,orderedindex]=sort(inindex);

% process the images
conpts=cell(NfilesToProcess,4);
plumepts=cell(NfilesToProcess,1);
imgmat=zeros(Nrows,Ncols,NfilesToProcess);
figure(1)
for i=1:NfilesToProcess
    fprintf('processing %dth file (time step %d) \n',i,steplabels(i))
    % grab images in correct order
    thisimg=imread(fullfile(indir,filelist(orderedindex(i)).name));

    %convert to grayscale
    grayimg=rgb2gray(thisimg);

    % display
    imshow(grayimg)

    % get control points for background structure and scaling from rod
    fprintf('%d: select 3 points along left rock:\n',i)
    [x1,y1] = ginput(3)
    fprintf('%d: select 3 points along bottom left rock:\n',i)
    [x2,y2] = ginput(3)
    fprintf('%d: select 3 points along right bottom rock:\n',i)
    [x3,y3] = ginput(3)
    fprintf('%d: select 3 points along stick:\n',i)
    [x4,y4] = ginput(3)
    
    % get outer curve of plume head is visible
    %   actually though this is set up to not get a plume head if not
    %   visible, I think I will just do the bush edge
    %isplume = input('Enter 0 if no plume or 1 if plume');
    %if isplume
        fprintf('%d: click along plume head\n',i)
        [xp,yp] = ginput(20)
    %else
        %xp=NaN;
        %yp=NaN;
    %end

    % put control and plume head points into cell variables
    conpts{i,1}=[x1 y1];
    conpts{i,2}=[x2 y2];
    conpts{i,3}=[x3 y3];
    conpts{i,4}=[x4 y4];
    plumepts{i}=[xp yp];

    imgmat(:,:,i)=grayimg;
    fprintf('paused\n')
    pause
end
save imgconpts5.mat conpts plumepts imgmat steplabels

% no addtional actions in this file -- it's too complicated