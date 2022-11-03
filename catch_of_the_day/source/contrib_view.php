<!DOCTYPE html>
<html>
<head>
<!-- 
*	Filename: contrib_view.php
* 	Author: Sean Connors
*	Class: CS460
*
*	Purpose: This php file allows for the ability for the contributor view 
*   to be accessed with a particular group that is given from the corresponding html file.
*
-->
</head>

<body>
<!-- This section is simply the header and the instantiation of the table.-->

<h2> Contributor View </h2>
	<h4> Author: Sean Connors </h4>
	<h4 style="display:inline;">Description: </h4>
	<p style="display:inline;"> This pages shows all of the data that a contributor is allowed to view based on the group 
	 that they are in. </p>
<br/>
<br/>
<!-- start of table to hold data return by query -->
<table border="1" align="left">
<tr>
<!-- Table column names -->

  <th>Location Name </th>
  <th>Contributor Name</th>
  <th>Fish Name</th>
  <th>Technique Name</th>
  <th>Weight</th>
</tr>

<?php // start of php

require_once '/home/SOU/connorss/dbconfig.php';

error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
ini_set('display_errors', '1');

$dbconnect = new mysqli($hostname,$username,$password,$schema);

if (mysqli_connect_errno()) {
  printf("Database connection failed: " . mysqli_connect_errno());
  exit();
}
//echo "Connected Successfully"; 

if(isset($_POST['submit'])) {
	// For the view, the input is only one variable which is the id of the group we care about.
	$name = $_POST['id_group']; 

	// This is a very important bit of code, where the query is run that takes the group id we care about, and returns all of the information except for the group id.
	$stmt = $dbconnect->query("SELECT location_name, contrib_name, fish_name, technique_name, weight from contributor_view where id_group = $name")
	  	or die($dbconnect->error);
	

    if ($stmt->num_rows > 0){
		// Display the data from the view below
		while($row = $stmt->fetch_assoc()) {  
			echo "
				<tr>
				<td>{$row['location_name']}</td>  
				<td>{$row['contrib_name']}</td>
				<td>{$row['fish_name']}</td>
                <td>{$row['technique_name']}</td>
                <td>{$row['weight']}</td>
				</tr>\n";  
		}
		echo "</table>"; // when there are not more rows to process close the HTML table
	} else {
		echo "</table><br><br>No results found "; // This will display if there is no information for the given contributor group.
	}
	$stmt->free_result();
	$dbconnect->close(); 
}

?> <!-- end of php -->
</body>
</html>