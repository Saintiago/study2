<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-05-12 16:02:52
         compiled from "D:\server2go\htdocs\lab3\template\upload.html" */ ?>
<?php /*%%SmartyHeaderCode:174195551fe457f2925-53271412%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a91a674dd77684108bb198d5b8e9a7801781a268' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab3\\template\\upload.html',
      1 => 1431439240,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '174195551fe457f2925-53271412',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5551fe45826b41_40194935',
  'variables' => 
  array (
    'message' => 0,
    'images' => 0,
    'image' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5551fe45826b41_40194935')) {function content_5551fe45826b41_40194935($_smarty_tpl) {?><h1 class="title">Загрузка файла на сервер</h1>﻿
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
