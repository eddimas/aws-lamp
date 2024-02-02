<!DOCTYPE html>
<html>
<head>
    <title>PHP Page</title>
</head>
<body>
    <h1>Welcome to my PHP Page!</h1>
    <?php
$servername = "mysql";
$username = "test_user";
$password = "password";
$dbname = "nation";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Realizar consulta SQL
$sql = "SELECT * FROM continents";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Mostrar resultados
  while($row = $result->fetch_assoc()) {
    echo "id: " . $row["id"]. " - Name: " . $row["name"]. "<br>";
  }
} else {
  echo "0 results";
}
$conn->close();
?>
</body>
</html>