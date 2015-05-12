<?php
require_once ("include/common.inc.php");

$vars["message"] = processUploadedFile();
$vars["images"] = getUploadedImages();

echo BuildPage("upload.html", $vars);
