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
    
    /*if (file_exists($template))
    {
      $content = file_get_contents($template);
      foreach ($vars as $var => $value) 
      {
        $placeholder = '{$' . $var . '}';
        $content = str_replace($placeholder, $value, $content);  
      }
    }
    return $content;*/
  }
  
  function BuildPage($template, $vars)
  {
    $header = GetView("header.html", $vars);
    $content = GetView($template, $vars);
    $footer = GetView("footer.html", $vars);
    return $header . $content . $footer;
  }
