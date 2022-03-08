#identify fixels in template to create a fixel mask for statistical analysis
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/

fod2fixel -mask template/template_mask.mif -fmls_peak_value 0.18 template/wmfod_template.mif template/fixel_mask_18

echo "Check fixel mask: in mrview open the index.mif found in template/fixel_mask via the fixel plot tool"