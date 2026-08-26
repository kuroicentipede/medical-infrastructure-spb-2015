CREATE TABLE licenses (
    name TEXT,
    address TEXT,
    inn TEXT,
    ogrn TEXT,
    license_number TEXT PRIMARY KEY
);

CREATE TABLE lic_addresses (
    activity_id SERIAL PRIMARY KEY,
    license_number TEXT,
    activity_address TEXT,
    licensed_services TEXT,
    FOREIGN KEY (license_number)
        REFERENCES licenses(license_number)
);


CREATE TABLE lic_activ (
	activity_number INTEGER,
	license_number TEXT,
	activity_name TEXT,
	PRIMARY KEY (activity_number, license_number),
	FOREIGN KEY (license_number)
		REFERENCES licenses(license_number)
);