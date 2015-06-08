<?php
    require_once('include/common.inc.php');
    header('Content-type: text/plain; charset=utf-8');

	$action = GetParam('action');

    if (strlen($action) > 0)
    {
    	$res = execAction($action);
    	if (!$res)
	    { echo 'Ошибка выполнения операции ' . $action; }	
	    else
	    { echo 'Операция ' . $action . ' выполнена'; }
    }