<!DOCTYPE html>
<html>
<head>
<!-- 
*	Filename: group_change_log.php
* 	Author: Sean Connors
*	Class: CS460
*
*	Purpose: This php file is a big one because it takes the 2 inputs from the trigger.html document and updates the database's contributor table.
*   After this is done, it displays the group change log table, and shows the user what the result of their change was.
*
-->
</head>

<body>
<!-- Header elements. -->
<h2>Change Log For Group Change Log</h2>
	<h4> Author: Sean Connors </h4>
	<h4 style="display:inline;">Description: </h4>
	<p style="display:inline;"> This page shows the results of edits made to a group. It is displaying the group change log. 
	If nothing appears and an error message appears on the left, hit the back button and try again.</p>
<br/>
<br/>
<!-- start of table to hold data return by query -->
<table border="1" align="left">
<tr>
  <th>Entry Number</th>
  <th>Group Change</th>
  <th>Group Removal</th>
  <th>ID of Contributor</th>
  <th>Previous Group ID</th>
  <th>New Group ID</th>
  <th>Date/Time of Change</th>
</tr>

<?php // Start of php

// include credientals which should be stored outside your root directory (i.e. outside public_html)
// do NOT use '../' in file path
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
// Gives the php document the information that was sent from the trigger.html document. 
if(isset($_POST['submit'])) {
	// Seperates the result into two variables id_contrib, and id_group
	$id_contrib = $_POST['id_contrib'];
    $id_group = $_POST['id_group'];
    // This query updates the contributor table in the database with theid of the group to move the contributor to, or the removal.
    $update_result = $dbconnect->query("UPDATE contributor SET id_group = $id_group WHERE id_contrib = $id_contrib") or die($dbconnect->error);
	// This query displays the log, so that the user is able to view the newly changed database.
	$query_result = $dbconnect->query("SELECT * FROM contrib_group_log") or die($dbconnect->error);
	
    if ($query_result->num_rows > 0){
		// This simply places the data in the correct location in the table.
		while($row = $query_result->fetch_assoc()) {  
			echo "
                
				<tr>
				<td>{$row['entry_no']}</td>  
				<td>{$row['group_change']}</td>
				<td>{$row['group_removal']}</td>
                <td>{$row['id_contrib']}</td>
                <td>{$row['old_id_group']}</td>
				<td>{$row['new_id_group']}</td>
                <td>{$row['date_time']}</td>
				</tr>\n";  
		}
		echo "</table>"; 
	} else {
		echo "</table><br><br>No results found ";
	}
	
	$query_result->free_result();
	//close connection using mysqli object
	$dbconnect->close(); 
}

?> <!-- end of php -->
</body>
</html>