
        -- Drop existing tables and indices if they exist
        DROP INDEX IF EXISTS idx_zipcode_geom CASCADE;
        DROP INDEX IF EXISTS idx_complaints_geom CASCADE;
        DROP INDEX IF EXISTS idx_tree_geom CASCADE;
        DROP TABLE IF EXISTS complaints_data CASCADE;
        DROP TABLE IF EXISTS tree_data CASCADE;
        DROP TABLE IF EXISTS zillow_data CASCADE;
        DROP TABLE IF EXISTS zipcode_data CASCADE;

        -- Create tables
        CREATE TABLE zipcode_data (
            zipcode TEXT PRIMARY KEY,
            geom GEOMETRY
        );

        CREATE TABLE complaints_data (
            unique_id BIGINT PRIMARY KEY,
            created_date DATE,
            complaint_type TEXT,
            zipcode TEXT,
            geom GEOMETRY,
            FOREIGN KEY (zipcode) REFERENCES zipcode_data(zipcode)
        );

        CREATE TABLE tree_data (
            tree_id BIGINT PRIMARY KEY,
            species TEXT,
            health TEXT,
            status TEXT,
            zipcode TEXT,
            geom GEOMETRY,
            FOREIGN KEY (zipcode) REFERENCES zipcode_data(zipcode)
        );

        CREATE TABLE zillow_data (
            zipcode TEXT,
            city TEXT,
            data_date DATE,
            rent_price NUMERIC,
            FOREIGN KEY (zipcode) REFERENCES zipcode_data(zipcode),
            PRIMARY KEY (zipcode, data_date)
        );

        -- Create spatial indices
        CREATE INDEX idx_zipcode_geom ON zipcode_data USING gist(geom);
        CREATE INDEX idx_complaints_geom ON complaints_data USING gist(geom);
        CREATE INDEX idx_tree_geom ON tree_data USING gist(geom);
    