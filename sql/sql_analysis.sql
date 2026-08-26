-- 1. Какие направления медицинской деятельности формируют основную структуру лицензируемой медицинской деятельности?

SELECT activity_name, COUNT(*)
FROM lic_activ
GROUP BY activity_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 2. Какие виды медицинской деятельности представлены единичными случаями лицензирования?

SELECT activity_name, COUNT(*)
FROM lic_activ
GROUP BY activity_name
HAVING COUNT(*)=1;

-- 3. Какие медицинские организации характеризуются наиболее широкой специализацией по числу лицензируемых видов медицинской деятельности?

SELECT 
    MIN(li.name) AS name,
    li.ogrn,
    COUNT(DISTINCT l.activity_name) AS count_of_activities
FROM lic_activ l
JOIN licenses li
    ON l.license_number = li.license_number
WHERE li.ogrn IS NOT NULL
GROUP BY li.ogrn
ORDER BY count_of_activities DESC
LIMIT 10;

-- 4. Какие сочетания медицинских направлений наиболее часто лицензируются вместе?

SELECT a.activity_name, b.activity_name, COUNT(*) AS Количество
FROM lic_activ a
JOIN lic_activ b
ON a.license_number = b.license_number
AND a.activity_number < b.activity_number
GROUP BY a.activity_name, b.activity_name
ORDER BY COUNT(*) DESC
LIMIT 20;

-- 5. Какова структура медицинских организаций по широте лицензируемого профиля?

SELECT COUNT(ogrn), 
CASE 
	WHEN count_act=1 THEN 'Узкопрофильное'
	ELSE 'Многопрофильное'
	END AS Профиль
FROM (
	SELECT li.ogrn, COUNT(DISTINCT l.activity_name) AS count_act
	FROM lic_activ l
	JOIN licenses li
	ON l.license_number=li.license_number
	WHERE li.ogrn IS NOT NULL
	GROUP BY li.ogrn
) AS profiles
GROUP BY Профиль

-- 6. Какие медицинские организации лицензируют виды медицинской деятельности, представленные в реестре единичными случаями?

SELECT li.ogrn, MIN(li.name) AS name
FROM licenses li
JOIN lic_activ l
    ON li.license_number = l.license_number
WHERE l.activity_name IN (
    SELECT activity_name
    FROM lic_activ
    GROUP BY activity_name
    HAVING COUNT(*) = 1
)
GROUP BY li.ogrn;