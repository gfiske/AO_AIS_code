-- Example PAO BigQuery query
-- Requests number of ships in Barent Sea with no MMSI number for the year 2016

SELECT COUNT(*) FROM [panarcticoptions-155117:AO_March_2017.merge_joined_points] WHERE mmsi = 0 and YEAR(satellite_timestamp) = 2016 and region = "BASR" ;