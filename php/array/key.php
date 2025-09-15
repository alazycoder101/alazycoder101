<?php
$array =  [ 'string'=> 'a string', 'a' => 'b', 1 => 2 ];
foreach ($array as $key => $value) {
    echo $key . ' => ' . $value . "\n";
}
$array =  [ 1, 'a' ];
foreach ($array as $key => $value) {
    echo $key . ' => ' . $value . "\n";
}
?>
