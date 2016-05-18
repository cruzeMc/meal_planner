
<?php
	//include('login.php'); // Includes Login Script

	/*if(isset($_SESSION['login_user'])){
		header("location: home.php");
	}*/
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Login Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="/js/jquery-2.2.2.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	</head>
	<body class="green">
		<div id="login-page" class="row" style="width:500px;height:100%;">
			<div id="main">
				<h1>Login</h1>

				<div id="login">
					<h2>Login Form</h2>
					<form action="login.php" method="post">
						<label>UserName :</label>
						<input id="name" name="username" type="text">
						<label>Password :</label>
						<input id="password" name="password" type="password">
						<input name="submit" type="submit" value=" Login ">
						<!-- <span><?php #echo $error; ?></span> -->
					</form>
					<form action="newUserForm.php">
    				<input type="submit" value="New User">
					</form>
				</div>
			</div>
		</div>
	</body>
</html>