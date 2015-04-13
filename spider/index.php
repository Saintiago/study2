<?php
/*
 * Скрипт проходится cURL'ом по содержанию документации
 * и выводит статьи на экран
 */

  require_once("include/spider.inc.php");
  
  $working_path = "https://docs.python.org/3.3/reference/";
  $arErrors = array();
  
  $html = GetPageHtml($working_path . "index.html");
  if ($html !== false)
  {
    $arLinks = GetInitialLinks($html);
  
    foreach ($arLinks as $link)
    {
      $html = GetPageHtml($working_path . $link);
      if ($html !== false)
      {
        $text .= GetArticleText($html) . "<br/>";
      }
      else
      {
        $arErrors[] = "Error getting page: " . $working_path . $link;
      }
    }
  }
  else
  {
    $arErrors[] = "Error getting contents page (" . $working_path . "index.html )";
  }
  
  header("Content-Type: text/plain; charset=UTF-8");

  if (count($arErrors) > 0)
  {
    echo implode("\n", $arErrors);
    echo "\n\n";
  }
   
  echo strip_tags($text);