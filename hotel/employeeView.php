<?php

include 'settings.php';

$query = "SELECT * FROM room INNER JOIN hotel ON room.hotel_id = hotel.hotel_id;";
$query2 = "SELECT * FROM bookinghistory;";

$link = pg_connect("host=$host port=$port dbname=$database user=$username password=$password");
$result = pg_query( $link , $query);
$bhresult = pg_query( $link , $query2);

echo "

<head>
<style>
tr:nth-child(even) {background: #DDD}
tr:nth-child(odd) {background: #FFF}
</style>
</head>

<h1>Employee View </h1>
<h3>All rooms in Hotel</h3>

<input type='text' id='myInput' onkeyup='myFunction()' placeholder='Room Number ' title='Room Number'>


<table id='myTable'>
        <tr class='header'>
          <th align='left'>Hotel</th>
          <th align='left'>Price</th>
          <th align='left'>Rating</th>
          <th align='left'>Address</th>
          <th align='left'>City</th>
          <th align='left'>Book</th>
        </tr>
";

while ($row = pg_fetch_array($result, NULL, PGSQL_ASSOC)) {
  echo  "
  <tr>
    <td>".$row['hotelbrandname']."</td>
    <td>".$row['price']."</td>
    <td>".$row['starcategory']."</td>
    <td>".$row['addressofhotel']."</td>
     <td>".$row['city']."</td>
    <td><a href='room.php?room=".$row['roomnumber']."' id=".$row['roomnumber']." >Book</a></td>

  </tr>

  ";
}


while ( $bhrow = pg_fetch_array($bhresult, NULL, PGSQL_ASSOC) ){
    echo "
    <script>
        var elem= document.getElementById(".$bhrow['roomnumber'].");
        if ( elem !== null ) {
                elem.style.display = 'none';
                
        }
    </script>
    ";
}

echo "</table>

<script>
function myFunction() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById('myInput');
  filter = input.value.toUpperCase();
  table = document.getElementById('myTable');
  tr = table.getElementsByTagName('tr');
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName('td')[1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = '';
      } else {
        tr[i].style.display = 'none';
      }
    }
  }
}
</script>
";

?>
