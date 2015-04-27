<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-04-13 22:51:07
         compiled from "D:\server2go\htdocs\practice\template\students.html" */ ?>
<?php /*%%SmartyHeaderCode:30639552c2c3bb3af62-00068532%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5306c2c849f6348fb6c4d636322f33276a4fac2b' => 
    array (
      0 => 'D:\\server2go\\htdocs\\practice\\template\\students.html',
      1 => 1428958019,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '30639552c2c3bb3af62-00068532',
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
  'unifunc' => 'content_552c2c3bb59258_71768548',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_552c2c3bb59258_71768548')) {function content_552c2c3bb59258_71768548($_smarty_tpl) {?><h1>Students</h1>
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
