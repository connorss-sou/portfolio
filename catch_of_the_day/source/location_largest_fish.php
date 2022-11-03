<!DOCTYPE html>
<html>
<head>
<!-- 
*	Filename: location_largest_fish.php
* 	Author: Sean Connors
*	Class: CS460
*
*	Purpose: This php file has the purpose of allowing the user to find the largest fish at the location desired.
*   This works by calling my stored procedure with the input parameter passed from the dropdown menu in the html file for the procedure.
*
-->
</head>

<body>

<h2> Location Largest Fish</h2>
	<h4> Author: Sean Connors </h4>
	<h4 style="display:inline;">Description: </h4>
	<p style="display:inline;"> This page shows the details of the largest fish based on the given location. </p>
<br/>
<br/>
<!-- Create the table that the output will be displayed in -->
<table border="1" align="left">
<tr>
  <th>Largest Fish</th>
  <th>Weight(lbs)</th>
  <th>Technique Used</th>
</tr>

<?php // Start of php

require_once '/home/SOU/connorss/dbconfig.php';

// Turn error reporting on
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
ini_set('display_errors', '1');

// create connection to DB - OOP
$dbconnect = new mysqli($hostname,$username,$password,$schema);

if (mysqli_connect_errno()) {
  printf("Database connection failed: " . mysqli_connect_errno());
  exit();
}
//echo "Connected Successfully"; 
// The next row takes the post data from the previous file which is procedure.html
if(isset($_POST['submit'])) {
	$name = $_POST['id_location']; /* This only needs one variable, and this is the id of the location that we want to see the largest fish */
	// This next line calls the procedure using a query, which is important because it stores the result of what the procedure returns from using $name given.
	$stmt = $dbconnect->query("CALL location_largest_fish($name)")
	  	or die($dbconnect->error);
	
    if ($stmt->num_rows > 0){
		/* This will display the output in the table with the corresponding columns. */
		while($row = $stmt->fetch_assoc()) {  
			echo "
				<tr>
				<td>{$row['largest_fish']}</td>  
				<td>{$row['weight']}</td>
				<td>{$row['technique_used']}</td>
				</tr>\n";  
		}
		echo "</table>"; 
	} else {
		// If nothing is returned, this will be returned.
		echo "</table><br><br>No results found "; 
	}
	// free result set (acts on statement object not mysqli object)
	$stmt->free_result();
	//close connection using mysqli object
	$dbconnect->close(); 
}

?> <!-- signifiies the end of PHP code -->
</body>
</html>