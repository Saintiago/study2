<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-05-12 18:07:35
         compiled from "C:\web\server2go\htdocs\lab3\template\header.html" */ ?>
<?php /*%%SmartyHeaderCode:2736655522547896828-46084543%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4edceb4e426e0b5aa4bf7bf0da616e2951d58e7b' => 
    array (
      0 => 'C:\\web\\server2go\\htdocs\\lab3\\template\\header.html',
      1 => 1431446814,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2736655522547896828-46084543',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'leftMenu' => 0,
    'tag' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_555225479cda23_66250612',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_555225479cda23_66250612')) {function content_555225479cda23_66250612($_smarty_tpl) {?><!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>htmlbook.ru | Для тех, кто делает сайты</title>
    <link href="css/styles.css" rel="stylesheet" media="all">
  </head>
  <body>
    <div class="header">
      <a href="/lab3/" rel="home"><img src="images/logo.png" alt="htmlbook.ru" class="logo" width="184" height="66"></a>
      <ul id="topmenu">
        <li class="show">
          <a href="http://htmlbook.ru/#main"><i class="icon icon-main"></i> <br> Основное</a>
        </li>
        <li class="hide">
          <a href="http://htmlbook.ru/#html"><i class="icon icon-html"></i> <br> HTML</a>
        </li>
        <li class="hide">
          <a href="http://htmlbook.ru/#css"><i class="icon icon-css"></i> <br> CSS</a>
        </li>
        <li class="hide">
          <a href="http://htmlbook.ru/#site"><i class="icon icon-site"></i> <br> Сайт</a>
        </li>
      </ul>

      <div id="main" class="tile">
        <ul>
          <li>
            <a href="http://htmlbook.ru/content">Статьи</a>
          </li>
          <li>
            <a href="http://htmlbook.ru/blog">Блог</a>
          </li>
          <li>
            <a href="http://htmlbook.ru/practical">Практикум</a>
          </li>
          <li>
            <a href="http://htmlbook.ru/test">Тесты</a>
          </li>
          <li>
            <a href="http://htmlforum.ru/" rel="nofollow">Форум</a>
          </li>
        </ul>
      </div>

      <form action="http://htmlbook.ru/search/" id="cse-search-box">
        <input type="text" name="as_q" id="q" autocomplete="off" placeholder="Поиск по сайту">
        <input type="image" src="images/find.png" alt="Найти" class="find">
      </form>
    </div>

    <div class="layout">

      <div class="aside">
        <div class="block" id="block-28">
          <div class="block_content">
            <form action="http://htmlbook.ru/sites/search/" id="filter" name="filter">
              <input autocomplete="off" id="ac" name="q" placeholder="Тег HTML или св-во CSS" type="search">
              <input alt="Найти" class="find" src="images/find.png" type="image">
            </form>
          </div>
        </div>

        <div class="block" id="menu-menu-html">
          <h2 class="block_title">Теги HTML</h2>
          <div class="aside_list">
            <ul class="menu">
              <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['leftMenu']->value['tags']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
              <li class="leaf">
                <a href="<?php echo $_smarty_tpl->tpl_vars['tag']->value['link'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</a>
              </li>
              <?php } ?>
            </ul>
          </div>
        </div>

        <div class="block" id="menu-menu-css">
          <h2 class="block_title">Справочник CSS</h2>

          <div class="aside_list">
            <ul class="menu">
              <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['leftMenu']->value['css']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
              <li class="leaf">
                <a href="<?php echo $_smarty_tpl->tpl_vars['tag']->value['link'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</a>
              </li>
              <?php } ?>
            </ul>
          </div>
        </div>
      </div>

      <div id="content">
<?php }} ?>
