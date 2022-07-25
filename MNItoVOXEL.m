
%% MNI coord to voxel with ROAST

%Steps prior to run
% 1. load seg8.mat file which corresponds to the MRI used for the subject
% 2. Create a matrix called targetCoord with the target coordinates

% the Affine matrix is loaded when you load seg8.mat

mni2mri = inv(image(1).mat)*inv(Affine);
        % mapping from MNI space to individual MRI

temp = mni2mri*[MNI(1,:) 1]';
        targetCoord(1,:) = round(temp(1:3)');