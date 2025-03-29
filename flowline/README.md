# WR_18 Flowline Data

This directory contains hydrologic vector data for **USGS Water Resource Region 18 (WR18)**, derived from the **EPA NHDPlusV2.1** dataset (Vector Processing Unit 18). The files here represent cleaned and filtered stream network information for use in hydrologic modeling, visualization, and analysis.

The WR_18_Flowline.parquet file is only on Google Cloud since it is big.

Python
```
import urllib.request
url = "https://storage.googleapis.com/nmfs_odp_nwfsc/CB/nwm_daily_means/wr18/flowline/WR_18_Flowline.parquet"
urllib.request.urlretrieve(url, "WR_18_Flowline.parquet")
```

R
```
url <- "https://storage.googleapis.com/nmfs_odp_nwfsc/CB/nwm_daily_means/wr18/flowline/WR_18_Flowline.parquet"
download.file(url, "WR_18_Flowline.parquet", mode = "wb")
```

## Contents

| File                     | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `WR_18_Flowline.parquet` | GeoParquet file containing cleaned and projected flowline geometries.       |
| `WR_18_metadata.parquet` | Tabular metadata for flowline features (attributes such as COMID, FTYPE).   |

## Notes

- Only flowlines with valid 2D geometries are included.
- Features are filtered to those relevant to **HUC-2 Region 18**, excluding HUC-4s `1606` and `1712` which are not part of this hydrologic unit.
- All geometries are projected to **EPSG:3857** (Web Mercator) for compatibility with web basemaps and visualization tools.
- Geometry types include `LineString` and `MultiLineString`.

## Source

Data derived from:

> [EPA NHDPlus California (Vector Processing Unit 18)](https://www.epa.gov/waterdata/nhdplus-california-data-vector-processing-unit-18)  
> Original file: `NHDPlusV21_CA_18_NHDSnapshot_05.7z`

For processing details and broader dataset structure, see [`wr18_source_info.md`](../wr18_source_info.md).

---

**Maintained by**:  
Eli Holmes (NOAA Fisheries)  
eli.holmes@noaa.gov
