<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-05-12 14:54:15
         compiled from "D:\server2go\htdocs\lab3\template\example2.html" */ ?>
<?php /*%%SmartyHeaderCode:61235551f622a06778-72755193%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7d49156a6e2382db93c5f1eb602c645dbcaa14bf' => 
    array (
      0 => 'D:\\server2go\\htdocs\\lab3\\template\\example2.html',
      1 => 1431435252,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '61235551f622a06778-72755193',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5551f622a0bf69_64091230',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5551f622a0bf69_64091230')) {function content_5551f622a0bf69_64091230($_smarty_tpl) {?><span class="doctype">&lt;!DOCTYPE html&gt;</span>
<span class="tag">&lt;<span class="keyword">html</span>&gt;</span>
 <span class="tag">&lt;<span class="keyword">head</span>&gt;</span>
  <span class="tag">&lt;<span class="keyword">title</span>&gt;</span>canvas<span class="tag">&lt;/<span class="keyword">title</span>&gt;</span>
  <span class="tag">&lt;<span class="keyword">meta</span><span class="attribute"> charset=<span class="value">"utf-8"</span></span>&gt;</span>
  <span class="tag">&lt;<span class="keyword">script</span>&gt;</span><span class="javascript"> 
   window.onload = <span class="function"><span class="keyword">function</span><span class="params">()</span> &#123;</span>
    <span class="keyword">var</span> drawingCanvas = document.getElementById(<span class="string">'smile'</span>);
    <span class="keyword">if</span>(drawingCanvas &amp;&amp; drawingCanvas.getContext) &#123;
     <span class="keyword">var</span> context = drawingCanvas.getContext(<span class="string">'2d'</span>);
     <span class="comment">// Рисуем окружность </span>
     context.strokeStyle = <span class="string">"#000"</span>;
     context.fillStyle = <span class="string">"#fc0"</span>;
     context.beginPath();
     context.arc(<span class="number">100</span>,<span class="number">100</span>,<span class="number">50</span>,<span class="number">0</span>,Math.PI*<span class="number">2</span>,<span class="literal">true</span>);
     context.closePath();
     context.stroke();
     context.fill();
     <span class="comment">// Рисуем левый глаз </span>
     context.fillStyle = <span class="string">"#fff"</span>;
     context.beginPath();
     context.arc(<span class="number">84</span>,<span class="number">90</span>,<span class="number">8</span>,<span class="number">0</span>,Math.PI*<span class="number">2</span>,<span class="literal">true</span>);
     context.closePath();
     context.stroke();
     context.fill();
     <span class="comment">// Рисуем правый глаз </span>
     context.beginPath();
     context.arc(<span class="number">116</span>,<span class="number">90</span>,<span class="number">8</span>,<span class="number">0</span>,Math.PI*<span class="number">2</span>,<span class="literal">true</span>);
     context.closePath();
     context.stroke();
     context.fill();
     <span class="comment">// Рисуем рот</span>
     context.beginPath();
     context.moveTo(<span class="number">70</span>,<span class="number">115</span>);
     context.quadraticCurveTo(<span class="number">100</span>,<span class="number">130</span>,<span class="number">130</span>,<span class="number">115</span>);
     context.quadraticCurveTo(<span class="number">100</span>,<span class="number">150</span>,<span class="number">70</span>,<span class="number">115</span>); 
     context.closePath();
     context.stroke();
     context.fill();
    &#125;
   &#125;
  </span><span class="tag">&lt;/<span class="keyword">script</span>&gt;</span>
 <span class="tag">&lt;/<span class="keyword">head</span>&gt;</span>
 <span class="tag">&lt;<span class="keyword">body</span>&gt;</span>
  <span class="tag">&lt;canvas<span class="attribute"> id=<span class="value">"smile"</span></span><span class="attribute"> width=<span class="value">"200"</span></span><span class="attribute"> height=<span class="value">"200"</span></span>&gt;</span>
    <span class="tag">&lt;<span class="keyword">p</span>&gt;</span>Ваш браузер не поддерживает рисование.<span class="tag">&lt;/<span class="keyword">p</span>&gt;</span>
  <span class="tag">&lt;/canvas&gt;</span>
 <span class="tag">&lt;/<span class="keyword">body</span>&gt;</span>
<span class="tag">&lt;/<span class="keyword">html</span>&gt;</span><?php }} ?>
