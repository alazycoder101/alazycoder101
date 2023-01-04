<?php

function decode($str) {
  print "-------\n";
  print $str . "\n";
  print urldecode($str) . "\n";
}

decode('a+b');
decode('a b');
decode('a%20b');
$str = "a%20b";
print $str . "\n";
?>
