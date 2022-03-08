#!/bin/bash
#compute template mask

cd /mrtrix_out
mrmath sub-*/dwi_mask_in_template_space.mif min template/template_mask.mif -datatype bit

#check template mask for brain coverage!