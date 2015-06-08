<?php
    require_once('include/config.inc.php');
    require_once('include/request.inc.php');
    require_once(SMARTY_DIR . 'Smarty.class.php');
    require_once("include/template.inc.php");
    require_once("include/database.inc.php");
    require_once("include/dvd.inc.php");
    
    session_start();
    
    dbConnect();