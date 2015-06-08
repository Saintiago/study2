<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-05-12 18:10:57
         compiled from "C:\web\server2go\htdocs\lab3\template\upload.html" */ ?>
<?php /*%%SmartyHeaderCode:233255522611624601-48500784%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7a1dd6936e0c9fbb7706c9f8c3487756bcfda80d' => 
    array (
      0 => 'C:\\web\\server2go\\htdocs\\lab3\\template\\upload.html',
      1 => 1431446814,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '233255522611624601-48500784',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'message' => 0,
    'images' => 0,
    'image' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5552261169ef64_65464125',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5552261169ef64_65464125')) {function content_5552261169ef64_65464125($_smarty_tpl) {?><h1 class="title">Загрузка файла на сервер</h1>﻿
<div class="messages">
  <?php echo $_smarty_tpl->tpl_vars['message']->value;?>

</div>
<div class="images">
  <?php  $_smarty_tpl->tpl_vars['image'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['image']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['images']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['image']->key => $_smarty_tpl->tpl_vars['image']->value) {
$_smarty_tpl->tpl_vars['image']->_loop = true;
?>
  <img src="<?php echo $_smarty_tpl->tpl_vars['image']->value;?>
" alt="" />
  <?php } ?>
</div>
<div class="block" id="system-main">
  <div class="block_content">
    <form action="/lab3/upload.php" method="post" enctype="multipart/form-data">
      <input type="file" name="uploadfile"><br />
      <input type="submit" name="uploaded" value="Загрузить">
    </form>
  </div>
</div><?php }} ?>
