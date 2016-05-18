
<!DOCTYPE html>
<html>
	<head>
		<title> Add Recipe </title>
		<script src="/js/jquery-2.2.2.min.js"></script>
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Tangerine|Inconsolata|Droid+Sans">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        </style>
	</head>

	<body class="pink">
		<div id="recipe-page" class="row" style="width:500px;height:100%;">
			<div class="col s12 z-depth-6 card-panel">
				<div class="row">
          			<div class="input-field col s12 center">
            			<p class="center login-form-text">Add Recipe</p>
          			</div>
        		</div>
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
							
									
										mysqli_select_db($db,"tester");
										?>
	
	
		<div class = "login">
			<p> Please fill out all fields below! </p>

			<form id="loginForm" method="post" action="mkrecipe.php">
				<fieldset>
					Recipe Name: <input size="30" type="text" name="recipe_name"/><br/><br/>
					Description: <input size="20" type="text" name="recipe_description"/><br/><br/>
					Calorie Count: <input size="30" type="text" name="calorie_count"/><br/><br/>
					Category: <input size="30" type="text" name="category"/><br/><br/>
					
					<table class="table table-bordered table-condensed" id="myTable">
					    <tbody>
					    	<H5>Ingredients</h5>
					    	<thead>
			                <tr>
			                    <th>Quantity (eg.1/2)</th>
			                    <th>Measurement(eg. cups)</th>
			                    <th>Ingredient (eg. Flour)</th>
			                </tr>
				            </thead>
					        <tr>
					           <td><input type="text" name='quantity1' class="form-control" /></td>
					           <td>	<select  name='measure1' class="browser-default col s12 l6">
										<?php
										$measure="select distinct measurement_name,measurement_id from measurement"; 
										// distinct
										$vals = mysqli_query($db,$measure);
										
										while ($row = mysqli_fetch_assoc($vals)){
											echo "<option value=$row[measurement_id]>$row[measurement_name]</option>";
										}
									
										?>
									</select>
								</td>
					           <td>	<select  name='item1' class="browser-default col s12 l6">
										<?php
										$dropdown="select distinct ingredient_name,ingredient_id from ingredient"; 
										// distinct
										$items = mysqli_query($db,$dropdown);
										
										while ($row = mysqli_fetch_assoc($items)){
											echo "<option value=$row[ingredient_id]>$row[ingredient_name]</option>";
										}
									
										?>
									</select>
								</td>
					        </tr>
					         <tr>
					           <td><input type="text" name='quantity2' class="form-control" /></td>
					           <td>	<select  name='measure2' class="browser-default col s12 l6">
										<?php
										$measure="select distinct measurement_name,measurement_id from measurement"; 
										// distinct
										$vals = mysqli_query($db,$measure);
										
										while ($row = mysqli_fetch_assoc($vals)){
											echo "<option value=$row[measurement_id]>$row[measurement_name]</option>";
										}
									
										?>
									</select>
								</td>
					           <td>	<select  name='item2' class="browser-default col s12 l6">
										<?php
										$dropdown="select distinct ingredient_name,ingredient_id from ingredient"; 
										// distinct
										$items = mysqli_query($db,$dropdown);
										
										while ($row = mysqli_fetch_assoc($items)){
											echo "<option value=$row[ingredient_id]>$row[ingredient_name]</option>";
										}
									
										?>
									</select>
								</td>
					        </tr>
					         <tr>
					           <td><input type="text" name='quantity3' class="form-control" /></td>
					           <td>	<select  name='measure3' class="browser-default col s12 l6">
										<?php
										$measure="select distinct measurement_name,measurement_id from measurement"; 
										// distinct
										$vals = mysqli_query($db,$measure);
										
										while ($row = mysqli_fetch_assoc($vals)){
											echo "<option value=$row[measurement_id]>$row[measurement_name]</option>";
										}
									
										?>
									</select>
								</td>
					           <td>	<select  name='item3' class="browser-default col s12 l6">
										<?php
										$dropdown="select distinct ingredient_name,ingredient_id from ingredient"; 
										// distinct
										$items = mysqli_query($db,$dropdown);
										
										while ($row = mysqli_fetch_assoc($items)){
											echo "<option value=$row[ingredient_id]>$row[ingredient_name]</option>";
										}
									
										?>
									</select>
								</td>
					        </tr>
					    </tbody>
					</table>
					
					<h5>Steps</h5>
					
					<table>
				        <thead>
				          <tr>
				              <th data-field="id">Step Number</th>
				              <th data-field="name">Step Description</th>
				          </tr>
				        </thead>
				
				        <tbody>
				          <tr>
				          	<td><div class="input-field col s6">
						            <input id="input_text" name="stepno1" type="text" length="2">
						            <label for="input_text">Add step no.</label>
						          </div></td>
				            <td><div class="input-field col s12">
						          <textarea id="textarea1" name="ins1" class="materialize-textarea"></textarea>
						          <label for="textarea1">Place your instruction here...</label>
						        </div>
						    </td>
				            
				          </tr>
				          <tr>
				            <td><div class="input-field col s6">
					            <input id="input_text" name="stepno2"type="text" length="2">
					            <label for="input_text">Add step no.</label>
					          </div></td>
				            <td><div class="input-field col s12">
					          <textarea id="textarea1" name="ins2" class="materialize-textarea"></textarea>
					          <label for="textarea1">Place your instruction here...</label>
					        </div></td>
				          </tr>
				          <tr>
				            <td><div class="input-field col s6">
					            <input id="input_text" name="stepno3" type="text" length="2">
					            <label for="input_text">Add step no.</label>
					          </div></td>
				            <td><div class="input-field col s12">
					          <textarea id="textarea1" name="ins3" class="materialize-textarea"></textarea>
					          <label for="textarea1">Place your instruction here...</label>
					        </div></td>
				          </tr>
				           <tr>
				            <td><div class="input-field col s6">
					            <input id="input_text" name="stepno4" type="text" length="2">
					            <label for="input_text">Add step no.</label>
					          </div></td>
				            <td><div class="input-field col s12">
					          <textarea id="textarea1" name="ins4" class="materialize-textarea"></textarea>
					          <label for="textarea1">Place your instruction here...</label>
					        </div></td>
				          </tr>
				        </tbody>
				      </table>
					
			
						<button class="btn waves-effect waves-light col s12" type="submit" name="action">
									<i class="material-icons left">send</i>
									Submit
									<i class="material-icons right">send</i>
								</button>
				</fieldset>

			</form>
		</div>

	</body>
</html>