/* BUILD 1.1 */

-- Animals whose name ends in "mon".
SELECT name
FROM animals
WHERE name LIKE '%mon';

-- Animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE
date_of_birth > '2015-12-31'
AND
date_of_birth < '2020-01-01';

-- Animals that are neutered and have less
-- than 3 escape attempts.
SELECT name
FROM animals
WHERE
neutered = TRUE
AND
escape_attempts < 3;

-- Date of birth of all animals named either
-- "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE
name = 'Agumon'
OR
name = 'Pikachu';


-- Name and escape attempts of animals
-- that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE
weight_kg > 10.5;


-- Animals that are neutered.
SELECT name
FROM animals
WHERE
neutered = TRUE;

-- Animals not named Gabumon.
SELECT name
FROM animals
WHERE
name NOT LIKE 'Gabumon';

-- Animals with a weight between 10.4kg
-- and 17.3kg (including animals with
-- the weights that equals precisely
-- 10.4kg or 17.3kg)
SELECT name, weight_kg
FROM animals
WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3);


/* BUILD 1.2 */

-- How many animals are there?
SELECT count(*) FROM animals;

-- How many animals have never tried to escape?
SELECT count(*)
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name,escape_attempts
FROM animals
WHERE escape_attempts = (
  SELECT max (escape_attempts)
  FROM animals
);

-- What is the minimum and maximum weight of
-- each type of animal?
SELECT species,MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species,MIN(weight_kg)
FROM animals
GROUP BY species;

-- What is the average number of escape attempts
-- per animal type of those born between 1990 and 2000?

SELECT species,AVG(escape_attempts)
FROM animals
WHERE date_of_birth > '1989-12-31'
AND date_of_birth < '2001-01-01'
GROUP BY species;

SELECT name,species,date_of_birth,escape_attempts FROM animals;

BEGIN;
    UPDATE animals
    SET species = NULL;
COMMIT;

BEGIN;
    UPDATE animals
    SET species = 'Unspecified';
ROLLBACK;

BEGIN;
    UPDATE animals
    SET species = 'digimon'
    WHERE name LIKE '%mon';
COMMIT;

BEGIN;
    UPDATE animals
    SET species = 'pokemon'
    WHERE species IS NULL;
COMMIT;

BEGIN;
    DELETE FROM animals;
ROLLBACK;

UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE id = 1;

BEGIN;
    DELETE FROM animals
    WHERE date_of_birth > '2022-01-01';
    SAVEPOINT SP1;

    UPDATE animals
    SET weight_kg = weight_kg * -1;
    ROLLBACK TO SAVEPOINT SP1;

    UPDATE animals
    SET weight_kg = weight_kg * -1;
COMMIT;

SELECT id,name,weight_kg FROM animals;

/* BUILD 1.3 */

-- What animals belong to Melody Pond?
SELECT animals.id,name,full_name AS owner FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon
-- (their type is Pokemon).
SELECT animals.id,animals.name,species.name
AS specie FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

-- List all owners and their animals,
-- remember to include those that don't own any animal.
SELECT owners.id,full_name
AS owner_name,animals.name
AS animal_name 
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name
AS specie, COUNT(*)
FROM animals
JOIN species ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT full_name
AS owner_name,animals.name
AS animal_name,species.name
AS specie
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Digimon'
AND
full_name = 'JennifFer Orwell';

-- List all animals owned by Dean Winchester
-- that haven't tried to escape.
SELECT full_name
AS owner_name,animals.name
AS animal_name,escape_attempts
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE escape_attempts = 0
AND
full_name = 'Dean Winchestter';

-- Who owns the most animals?
SELECT full_name,COUNT(*)
FROM animals
RIGHT JOIN owners
ON owners.id = animals.owner_id
GROUP BY full_name
ORDER BY COUNT(*) DESC;
