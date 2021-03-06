UPDATE
  planet_osm_point
  SET mz_poi_min_zoom = mz_calculate_min_zoom_pois(planet_osm_point.*)
  WHERE
    (barrier IN ('toll_booth', 'gate') OR
     highway IN ('services', 'rest_area') OR
     tourism = 'camp_site' OR
     man_made IN ('lighthouse', 'windmill') OR
     leisure = 'garden' OR
     railway IN ('halt', 'stop', 'tram_stop', 'station'))
    AND COALESCE(mz_poi_min_zoom, 999) <> COALESCE(mz_calculate_min_zoom_pois(planet_osm_point.*), 999);

UPDATE
  planet_osm_point
  SET mz_places_min_zoom = mz_calculate_min_zoom_places(planet_osm_point.*)
  WHERE
    place = 'country' AND "name" IS NOT NULL;

UPDATE
  planet_osm_point
  SET mz_places_min_zoom = NULL
  WHERE
    place IN ('borough', 'suburb', 'quarter') AND name IS NOT NULL;

UPDATE
  planet_osm_point
  SET mz_places_min_zoom = mz_calculate_min_zoom_places(planet_osm_point.*)
  WHERE
    (highway = 'gate' OR amenity = 'picnic_site')
    AND COALESCE(mz_places_min_zoom, 999) <> COALESCE(mz_calculate_min_zoom_places(planet_osm_point.*), 999);
