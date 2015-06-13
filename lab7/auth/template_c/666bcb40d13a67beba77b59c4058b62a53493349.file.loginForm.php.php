<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-06-13 19:46:26
         compiled from "D:\server2go\htdocs\lab7\auth\template\loginForm.php" */ ?>
<?php /*%%SmartyHeaderCode:5120557c6c72013c00-14263343%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '666bcb40d13a67beba77b59c4058b62a53493349' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab7\\auth\\template\\loginForm.php',
      1 => 1434216520,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '5120557c6c72013c00-14263343',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_557c6c72015e03_14054398',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_557c6c72015e03_14054398')) {function content_557c6c72015e03_14054398($_smarty_tpl) {?>  <h1>Authorization</h1>
  <div id="errors"></div>
  <form id="authForm" action="checkAuth.php">
    Login: <input type="text" value="" name="login" id="login" /><br/>
    Password: <input type="password" value="" name="password" id="password" /><br/>
    <input type="submit" value="submit" name="submit" />
  </form>
  
  <?php echo '<script'; ?>
 src="js/auth.js"><?php echo '</script'; ?>
><?php }} ?>
