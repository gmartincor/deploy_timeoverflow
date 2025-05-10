ALTER TABLE organizations ADD COLUMN IF NOT EXISTS latitude decimal(10,6);
ALTER TABLE organizations ADD COLUMN IF NOT EXISTS longitude decimal(10,6);
ALTER TABLE organizations ADD COLUMN IF NOT EXISTS geocoded_at timestamp without time zone;
CREATE INDEX IF NOT EXISTS index_organizations_on_latitude_and_longitude ON organizations (latitude, longitude);
