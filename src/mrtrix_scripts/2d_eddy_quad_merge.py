import os
os.environ["OUTDATED_IGNORE"] = "1"
import pandas as pd

df= pd.read_csv("A214_DWIproc_April2021.csv")
qc= pd.read_csv("/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/squad/a214_qc_params.csv")

merged = pd.merge(df,qc, how="inner", on="mri_bids")



merged.loc[(merged['avg_rel_mot_mm']<=.7) & (merged['outliers_total_pct']<=10), 'eddyqc_pass'] = 'pass'
merged.loc[(merged['avg_rel_mot_mm']>.7) | (merged['outliers_total_pct']>10), 'eddyqc_pass'] = 'fail'

merged.to_csv("A214_DWIproc_June2021.csv", index = False)