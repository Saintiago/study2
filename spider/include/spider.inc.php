<?php
  require_once('include/phpQuery-onefile.php');
    
  function GetInitialLinks($html)
  {
    $doc = phpQuery::newDocument($html); 
    $contents = pq('.toctree-wrapper')->find('a');
    $arLinks = array();
    foreach($contents as $a) {
            $href = pq($a)->attr('href');
            if (strpos($href, '#') !== false)
            {
              $arHref = explode('#', $href);
              $href = $arHref[0];
            }
            $arLinks[] = $href;
    }
    return array_unique($arLinks);
  }
  
  function GetArticleText($html)
  {
    $doc = phpQuery::newDocument($html); 
    return pq("div.section")->html();
  }
  
  function GetPageHtml($url)
  {
    $ch = curl_init();
    $timeout = 5;
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
    $html = curl_exec($ch);
    $info = curl_getinfo($ch);
    if(curl_errno($ch) || ($info["http_code"] != 200))
    {
      $html = false;
    }
    curl_close($ch);
    return $html;
  }