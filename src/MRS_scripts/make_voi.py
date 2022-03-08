#!/usr/bin/env python
import numpy as np
import os
import scipy.spatial as spatial
import argparse

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)
warnings.simplefilter(action='ignore', category=UserWarning)
import nibabel as nib


parser = argparse.ArgumentParser(
    description="Generate ROI voxels from MRS affine and anat files.")
parser.add_argument('--t1_nifti',
    help="Path to target nifti")
parser.add_argument('--t2_nifti',
    help="Path to 4T T2w anatomical")
parser.add_argument('--svs_transform',
    help="A file containing the affine transform of the MRS voxel")
parser.add_argument('--mflirt',
    help="A file containing the t2w to target transform matrix")
parser.add_argument('--roi_prefix', help="Prefix for output files")
args = parser.parse_args()


mflirt = np.loadtxt(args.mflirt)

# reference (T1) matrices
t1_nifti = nib.load(args.t1_nifti)
t1_qform = t1_nifti.get_qform()
Sref = np.diag(list(t1_nifti.header.get_zooms()) + [1])
Wref = np.eye(4)

# swap left to right orientations
if np.linalg.det(t1_qform) > 0:
    Wref[0, 0] = -1
    Wref[0, 3] = t1_nifti.shape[0] - 1

# input (T2) matrices
t2_nifti = nib.load(args.t2_nifti)
t2_qform = t2_nifti.get_qform()
Sin = np.diag(list(t2_nifti.header.get_zooms()) + [1])
Win = np.eye(4)
Win[0, 0] = -1
Win[0, 3] = t2_nifti.shape[0] - 1

# concatenate
tform = Wref @ np.linalg.inv(Sref) @ mflirt @ Sin @ Win 

# load the voxel spec, in mm
mrs_mm = np.loadtxt(args.svs_transform)
# maybe rescale here

mflirt_scale = np.linalg.det(mflirt)
if not np.isclose(mflirt_scale, 1.0):
    warnings.warn(f'{args.mflirt} has scaling factor {mflirt_scale} != 1. ' +
                  'The VOI volume will be inaccurate!')

composed_affine = tform @ np.linalg.inv(t2_qform) @ mrs_mm

# make a volume in T1 space
mrs_corners = [[-0.5, -0.5, -0.5, 1],  # 0
               [-0.5, -0.5,  0.5, 1],  # 1
               [-0.5,  0.5, -0.5, 1],  # 2
               [-0.5,  0.5,  0.5, 1],  # 3
               [0.5, -0.5, -0.5, 1],  # 4
               [0.5, -0.5,  0.5, 1],  # 5
               [0.5,  0.5, -0.5, 1],  # 6
               [0.5, 0.5, 0.5, 1]]     # 7

# don't round off here
t1_corners = np.array([(np.dot(composed_affine, c)) for c in mrs_corners]).squeeze()

t1_data = t1_nifti.get_fdata().squeeze()
mrs_roi = np.ones_like(t1_data) * 0

# exhaustive search for points in the voxel
tri = spatial.Delaunay(t1_corners[:, 0:3])
for i in range(np.round(min(t1_corners[:, 0])).astype(int), np.round(max(t1_corners[:, 0])).astype(int)):
    for j in range(np.round(min(t1_corners[:, 1])).astype(int), np.round(max(t1_corners[:, 1])).astype(int)):
        for k in range(np.round(min(t1_corners[:, 2])).astype(int), np.round(max(t1_corners[:, 2])).astype(int)):
            mrs_roi[i, j, k] = tri.find_simplex([i, j, k]) >= 0

img = nib.Nifti1Image(mrs_roi, t1_qform)
nib.save(img, args.roi_prefix + '.nii.gz')
