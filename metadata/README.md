# USGS WR17 and WR18 Mean Daily Streamflow Data Package

This dataset contains daily streamflow data and associated hydrologic features for USGS Water Resource Region 17 and 18. It was created by processing hourly streamflow data from the National Water Model v3.0 (1979–2023 retrospective) into daily means, specifically for StreamRiver features.

---

## Region Information

**Region Name**: Water Resource Region 18  
- **HUC-2**: 18  
- **States Covered**: California, Nevada  
- **Included HUC-4s**:  
  `1801`, `1802`, `1803`, `1804`, `1805`, `1806`, `1807`, `1808`, `1809`, `1810`  
- **Excluded HUC-4s**:  
  `1606`, `1712`  
  - *Note: Vector Processing Unit 18 included 1606 and 1712, but these are not part of HUC-2 region 18 and were excluded.*

**Region Name**: Water Resource Region 17 
- **HUC-2**: 17  
- **States Covered**: Washington, Oregon, Idaho (mainly)  
- **Included HUC-4s**:  
  `1701` to `1712` inclusive  

---

## Flowline Source: NHDPlusV2.1

- **Source**: EPA NHDPlusV2.1, Vector Processing Unit 18  and EPA NHDPlusV2.1, Vector Processing Unit 17 
- **Download URL**:
    * [EPA NHDPlus VPU 18](https://www.epa.gov/waterdata/nhdplus-california-data-vector-processing-unit-18)  
    * [EPA NHDPlus VPU 17](https://www.epa.gov/waterdata/nhdplus-pacific-northwest-data-vector-processing-unit-17)  
- **Original File**:
    * `NHDPlusV21_CA_18_NHDSnapshot_05.7z`  
    * `NHDPlusV21_CA_18_NHDSnapshot_05.7z`  
- **Processed Output**:
    * `WR_1718_Flowline.parquet`
    * `WR_18_Flowline.parquet`
    * `WR_17_Flowline.parquet`

### Flowline Attributes Summary

| Attribute       | Description                                                    |
|-----------------|----------------------------------------------------------------|
| Total Features  | 332,880                                                       
| FTYPE Values    | StreamRiver, ArtificialPath, CanalDitch, Connector, Pipeline   |
| FCODE Info      | See `WR_1718_metadata.parquet` for full list                     |
| Geometry Types  | LineString or MultiLineString                                  |
| CRS (Original)  | `ESRI:102039` (USA_Contiguous_Albers_Equal_Area_Conic_USGS)    |
| CRS (Parquet)   | `EPSG:3857` (Web Mercator)                                     |

**Geometry cleaning steps:**

- Dropped empty or invalid geometries  
- Converted to 2D LineString (stripped Z/M if present)

---

## Streamflow Processing

- **Source Dataset**: NOAA National Water Model v3.0 Retrospective (1979–2023)  
- **Data Access**: [AWS Open Data Registry](https://registry.opendata.aws/nwm-archive/)  
- **Zarr Path**: `s3://noaa-nwm-retrospective-3-0-pds/CONUS/zarr/chrtout.zarr`  
- **Filter**: Only features with `FTYPE == 'StreamRiver'`  
- **Subset Method**: Match COMIDs from WR18 flowline metadata with `feature_id` in NWM output  
- **Output Formats**: NetCDF and Zarr
- **Cloud Storage**: AWS S3  
- **Region**: `us-east-1`  
- **Access**: Public, anonymous

**Processing step to compute daily means from hourly data:**  
`daily_mean = streamflow_ts.resample(time="1D").mean().compute()`


---

## Processing Date

**March 28, 2025**

---

## Author

**Eli Holmes**  
NOAA Fisheries  
eli.holmes@noaa.gov
