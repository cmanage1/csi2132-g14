<?php

include 'settings.php';


$room = $_GET['room_id'];
$in  =  $_GET['date_in'];
$out  = $_GET['date_out'];
$bookingID = rand(1000,9999) ;

$e_in = strtotime($in);
$e_out = strtotime($out);

$e_day = 86400;


$booked = array();

for($i=$e_in;$i<$e_out;$i+= $e_day){
  array_push($booked,($e_in + $i));
}

$num_days = sizeof($booked);
$total = $num_days * $_GET['price'];

if($e_out < $e_in){// doesnt work
  header("Location: room.php?room=".$room."&e=invalid&date_in=".$date_in."&date_out=".$date_out);
}

$user = RAND(1000,9999);
$query1 = "INSERT INTO customer (customer_id,firstname,lastname,address,sinnumber,dateofregistration,roomtypebooked,numberofoccupants,phone) VALUES ($user, $fName,$lName,$address,$sin,null,null,null,$phone);";
$query = "INSERT INTO  bookingHistory  (booking_id, roomNumber, customer_id,  date_in,  date_out,totalprice) VALUES ($bookingID,  $room, $user, '$in' , '$out', $total );";

$link = pg_connect("host=$host port=$port dbname=$database user=$username password=$password");
$result = pg_query( $link , $query);;
pg_close();

header("Location: confirm.php");




?>
