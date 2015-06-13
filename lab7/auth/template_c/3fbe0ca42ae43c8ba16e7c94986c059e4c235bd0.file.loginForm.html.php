<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-06-13 21:25:05
         compiled from "D:\server2go\htdocs\lab7\auth\template\loginForm.html" */ ?>
<?php /*%%SmartyHeaderCode:19070557c6d1ca36780-14483188%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3fbe0ca42ae43c8ba16e7c94986c059e4c235bd0' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab7\\auth\\template\\loginForm.html',
      1 => 1434223472,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19070557c6d1ca36780-14483188',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_557c6d1ca73e51_29180113',
  'variables' => 
  array (
    'error' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_557c6d1ca73e51_29180113')) {function content_557c6d1ca73e51_29180113($_smarty_tpl) {?>  <h1>Authorization</h1>
  <div id="errors"><?php echo $_smarty_tpl->tpl_vars['error']->value;?>
</div>
  <form id="authForm" action="" method="post">
    Login: <input type="text" value="" name="login" id="login" /><br/>
    Password: <input type="password" value="" name="password" id="password" /><br/>
    <input type="submit" value="submit" name="submit" />
  </form>
  
  <?php echo '<script'; ?>
 src="js/auth.js"><?php echo '</script'; ?>
><?php }} ?>
