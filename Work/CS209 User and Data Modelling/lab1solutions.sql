-- i)

 --\d hmolicense;

-- ii)

 --SELECT license_number FROM hmolicense WHERE number_of_bedrooms < occupant_capacity;

-- iii)

 --SELECT expiry_date, living_accommodation FROM hmolicense WHERE (expiry_date >= '2023-01-01' and expiry_date < '2024-01-01');

-- iv)

 --SELECT license_number, ward, occupant_capacity FROM hmolicense WHERE licence_holder LIKE '%Strathclyde%';
