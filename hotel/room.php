<?php

include 'settings.php';

$room_id = $_GET['room'];

$query = "SELECT * FROM room INNER JOIN hotel ON room.hotel_id = hotel.hotel_id  WHERE roomnumber = ".$room_id." LIMIT 1;";
$query2 = "SELECT * FROM customer WHERE f = ".$room_id." LIMIT 1;";

$link = pg_connect("host=$host port=$port dbname=$database user=$username password=$password");
$result = pg_query( $link , $query);

$row = pg_fetch_array($result, NULL, PGSQL_ASSOC);

echo "<h1>".$row['hotelbrandname'] .": $".  $row['price'] . " /night </h1>";

echo "<BR>";

echo "<b>Address:</b>" . $row['addressofhotel'];

echo "<BR><BR>";

$fridge = $row['spec_fridge'] ? "Yes" : "No" ;
$ac = $row['spec_ac'] ? "Yes" : "No";
$tv = $row['spec_tv'] ? "Yes" : "No";
$extendable = $row['spec_extendable'] ? "Yes" : "No";


echo "<table border='1px'>
  <tr>
    <th align='left'>Fridge</th> <th align='left'>AC</th> <th align='left'>TV</th> <th align='left'>Extendable</th>
  </tr>
  <tr>
    <td>". $fridge  ."</td>
    <td>". $ac  ."</td>
    <td>". $tv  ."</td>
    <td>". $extendable  ."</td>
  </tr>
</table><BR>";

if(isset($_GET['e']) && $_GET['e']=='booked'){
  echo "<h3 style='color:red'> Date already booked <h3>";
}elseif (isset($_GET['e']) && $_GET['e']=='invalid') {
  echo "<h3 style='color:red'> Invalid Date ranges <h3>";
}


if(isset($_GET['date_in']) && isset($_GET['date_out'])){
  $date_in = "value='".$_GET['date_in']."'";
  $date_out = "value='".$_GET['date_out']."'";
}else{
  $date_in = $date_out = "";
}

$c_first_name = "";
$c_last_name = "";
$c_sin="";
$c_phone="";
$payment_method="";

echo "
<form action='book.php' method='GET'>

<input name='room_id' value='".$row['roomnumber']."' type='hidden'>
<input name='price' value='".$row['price']."' type='hidden'>

<input name='fName' placeholder='Customer First Name' type='text' ".$c_first_name." >
<input name='lName' placeholder='Customer Last Name'  type='text' ".$c_last_name." >
<input name='sin' placeholder='Customer SIN Number' type='text'".$c_sin.">
<input name='phone' placeholder='Customer Phone Number' type='text'".$c_phone.">
</br></br>

<input name='payment' placeholder='Payment Method' type='text'".$payment_method.">
</br></br>

<input name='date_in' type='date' ".$date_in.">
<input name='date_out' type='date' ".$date_out.">


<input value='Book' name='Book' type='submit'>
</form>";

?>
