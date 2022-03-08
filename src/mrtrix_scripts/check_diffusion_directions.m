cd /Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/sub-pa0311/ses-01/dwi/
bvecs = load('sub-pa0311_ses-01_dwi.bvec'); % Assuming your filename is bvecs
figure('position',[100 100 500 500]);
plot3(bvecs(1,:),bvecs(2,:),bvecs(3,:),'*r');
axis([-1 1 -1 1 -1 1]);
axis vis3d;
rotate3d