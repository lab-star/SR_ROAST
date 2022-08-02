Transcranial alternating current stimulation to modulate alpha activity: a systematic review
===========================

Electric Field simulation using ROAST
-------------------------



### Description ###
This code includes
1. A code to transform MNI coordinates into subject space (voxel) coordinates
2. A code to transform subject space (voxel) coordinates into MNI coordinates
3. A code to assess the focality of the configuration montages obtained with ROAST

Focality is defined as a ratio of the number of brain voxels that have a value greater than 50% of the Emax on the total number of voxels in the cortex. 

The open-source software called Realistic Volumetric-approach to simulate transcranial electric stimulation [(ROAST)](https://github.com/andypotatohy/roast), provide end-to-end pipelines that allow automatic processing of individual heads via realistic volumetric anatomy, for individualized transcranial electrical modeling based on Huang Y, Datta A, Bikson M, Parra LC. Realistic volumetric-approach to simulate transcranial electric stimulation—ROAST—a fully automated open-source pipeline. J Neural Eng. 2019;16(5):056006. doi:10.1088/1741-2552/ab208d

### Needed before using the code ###
You need a valid Matlab license to run this ROAST and this code.
1. Download [ROAST](https://github.com/andypotatohy/roast)
2. Run your simulation.  

### License ###
This project is AFL 3.0 licensed
