<?php	
	session_start();
	$userName = $_SESSION["username"];
?>
<!DOCTYPE html>
<html>
	<head>
		<title> New Recipe </title>
	</head>

	<body>
	
	<?php

	$servername = getenv('IP');
    $username = getenv('C9_USER');
    $password = "";
    $database = "tester";
    $dbport = 3306;

	$db=mysqli_connect($servername, $username, $password, $database, $dbport);
	
    // Check connection
    if ($db->connect_error) {
        die("Connection failed: " . $db->connect_error);
    } 
    echo "Connected successfully (".$db->host_info.")";


	if(isset($_POST['action'])){

	if (!$db){
		die("Error with connecting:  " .mysql_error());
	}


	mysqli_select_db($db,"tester");
	
	
	$userID = "SELECT user_id FROM user WHERE username = '$username'";
	$result = mysqli_query($db, $userID);
	
	$row_userid = mysqli_fetch_assoc($result);
	$add = print_r($row_userid);
	
	$insertRecipe = "INSERT INTO `recipe` (`user_id`,`recipe_name`, `recipe_description`,`calorie_count`) VALUES ('$add','$_POST[recipe_name]', '$_POST[recipe_description]', '$_POST[calorie_count]')";
	mysqli_query($db, $insertRecipe);
	$recipe_ID = mysqli_insert_id($db);
	// to be reconfirmed
	$insertStep="INSERT INTO `step` (`step_number`,`step_description`) VALUES ('$_POST[stepno1]', '$_POST[ins1]'),('$_POST[stepno2]', '$_POST[ins2]'),('$_POST[stepno3]', '$_POST[ins3]'),('$_POST[stepno4]', '$_POST[ins4]')";
	mysqli_query($db, $insertStep);
	$step_ID = mysqli_insert_id($db);
	
	$insertIns="INSERT INTO `instruction` (`recipe_id`,`step_id`) VALUES ('$recipe_ID','$step_ID')";
	if(mysqli_query($db, $insertIns)){
	echo "New record created successfully";
	} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($db);
	}
	
	$insertdate= "insert into `user_recipe` (`user_id`,`recipe_id`,`creation_date`) values ('$add','$recipe_ID', CURDATE())";	
	if(mysqli_query($db, $insertdate)){
		echo "New record created successfully";
	}
	 else {
    echo "Error: " . $sql . "<br>" . mysqli_error($db);
	}

	$insertCat= "INSERT INTO `category` (`category_name`) VALUES ('$_POST[category]')";
	mysqli_query($db, $insertCat);
	
	$insert_measure="INSERT INTO `ingredient_recipe` (`ingredient_id`,`recipe_id`,`measurement_id`,`recipe_quantity`) VALUES ('$_POST[item1]','$recipe_ID','$_POST[measure1]','$_POST[quantity1]'),('$_POST[item2]','$recipe_ID','$_POST[measure2]','$_POST[quantity2]'),('$_POST[item3]','$recipe_ID','$_POST[measure3]','$_POST[quantity3]')";
	if(mysqli_query($db, $insert_measure)) {
	echo "New record created successfully";
	} else {
     echo "Error: " . $sql . "<br>" . mysqli_error($db);
	}
	
	// header("Location: index.php");
	
	mysqli_close ($db);
	}

	?>
</body>
</html>