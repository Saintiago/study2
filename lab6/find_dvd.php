<?php
    require_once('include/common.inc.php');
    require_once('include/dvd.inc.php');
    dbConnect();
    $dvdList = findDvd(getParam('title'));
    dbClose();
    echo "<pre>";
    foreach($dvdList as $dvd)
    {
        var_export($dvd);
    }
    echo "</pre>";