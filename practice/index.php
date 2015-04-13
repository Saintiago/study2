<?php
  require_once("include/common.inc.php");
  
  $students = array
  (
    array("name" => "Alex", "age" => "20"),
    array("name" => "Tanya", "age" => "21")
  );
  
  $vars = array("students" => $students);
  echo BuildPage("students.html", $vars);