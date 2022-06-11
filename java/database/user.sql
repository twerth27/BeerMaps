-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER breweries_A_owner
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO breweries_A_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO breweries_A_owner;

CREATE USER breweries_A_appuser
WITH PASSWORD 'finalcapstone';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO breweries_A_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO breweries_A_appuser;

CREATE USER breweries_A_brewer
WITH PASSWORD 'finalcapstone';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO breweries_A_brewer;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO breweries_A_brewer;
