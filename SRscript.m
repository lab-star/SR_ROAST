%% Script Systematic Review

%Steps to start
% 1. run roast
% 2. load *roastResult.mat
% 3. load *seg8.mat
% 4. udapte line 11 with correct file (*_masks.nii)

%% Select only White and Grey matter in ef_mag matrix

masks=niftiread('roast/*_masks.nii')

%Select only white (1) and grey (2) matter. (3=CSF, 4=bone, 5=skin , 6=air)
WG=(masks==1 | masks==2 )

%change the logical matrix to a double matrix
WG = double(WG);

%change all 0 for NaN (so all values that are not White or Gray
%matter will be NaN - important for the following steps as we do not want to process values other than WH/GR matter)
WG(WG==0)= NaN

%Multiply the ef_mag matrix (all electric field values for all brain
%layers of the brain) by the WG matrix to keep values of
%electric field values only for the WH/GR matter
ef_mag_mask=ef_mag.*WG

%% Find focality

%Create an ordered list without NaNs
ef_mag_sort = sort(ef_mag_mask(:),'descend'); %sort data from biggest to smallest (the number of data in this list corresponds to the number of brain voxels)               
ef_mag_nonan = rmmissing(ef_mag_sort) %remove NaNs from the list 
median=median(ef_mag_nonan) % find the median

%Find number of brain voxels that have a value greater than 50% of the Emax
Max = max(ef_mag_mask(:)); %find max value
vox50= ef_mag_nonan(ef_mag_nonan > Max/2) %Find values above 50% of max
minimum=min(vox50) %find the minimum

%Find number of brain voxels that have a value greater than 50% of the
%Emax(5%)
meanE5= mean(ef_mag_nonan(1:ceil(length(ef_mag_nonan)*0.05))); %the average of the top 5% values  
vox50_5= ef_mag_nonan(ef_mag_nonan > meanE5/2) %Find values above 50% of Emax(5%)
min5=min(vox50_5) %find the minimum

%% Identify the voxel coordinates of the maximum electric field

[r,c,v] = ind2sub(size(ef_mag_mask),find(ef_mag_mask == Max));
targetCoord=[r,c,v]

%%% transform voxel coordinates in MNI

mri2mni = Affine*(image(1).mat);
% mapping from MNI space to individual MRI

coordvoxel = mri2mni*[targetCoord(1,:) 1]';
        targetCoordMNI(1,:) = round(coordvoxel(1:3)');
        
