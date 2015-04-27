<?php
    require_once("include/common.inc.php");
    
    $page = GetParam("page");
    
    $template = "canvas.html";
    
    if ($page != "")
    {
        $template = $page . ".html";
    }
    
    if (!file_exists(TEMPLATE_DIR . $template))
    {
        $template = "404.html";
    } 
    
    echo BuildPage($template, $vars);