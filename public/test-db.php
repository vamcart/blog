<?php
$servername = "database";
$username   = "docker";
$password   = "docker";
$dbname     = "docker";

// 1. Create the connection
$conn = new mysqli($servername, $username, $password, $dbname);

// 2. Check the connection
if ($conn->connect_error) {
    // Stop execution and log the error
    die("Connection failed: " . $conn->connect_error);
}

echo "Connected successfully using MySQLi!";
?>