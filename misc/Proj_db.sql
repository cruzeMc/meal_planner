CREATE DATABASE tester;
USE tester;

CREATE TABLE user(
  user_id INT(10) AUTO_INCREMENT NOT NULL,
  username varchar(30) NOT NULL,
  password varchar(20) NOT NULL,
  last_name varchar(30) NOT NULL,
  first_name varchar(30) NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE recipe(
  recipe_id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(10) NOT NULL,
  recipe_name VARCHAR(30) NOT NULL,
  recipe_description VARCHAR(40), 
  calorie_count INT(10) NOT NULL,
--   instruction_id INT (5) NOT NULL,
  PRIMARY KEY (recipe_id)
);

-- create table recipe_instruction(
--     recipe_id INT(10) NOT NULL,
--     instruction_id INT(10) NOT NULL,
--     PRIMARY KEY (instruction_id),
--     FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
--     FOREIGN KEY(instruction_id) REFERENCES instruction(instruction_id) ON UPDATE CASCADE ON DELETE RESTRICT
-- );


-- CREATE TABLE step_instruction(
--     instruction_id INT(10) NOT NULL,
--     step_id INT(10) NOT NULL,
--     PRIMARY KEY(step_id),
--     FOREIGN KEY(instruction_id) REFERENCES instruction(instruction_id) ON UPDATE CASCADE ON DELETE RESTRICT
--     FOREIGN KEY (step_id) REFERENCES step(step_id) ON UPDATE CASCADE ON DELETE CASCADE
-- );

CREATE TABLE step(
  step_id INT(10) AUTO_INCREMENT NOT NULL,
--   instruction_id INT(10) NOT NULL,
  step_number INT(2) NOT NULL,
  step_description VARCHAR(50) NOT NULL,
  PRIMARY KEY (step_id)
--   FOREIGN KEY (instruction_id) REFERENCES instruction(instruction_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE instruction(
  instruction_id INT(10) AUTO_INCREMENT NOT NULL,
  recipe_id INT(10) NOT NULL,
  step_id INT(10) NOT NULL,
  PRIMARY KEY (instruction_id,recipe_id,step_id),
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (step_id) REFERENCES step(step_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE kitchen(
  kitchen_id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(10) NOT NULL,
  PRIMARY KEY (kitchen_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ingredient(
  ingredient_id INT(10) AUTO_INCREMENT NOT NULL,
  ingredient_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (ingredient_id)
);
 
CREATE TABLE meal(
  meal_id INT(10) AUTO_INCREMENT NOT NULL,
  category_id INT(10) NOT NULL,
  meal_name VARCHAR(30) NOT NULL,
  serving_size INT(3) NOT NULL,
  meal_image VARCHAR(40) NOT NULL,
  PRIMARY KEY (meal_id)
);
 
CREATE TABLE category(
  category_id INT(10) AUTO_INCREMENT NOT NULL,
  category_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (category_id)
);

CREATE TABLE measurement(
  measurement_id INT(10) AUTO_INCREMENT NOT NULL,
  measurement_name VARCHAR(10) NOT NULL,
  PRIMARY KEY (measurement_id)
);


CREATE TABLE user_recipe(
  user_id INT(10) NOT NULL,
  recipe_id INT(10) NOT NULL,
  creation_date date NOT NULL,
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ingredient_kitchen(
  ingredient_id INT(10) NOT NULL,
  kitchen_id INT(10) NOT NULL,
  measurement_id VARCHAR(10) NOT NULL,
  kitchen_quantity INT(10) NOT NULL,
  PRIMARY KEY (ingredient_id, kitchen_id),
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY(kitchen_id) REFERENCES kitchen(kitchen_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ingredient_recipe(
  ingredient_id INT(10) NOT NULL,
  recipe_id INT(10) NOT NULL,
  measurement_id VARCHAR(10) NOT NULL,
  recipe_quantity INT(10) NOT NULL,
  PRIMARY KEY (ingredient_id, recipe_id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE recipe_meal(
  recipe_id INT(10) NOT NULL,
  meal_id INT(10) NOT NULL,
  PRIMARY KEY (recipe_id, meal_id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (meal_id) REFERENCES meal(meal_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

