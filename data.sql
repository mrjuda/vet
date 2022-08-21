/* Populate database with data. */
/* Build 1.1 */
BEGIN;
  INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
  VALUES ('Agumon','2020-02-03',0,true,10.23);

  INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
  VALUES ('Gabumon','2018-11-15',2,true,8);

  INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
  VALUES ('Pikachu','2021-01-07',1,false,15.04);

  INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
  VALUES ('Devimon','2017-05-12',5,true,11);
COMMIT;

SELECT * FROM animals;

/* build 1.2 */

BEGIN;
  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Charmander','2020-02-08',11,false,0,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Plantmon','2021-11-15',5.7,true,2,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Squirtle','1993-04-02',12.13,false,3,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Angemon','2005-06-12',45,true,1,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Boarmon','2005-06-07',20.4,true,7,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Blossom','1998-10-13',17,true,3,NULL);

  INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts,species)
  VALUES ('Ditto','2022-05-14',22,true,4, NULL);
COMMIT;

SELECT * FROM animals;

/* BUILD 1.3 */

-- Species

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

SELECT * FROM species;

-- Owners

INSERT INTO owners(full_name,age)
VALUES('Sam Smith',34);

INSERT INTO owners(full_name,age)
VALUES('JennifFer Orwell',19);

INSERT INTO owners(full_name,age)
VALUES('Bob',45);

INSERT INTO owners(full_name,age) 
VALUES('Melody Pond',77);

INSERT INTO owners(full_name,age) 
VALUES('Dean Winchestter',14);

INSERT INTO owners(full_name,age) 
VALUES('Jodie Whittaker',38);

SELECT * FROM owners;

-- Change species ids

UPDATE animals
SET species_id = (
  SELECT id FROM species WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (
  SELECT id FROM species WHERE name = 'Pokemon'
)
WHERE species_id IS NULL;

-- Set owners

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'JennifFer Orwell'
)
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Bob'
)
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Melody Pond'
)
WHERE name = 'Charmander'
OR
name = 'Squirtle'
OR
name = 'Blossom';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Dean Winchestter'
)
WHERE name = 'Angemon'
OR
name = 'Boarmon';

SELECT * FROM owners;

/* BUILD 1.4 */

-- Vets
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, 'Apr 23, 2000');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Maisy Smith', 26, 'Jan 17, 2019');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Stephanie Mendez', 64, 'May 4, 1981');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Jack Harkness', 38, 'Jun 8, 2008');


-- Specialties
INSERT INTO specializations (vet_id,specie_id) 
VALUES (1,1);

INSERT INTO specializations (vet_id,specie_id) 
VALUES (3,1);

INSERT INTO specializations (vet_id,specie_id) 
VALUES (3,2);

INSERT INTO specializations (vet_id,specie_id) 
VALUES (4,2);

-- Visits
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (1, 1, 'May 24, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (1, 3, 'Jul 22, 2020');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (3, 2, 'Jan 5, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (3, 2, 'Mar 8, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (3, 2, 'May 14, 2020');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (4, 3, 'May 4, 2021');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (5, 4, 'Feb 24, 2021');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (6, 2, 'Dec 21, 2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (6, 1, 'Aug 10, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (6, 2, 'Apr 7, 2021');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (7, 3, 'Sep 29, 2019');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (8, 4, 'Oct 3, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (8, 4, 'Nov 4, 2020');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (9, 2, 'Jan 24, 2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (9, 2, 'May 15, 2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (9, 2, 'Feb 27, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (9, 2, 'Aug 3, 2020');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (10, 3, 'May 24, 2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (10, 1, 'Jan 11, 2021');

SELECT * FROM visits;