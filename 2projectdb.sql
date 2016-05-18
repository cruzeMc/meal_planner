--Go over deletes
--Calorie count in recipe table as opposed to making an INTermediary table recipe_meal
--Step table to hold the instruction text fields
--Address table, new address for each user
-- Meal plans need to be generated, not necessarily saved
-- Measurements table to hold predefined measurements
-- Days

--** Expiry date
--** Export meal plan

CREATE TABLE user(
  user_id INT(5) AUTO_INCREMENT NOT NULL,
  username varchar(30) NOT NULL,
  password varchar(20) NOT NULL,
  last_name varchar(30) NOT NULL,
  first_name varchar(30) NOT NULL,
  address_id int(10) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE address(
  address_id INT(10) AUTO_INCREMENT NOT NULL,
  parish VARCHAR(20) NOT NULL,
  street VARCHAR(40) NOT NULL,
  PRIMARY KEY (address_id)
);

CREATE TABLE recipe(
  recipe_id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(10) NOT NULL,
  recipe_name VARCHAR(30) NOT NULL,
  recipe_description VARCHAR(40), 
  calorie_count INT(10) NOT NULL,
  instruction_id INT (5) NOT NULL,
  PRIMARY KEY (recipe_id),
  --FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
  --FOREIGN KEY (instruction_id) REFERENCES instruction(instruction_id) ON UPDATE CASCADE ON DELETE CASCADE
); 

CREATE TABLE recipetest(
  recipe_id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(5) NOT NULL,
  recipe_name VARCHAR(30) NOT NULL,
  recipe_description VARCHAR(40), 
  calorie_count INT(10) NOT NULL,
  PRIMARY KEY (recipe_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE instruction(
  instruction_id INT(10) AUTO_INCREMENT NOT NULL,
  recipe_id INT(10) NOT NULL,
  PRIMARY KEY (instruction_id/*, recipe_id */),
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE step(
  instruction_id INT(10) NOT NULL,
  step_number INT(2) NOT NULL,
  step_description VARCHAR(50) NOT NULL,
  PRIMARY KEY (instruction_id, step_number),
  FOREIGN KEY (instruction_id) REFERENCES instruction(instruction_id) ON UPDATE CASCADE ON DELETE CASCADE
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
  description VARCHAR(50) NOT NULL,
  PRIMARY KEY (ingredient_id)
 );
 
CREATE TABLE meal(
  meal_id INT(10) AUTO_INCREMENT NOT NULL,
  category_id INT(10) NOT NULL,
  meal_name VARCHAR(30) NOT NULL,
  serving_size INT(3) NOT NULL,
  meal_image VARCHAR(60) NOT NULL,
  PRIMARY KEY (meal_id),
  FOREIGN KEY(category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
 );
 
CREATE TABLE category(
  category_id INT(10) AUTO_INCREMENT NOT NULL,
  category_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (category_id)
);

CREATE TABLE measurement( --cup, tsp, tbsp, oz, ect
  measurement_id INT(10) AUTO_INCREMENT NOT NULL,
  measurement_name VARCHAR(10) NOT NULL,
  PRIMARY KEY (measurement_id)
);


 
 -------------------------- intermediary Tables ------------------------------------------------------------------------
 
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
  measurement_name VARCHAR(10) NOT NULL,
  recipe_quantity INT(10) NOT NULL,
  PRIMARY KEY (ingredient_id, recipe_id),
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT
);



CREATE TABLE ingredient_recipe(
  ingredient_id INT(10) NOT NULL,
  recipe_id INT(10) NOT NULL,
  measurement_name VARCHAR(10) NOT NULL,
  recipe_quantity INT(10) NOT NULL,
  PRIMARY KEY (ingredient_id, recipe_id),
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY(recipe_id) REFERENCES recipetest(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT
);





CREATE TABLE user_recipe(
  user_id INT(5) NOT NULL,
  recipe_id INT(10) NOT NULL,
  creation_date DATETIME NOT NULL DEFAULT (GETDATE());
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN key (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE user_recipe(
  user_id INT(10) NOT NULL,
  recipe_id INT(10) NOT NULL,
  creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY(recipe_id) REFERENCES recipetest(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN key (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
);



CREATE TABLE recipe_meal(
  recipe_id INT(10) NOT NULL,
  meal_id INT(10) NOT NULL,
  PRIMARY KEY (recipe_id, meal_id),
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN key (meal_id) REFERENCES meal(meal_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE user_meal_plan(
  meal_plan_id INT(10) NOT NULL,
  user_id INT(10) NOT NULL,
  PRIMARY KEY (user_id, meal_plan_id),
  FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN key (meal_plan_id) REFERENCES meal_plan(meal_plan_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
  