<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-04-13 21:30:28
         compiled from "C:\web\server2go\htdocs\practice\template\students.html" */ ?>
<?php /*%%SmartyHeaderCode:20413552c182d101018-69163784%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8fd50c2e524ea4ce8cfdf26ae64f3f4e0f03e12e' => 
    array (
      0 => 'C:\\web\\server2go\\htdocs\\practice\\template\\students.html',
      1 => 1428953427,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20413552c182d101018-69163784',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_552c182d1129d7_21394340',
  'variables' => 
  array (
    'students' => 0,
    'student' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_552c182d1129d7_21394340')) {function content_552c182d1129d7_21394340($_smarty_tpl) {?><h1>Students</h1>
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
