<?php
  
    function GetView($template, $vars)
    {
        $template = TEMPLATE_DIR . $template;
        $content = '';
    
        $smarty = new Smarty();
        $smarty->setTemplateDir(TEMPLATE_DIR);
        $smarty->setCompileDir(TEMPLATE_C_DIR);
        $smarty->assign($vars);
    
        return $smarty->fetch($template);
    }
  
    function BuildPage($template, $vars)
    {
        $vars["leftMenu"] = GetMenu();
        $header = GetView("header.html", $vars);
        $content = GetView($template, $vars);
        $footer = GetView("footer.html", $vars);
        return $header . $content . $footer;
    }
  
    function GetMenu()
    {
        $arTags = array
        (
            array("name" => "Все теги", "link" => "#"),
            array("name" => "Валидация тегов", "link" => "#"),
            array("name" => htmlentities("<!-- -->"), "link" => "#"),
            array("name" => htmlentities("<!DOCTYPE>"), "link" => "#"),
            array("name" => htmlentities("<a>"), "link" => "#"),
            array("name" => htmlentities("<canvas>"), "link" => "?page=canvas"),
            array("name" => htmlentities("<video>"), "link" => "#"),
            array("name" => htmlentities("<wbr>"), "link" => "#"),
            array("name" => htmlentities("<xmp>"), "link" => "#"),
        );
      
        $arCss = array
        (
             array("name" => "Как пользоваться справочником", "link" => "#"),
             array("name" => "!important", "link" => "#"),
             array("name" => "-moz-border-bottom-colors", "link" => "#"),
             array("name" => "-moz-border-left-colors", "link" => "#"),
             array("name" => "-moz-border-right-colors", "link" => "#"),
             array("name" => "-moz-border-top-colors", "link" => "#"),
             array("name" => "-moz-linear-gradient", "link" => "#"),
             array("name" => "-moz-orient", "link" => "#"),
             array("name" => "-moz-radial-gradient", "link" => "#"),
             array("name" => "-moz-user-select", "link" => "#"),
             array("name" => "-ms-interpolation-mode", "link" => "#")
        );
        
        return array("Tags" => $arTags, "CSS" => $arCss);  
    }
