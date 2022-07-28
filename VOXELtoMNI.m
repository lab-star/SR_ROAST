
%% Voxel coordinates to mni with ROAST

%Steps prior to run
% 1. run roast
% 2. load seg8.mat file which corresponds to the MRI used for the subject
% 3. Create a matrix called targetCoord with the target coordinates in
% subject space

% the Affine matrix is loaded when you load seg8.mat

mri2mni = Affine*(image(1).mat);
% mapping from MNI space to individual MRI

temp = mri2mni*[targetCoord(1,:) 1]';
        targetCoordMNI(1,:) = round(temp(1:3)');