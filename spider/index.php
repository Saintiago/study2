<?php
/*
 * Скрипт проходится cURL'ом по содержанию документации
 * и выводит статьи на экран
 */

  require_once("include/spider.inc.php");
  
  $working_path = "https://docs.python.org/3.3/reference/";
  
  $html = GetPageHtml($working_path . "index.html");
  $arLinks = GetInitialLinks($html);
  
  foreach ($arLinks as $link)
  {
    $html = GetPageHtml($working_path . $link);
    $text .= GetArticleText($html) . "<br/>";
  }
  
  header("Content-Type: text/plain; charset=UTF-8"); 
  echo strip_tags($text);