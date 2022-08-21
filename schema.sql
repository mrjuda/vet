/* Database schema to keep the structure of entire database. */

-- DROP TABLE animals;

/* Build 1.1 */

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

/* Build 1.2 */
ALTER TABLE animals
ADD COLUMN species varchar;

/* Build 1.3 */

CREATE TABLE owners (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_species
        FOREIGN KEY(species_id)
            REFERENCES species(id)

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_owners
        FOREIGN KEY(owner_id)
            REFERENCES owners(id)

SELECT * FROM species;

/* BUILD 1.4 */
/* The code below were added during the previous feature (1.3) for time sake */

CREATE TABLE vets (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    vet_id INT NOT NULL,
    specie_id INT NOT NULL,
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY (specie_id) REFERENCES species(id)
);

CREATE TABLE visits (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE NOT NULL,
    CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id)
);
