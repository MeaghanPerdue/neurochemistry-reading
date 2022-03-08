#!/usr/bin/env python
BRUKER_FOLDER='/Users/rhancock/scratch/a214_mrs/MRS/20180915_130406_Haskins_1_21'
SUBJECT = '214022'
SESSION = 'mrs1'
BIDS_DIR = '/Users/rhancock/scratch/a214_mrs/MRS/bids'

import os
import re
import datetime
import numpy as np
import warnings
import argparse
from collections import defaultdict, OrderedDict
import xml.etree.ElementTree as ET
import nibabel as nib
import brkraw as br


def get_info(rawdata):
    """Print study information
    """
    pv = rawdata.pvobj
    scan_date = rawdata.get_scan_time()
    datestr = scan_date['date'].strftime('%Y-%m-%d') + " " + scan_date['start_time'].strftime('%H:%M:%S')

    print(f"Subject ID: {pv.subj_id}\n" +
        f"Session ID: {pv.session_id}\n" +
        f"Sex: {pv.subj_sex}\n" +
        f"DOB: {pv.subj_dob}\n" +
        f"Date: {datestr}"
        )


def get_series_names(bruker_dir):
    """Parse the scan program to get descriptive names

    This information is included in the .info() method,
    but unclear how it is accessed via the object
    """
    series_names = dict()
    tree = ET.parse(os.path.join(bruker_dir, 'ScanProgram.scanProgram'))
    root = tree.getroot()
    instructions = root.find('instructionEntities')
    for series in instructions:
        series_names[int(series.find('expno').text)] = series.find('displayName').text

    return series_names


def anat_to_bids(rawdata, subject_dir, basename):
    """Put the scouts into a bids anat structure
        returns scanorder, a dict of (scan: name)
    """
    scanorder = OrderedDict()

    run = defaultdict(int)
    pv = rawdata.pvobj
    for scan, recos in pv.avail_reco_id.items():
        for reco in recos:
            visu_pars = rawdata.get_visu_pars(scan, reco)
            if visu_pars.parameters['VisuAcqSequenceName'] == 'User:ragFLASH':
                acq = re.findall('.*_(.*Scout)_.*',
                                visu_pars.parameters['VisuAcquisitionProtocol'])
                if len(acq) == 1:
                    acq = acq[0]
                    run[acq] += 1
                else:
                    continue

                # only keep axials
                zero_diag = np.isclose(np.diag(rawdata.get_affine(scan, reco)),
                                        [0, 0, 0, 0])
                if np.any(zero_diag):
                    continue

                fname = f'{basename}_acq-{acq}_run-{run[acq]}_T2w'
                nifti = rawdata.get_niftiobj(scan, reco)
                nib.save(nifti, os.path.join(subject_dir, 'anat',
                    f'{fname}.nii.gz'))
                rawdata.save_json(scan, reco, fname,
                    dir=os.path.join(subject_dir, 'anat'))
                scanorder[scan] = fname
    return scanorder

def mrs_to_bids(rawdata, series_names, subject_dir, basename):
    print('Renaming spectroscopy experiments...')
    run = defaultdict(int)
    scanorder = OrderedDict()
    pv = rawdata.pvobj
    for scan, recos in pv.avail_reco_id.items():
        for reco in recos:
            visu_pars = rawdata.get_visu_pars(scan, reco)
            meta = dict()
            if visu_pars.parameters['VisuAcqSequenceName'] in ['User:ragJDE', 'User:ragSTEAM']:
                acq = re.findall(r'.*(JDE|STEAM)',
                                 visu_pars.parameters['VisuAcqSequenceName'], flags=re.IGNORECASE)
                loc = re.findall(r'.*(FFG|STG|MOC|IFG|SFG|SMF|SMG).*',
                                series_names[scan].upper(), flags=re.IGNORECASE)
                if len(loc) != 1:
                    warnings.warn(f'Unknown VOI for {series_names[scan]}. Skipping')
                    continue
                loc = loc[0].upper()
                # try to derive a file name
                spec = acq[0].upper()
                water = re.findall(r'.*(water).*',
                                series_names[scan].lower())
                if len(water) == 1:
                    spec = 'water' + acq[0]
                else:
                    sup = re.findall(r'.*(ns|\dx\d).*',
                                series_names[scan])
                    if len(sup) == 1:
                        spec = 'metab'+acq[0]

                ident = f'loc-{loc}_spec-{spec}'
                run[ident] +=1
                fname = f'{basename}_nuc-1H_{ident}_run-{run[ident]}'
                print(f'{series_names[scan]} -> {fname}')
                # construct transform
                geom = rawdata.get_method(scan).parameters['PVM_VoxelGeoCub']
                meta['VoxelOrientation'] = np.reshape(
                                            np.array(geom['level_1'][0][0]),
                                            (3, 3))
                meta['VoxelPosition'] = geom['level_1'][0][1]
                meta['VoxelSize'] = geom['level_2'][0][0]
                trans = np.eye(4)
                m = np.array(geom['level_1'][0][0] + geom['level_1'][0][1])
                m = np.reshape(m, (4, 3)).T
                trans[0:3, ::] = m
                S = geom['level_2'][0][0]
                trans = np.dot(trans, np.diag(S + [1]))
                # note flips here-works with original anat
                trans[0,3] = trans[0,3]*-1
                trans[2,3] = trans[2,3]*-1
                np.savetxt(os.path.join(subject_dir, 'mrs', fname + '_trans.txt'), trans, fmt='%.3f')
                scanorder[scan] = fname
    return scanorder

argparser = argparse.ArgumentParser(description='Format A214 MRS data.')
argparser.add_argument('--bruker', type=str, help='Bruker session directory.')
argparser.add_argument('--subject', type=str, help='Subject label. Omit to get info.')
argparser.add_argument('--session', type=str, help='Session label. Omit to get info.')
argparser.add_argument('--bids', type=str, help='Directory for BIDS output.')
argparser.add_argument('--info', action='store_true', default=False, help='Display detailed session information.')
argparser.add_argument('--overwrite', action='store_true', help='Overwrite existing files')

args = argparser.parse_args()

rawdata = br.load(args.bruker)

if args.info:
    rawdata.info()

if (args.subject is None) or (args.session is None):
    get_info(rawdata)
    exit()


# setup directories
subject_dir = os.path.join(args.bids,
                            f'sub-{args.subject}',
                            f'ses-{args.session}')
os.makedirs(subject_dir, exist_ok=args.overwrite)
for typ in ['anat', 'mrs']:
    os.makedirs(os.path.join(subject_dir, typ), exist_ok=args.overwrite)
basename = f'sub-{args.subject}_ses-{args.session}'

series_names = get_series_names(args.bruker)
print(f'Parsed series list as: {series_names}')
anat_order = anat_to_bids(rawdata, subject_dir, basename)
mrs_order = mrs_to_bids(rawdata, series_names, subject_dir, basename)

print(f'mrs-anat correspondence:')
for mrs_scan, mrs_name in mrs_order.items():
    best = list(anat_order.values())[0]
    for anat_scan, anat_name in anat_order.items():
        if anat_scan > mrs_scan:
            print(f'{mrs_name}\t{best}')
            continue
        else:
            best = anat_name
    print(f'{mrs_name}\t{best}')

