<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-04-26 17:34:06
         compiled from "D:\server2go\htdocs\lab3\template\students.html" */ ?>
<?php /*%%SmartyHeaderCode:3123553d056eac25f1-78535857%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a8ed161842d68a472bb1fb5a7bd453bdaf314d61' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab3\\template\\students.html',
      1 => 1428958019,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '3123553d056eac25f1-78535857',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'students' => 0,
    'student' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_553d056eb05f60_27821901',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_553d056eb05f60_27821901')) {function content_553d056eb05f60_27821901($_smarty_tpl) {?><h1>Students</h1>
<ul>
  <?php  $_smarty_tpl->tpl_vars['student'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['student']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['students']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['student']->key => $_smarty_tpl->tpl_vars['student']->value) {
$_smarty_tpl->tpl_vars['student']->_loop = true;
?>
  <li><?php echo $_smarty_tpl->tpl_vars['student']->value['name'];?>
, <?php echo $_smarty_tpl->tpl_vars['student']->value['age'];?>
</li>
  <?php } ?>
</ul><?php }} ?>
