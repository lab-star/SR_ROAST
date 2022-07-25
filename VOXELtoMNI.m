
%% Voxel coord to mni with ROAST

%Steps prior to run
% 1. load seg8.mat file which corresponds to the MRI used for the subject
% 2. Create a matrix called targetCoord with the target coordinates

% the Affine matrix is loaded when you load seg8.mat


mri2mni = Affine*(image(1).mat);
% mapping from MNI space to individual MRI

temp = mri2mni*[targetCoord(1,:) 1]';
        targetCoordMNI(1,:) = round(temp(1:3)');