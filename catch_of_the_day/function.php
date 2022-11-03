<!DOCTYPE html>
<html>

<head>
</head>

<body>
<table border="1" align="left">
<tr>
  <td>Location Name</td>
</tr>

<?php // signifies the start of PHP code

/************
//    CS 460 Fall 2021
//    Find Likely Location Function
//    Sean Connors
*************/

require_once '/home/SOU/connorss/dbconfig.php';

// Turn error report on
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
ini_set('display_errors', '1');

$conn = new mysqli($hostname,$username,$password,$schema);

if ($conn->connect_error) {
  die("Database connection failed: " . $conn->connect_error);
}

if(isset($_POST['submit'])) {
 
  $id_fish = $_POST['id_fish']; 
  echo "<h2> Function that returns a likely location </h2>";
  echo "<h4> Sean Connors </h4>";
  echo "<p> Fish ID Used: $id_fish. </p>";
  echo "<p> The result below is a river you are likely to catch a fish with ID $id_fish. </p>";
}
        
  $query = "SELECT find_likely_location('$id_fish')";

  //Query assignment
  $call_func = $conn->query($query) or die($conn->error);

  //Assigns the fetched results into $result
  $result = $call_func->fetch_row();
  
  //If a result exists, it will return the one value to the single column/row table.
  if ($result) {
    echo "<tr><td>$result[0]</td> </tr>";
  }
  else {
    echo "--------ERROR--------";
  }
    
mysqli_free_result($call_func);

// close connection
$conn->close(); 
?> <!-- signifiies the end of PHP code -->
</body>
</html>