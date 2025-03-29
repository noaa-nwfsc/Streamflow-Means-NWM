# Notebooks

* tutorial: This shows a minimal example of the steps

## The actual notebooks that created the data package

* package_structure: Start here for background info
* shapefile_processing: Process the USGS Hydrology shapefile with all streams and rivers. This has the feature ids (COMID ids) that are in the model data.
* streamflow_processing: This reads in the model data, creates the daily means and saves to chunked netcdfs
* save_to_gcp: This uploads the netcdfs and a Zarr from those to a Google Cloud bucket.