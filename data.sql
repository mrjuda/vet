/* Populate database with sample data. */
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

  SELECT * FROM animals;
COMMIT;
