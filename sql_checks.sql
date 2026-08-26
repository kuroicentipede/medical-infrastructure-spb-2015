-- Есть ли адреса с license_number, отсутствующим в licenses

SELECT l.license_number, li.license_number
FROM lic_addresses l
LEFT JOIN licenses li
    ON l.license_number = li.license_number
WHERE li.license_number IS NULL;

-- Есть ли лицензии без адресов

SELECT li.license_number, l.license_number
FROM licenses li
LEFT JOIN lic_addresses l
    ON li.license_number = l.license_number
WHERE l.license_number IS NULL;

-- Сколько адресов приходится на каждую лицензию

SELECT license_number, COUNT(*)
FROM lic_addresses
GROUP BY license_number
ORDER BY 2 DESC;

-- Есть ли дубликаты license_number в licenses

SELECT license_number
FROM licenses
GROUP BY license_number
HAVING COUNT(*) > 1;

-- Есть ли записи в lic_activ с license_number, отсутствующим в licenses

SELECT COUNT(*)
FROM lic_activ la
LEFT JOIN licenses l
    ON la.license_number = l.license_number
WHERE l.license_number IS NULL;

-- Какие лицензии отсутствуют в lic_activ

SELECT li.license_number
FROM licenses li
LEFT JOIN lic_activ la
    ON li.license_number = la.license_number
WHERE la.license_number IS NULL;
