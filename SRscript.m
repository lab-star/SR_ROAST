%% Script Systematic Review
%Steps to start
% 1. load *roastResult.mat
% 2. load *seg8.mat
% 3. udapte line 9 with correct file (*_masks.nii)

%% Select only White and Grey matter in ef_mag matrix

masks=niftiread('roast/AutresSR/MNI152_T1_1mm_ras_T1orT2_masks.nii')

%Select only white (1) and grey (2) matter. (3=CSF, 4=bone, 5=skin , 6=air)
WHGR=(masks==1 | masks==2 )

%change the logical matrix to a double matrix
WHGR = double(WHGR);

%change all 0 for NaN (donc toutes les valeurs qui ne sont pas de la WH/GR
%matter seront NaN - important pour les étapes suivantes car on ne veut pas traiter les valeurs autre que la WH/GR matter)
WHGR(WHGR==0)= NaN

%mutiplier la matrice ef_mag (toutes les valeurs de electric field pour toutes les
%couches du cerveau) par la matrice WHGR pour conserver des valeurs de
%electric field seulement pour la WH/GR matter
ef_mag_mask=ef_mag.*WHGR

%% Trouver les données pour la focalité
%créer liste sans NaN
ef_mag_sort = sort(ef_mag_mask(:),'descend'); %sort les donnees du plus grand au plus petit                 
ef_mag_nonan = rmmissing(ef_mag_sort) %enlever les NaN de la liste
median=median(ef_mag_nonan)

%En utilisant la valeur maximale
Max = max(ef_mag_mask(:)); %find max value
vox50= ef_mag_nonan(ef_mag_nonan > Max/2) %Find values above 50% of max
minimum=min(vox50)
%NonNan = nnz(~isnan(ef_mag)) %Trouver le nb de voxel avec une donnee (remove Nan)

%En utilisant cette fois-ci la moyenne des valeurs 5% plus hautes comme valeur max
meanE5= mean(ef_mag_nonan(1:ceil(length(ef_mag_nonan)*0.05))); %la moyenne des valeurs les 5% plus elevees  
vox50_5= ef_mag_nonan(ef_mag_nonan > meanE5/2) %Find values above 50% of max
min5=min(vox50_5)

%% Identifier les coordonnées voxel du electric field maximum

[r,c,v] = ind2sub(size(ef_mag_mask),find(ef_mag_mask == Max));
targetCoord=[r,c,v]

%%% transformer les coordonnées voxel en MNI

mri2mni = Affine*(image(1).mat);
% mapping from MNI space to individual MRI

coordvoxel = mri2mni*[targetCoord(1,:) 1]';
        targetCoordMNI(1,:) = round(coordvoxel(1:3)');
        
