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

/* Build 1.4 */
/* The code below were added during the previous feature (1.3) for time sake */

-- Who was the last animal seen by William Tatcher?
SELECT animals.name as animal_name, date_of_visit, vets.name as vet_name 
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit LIMIT 1;

-- 2- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) as different_animals_seen
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- 3- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name as specialty 
FROM specializations
RIGHT JOIN vets ON specializations.vet_id = vets.id
LEFT JOIN species ON specializations.specie_id = species.id;

-- 4- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT DISTINCT animals.name as animal_name, date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Stephanie Mendez' 
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- 5- What animal has the most visits to vets?
SELECT animals.name as animal_name, COUNT(*) as visits_to_vets
FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visits_to_vets DESC LIMIT 1;

-- 6- Who was Maisy Smith's first visit?
SELECT animals.name as animal_name, date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit LIMIT 1;

-- 7- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name as animal_name, date_of_birth, escape_attempts, neutered, weight_kg,
vets.name as vet_name, vets.age as vet_age, date_of_graduation,
date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id 
ORDER BY date_of_visit DESC LIMIT 1;

-- 8- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS visits_to_non_specialists 
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE animals.species_id NOT IN (
  SELECT specie_id FROM specializations
  WHERE specializations.vet_id = vets.id
);

-- 9- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as specialty, COUNT(*) as visits_by_specie
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visits_by_specie DESC;