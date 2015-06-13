<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-06-13 21:25:11
         compiled from "D:\server2go\htdocs\lab7\auth\template\hello.html" */ ?>
<?php /*%%SmartyHeaderCode:28716557c7e9dbf8395-09676412%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5a1e72c9be67db8474b901901fb79ad707a848e3' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab7\\auth\\template\\hello.html',
      1 => 1434223448,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '28716557c7e9dbf8395-09676412',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_557c7e9dc44242_46326107',
  'variables' => 
  array (
    'name' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_557c7e9dc44242_46326107')) {function content_557c7e9dc44242_46326107($_smarty_tpl) {?><h1>Hello, <?php echo $_smarty_tpl->tpl_vars['name']->value;?>
!</h1>

<form id="" action="" method="post">
    <input type="submit" value="Logout" name="logout" />
</form><?php }} ?>
