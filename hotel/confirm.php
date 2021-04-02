<?php

include 'settings.php';


$query = "SELECT * FROM bookingHistory INNER JOIN room ON bookingHistory.roomNumber = room.roomNumber INNER JOIN hotel ON room.hotel_id = hotel.hotel_id ORDER BY  bookingHistory.booking_id  DESC LIMIT 1;";
$link = pg_connect("host=$host port=$port dbname=$database user=$username password=$password");
$result = pg_query( $link , $query);

$row =  pg_fetch_array($result, NULL, PGSQL_ASSOC);

echo "<h1> Thank you for booking at ".$row['hotelbrandname'] ."</h1>";
echo "<BR>";
echo "<b>Address:</b>" . $row['addressofhotel'] . "<BR><BR>";
echo "<b>Check In Date: </b>" . $row['date_in'] . "<BR>";
echo "<b>Check Out Date: </b>" . $row['date_out'] . "<BR>";

$days = $row['totalprice'] / $row['price'];  /* we dont have a total amount on our history*/
$rate = $row['totalprice'] / $days;  /* same issue and below */


echo "<b>Total: </b> ". $days . " nights * $". $rate . ".00 = $" . $row['totalprice'] . ".00";
echo "<br><br><a href='index.php'> Log Out</a>"

?>
