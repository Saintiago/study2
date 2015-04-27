<?php /* Smarty version Smarty-3.1.21-dev, created on 2015-04-27 19:54:26
         compiled from "C:\web\server2go\htdocs\lab3\template\canvas.html" */ ?>
<?php /*%%SmartyHeaderCode:9121553e71b4f24b42-99193622%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8b6f5a6362ad18c5a3cea0f8f2a6ec3c1d654569' => 
    array (
      0 => 'C:\\web\\server2go\\htdocs\\lab3\\template\\canvas.html',
      1 => 1430156888,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9121553e71b4f24b42-99193622',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_553e71b5027f98_57414201',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_553e71b5027f98_57414201')) {function content_553e71b5027f98_57414201($_smarty_tpl) {?><h1 class="title">Тег &lt;canvas&gt;</h1>﻿
<div id="like">
  <div class="num_comments">
    <a href="#disqus_thread">комментариев: 36</a>
  </div>
</div>

<div class="block" id="system-main">
  <div class="block_content">
    <article>
      <div class=
      "field field-name-body field-type-text-with-summary field-label-hidden">
        <div class="field-items">
          <div class="field-item even">
            <table class="data browser">
              <tr class="br">
                <td><span class="ie">Internet Explorer</span></td>
                <td><span class="cr">Chrome</span></td>
                <td><span class="op">Opera</span></td>
                <td><span class="sa">Safari</span></td>
                <td><span class="fx">Firefox</span></td>
                <td><span class="an">Android</span></td>
                <td><span class="ip">iOS</span></td>
              </tr>
              <tr class="sp">
                <td class="yes"><span>9.0+</span></td>
                <td class="yes"><span>6.0+</span></td>
                <td class="yes"><span>9.6+</span></td>
                <td class="yes"><span>3.1+</span></td>
                <td class="yes"><span>4.0+</span></td>
                <td class="yes"><span>2.1+</span></td>
                <td class="yes"><span>3.0+</span></td>
              </tr>
            </table>
            <h3>Спецификация</h3>
            <table class="standart">
              <tr>
                <td class="h">HTML:</td>
                <td class="no">3.2</td>
                <td class="no">4.01</td>
                <td class="yes">5.0</td>
                <td class="xh">XHTML:</td>
                <td class="no">1.0</td>
                <td class="no">1.1</td>
              </tr>
            </table>
            <h3>Описание</h3>
            <p>
              Создает область, в которой при помощи JavaScript можно рисовать
              разные объекты, выводить изображения, трансформировать их и менять
              свойства. При помощи тега <span class="tag">&lt;canvas&gt;</span>
              можно создавать рисунки, анимацию, игры и др.
            </p>
            <h3>Синтаксис</h3>
            <pre>
                <code class="no-buttons xml">
                    <span class="tag">&lt;<span class="title">canvas</span><span class="attribute"> id=<span class="value">"идентификатор"</span></span>&gt;</span><span class="tag">
                    &lt;/<span class="title">canvas</span>&gt;</span>
                </code>
            </pre>
            <h3>Атрибуты</h3>
            <dl class="param">
              <dt>
                height
              </dt>
              <dd>
                Задает высоту холста. По умолчанию 300 пикселов.
              </dd>
              <dt>
                width
              </dt>
              <dd>
                Задает ширину холста. По умолчанию 150 пикселов.
              </dd>
            </dl>
            <p class="more">
              Также для этого тега доступны <a href=
              "http://htmlbook.ru/html/attr/common">универсальные атрибуты</a> и <a href="http://htmlbook.ru/html/attr/event">события</a>.
            </p>
            <h3>Закрывающий тег</h3>
            <p>
              Обязателен.
            </p>
            <p class="exampleTitle">
              Пример
            </p>
            <p class="example-support">
              <span class=
              "html yes">HTML5</span><span class="no">IE 8</span><span class=
              "yes">IE 9</span><span class="yes">Cr</span><span class=
              "yes">Op</span><span class="yes">Sa</span><span class=
              "yes">Fx</span>
            </p>
            <pre>
<code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
 &lt;head&gt;
  &lt;title&gt;canvas&lt;/title&gt;
  &lt;meta charset=&quot;utf-8&quot;&gt;
  &lt;script&gt; 
   window.onload = function() {
    var drawingCanvas = document.getElementById('smile');
    if(drawingCanvas &amp;&amp; drawingCanvas.getContext) {
     var context = drawingCanvas.getContext('2d');
     // Рисуем окружность 
     context.strokeStyle = &quot;#000&quot;;
     context.fillStyle = &quot;#fc0&quot;;
     context.beginPath();
     context.arc(100,100,50,0,Math.PI*2,true);
     context.closePath();
     context.stroke();
     context.fill();
     // Рисуем левый глаз 
     context.fillStyle = &quot;#fff&quot;;
     context.beginPath();
     context.arc(84,90,8,0,Math.PI*2,true);
     context.closePath();
     context.stroke();
     context.fill();
     // Рисуем правый глаз 
     context.beginPath();
     context.arc(116,90,8,0,Math.PI*2,true);
     context.closePath();
     context.stroke();
     context.fill();
     // Рисуем рот
     context.beginPath();
     context.moveTo(70,115);
     context.quadraticCurveTo(100,130,130,115);
     context.quadraticCurveTo(100,150,70,115); 
     context.closePath();
     context.stroke();
     context.fill();
    }
   }
  &lt;/script&gt;
 &lt;/head&gt;
 &lt;body&gt;
  &lt;canvas id=&quot;smile&quot; width=&quot;200&quot; height=&quot;200&quot;&gt;
    &lt;p&gt;Ваш браузер не поддерживает рисование.&lt;/p&gt;
  &lt;/canvas&gt;
 &lt;/body&gt;
&lt;/html&gt;</code>
</pre>
            <p>
              Результат примера в браузере Opera показан на рис.&nbsp;1.
            </p>
            <p class="fig"><img alt=
              "Вывод рисунка с помощью тега &lt;canvas&gt;" height="299" src=
              "http://htmlbook.ru/files/images/html/tag_canvas.png" width=
              "400">
            </p>
            <p class="figsign">
              Рис. 1. Вывод рисунка с помощью тега
              &lt;canvas&gt;
            </p>
          </div>
        </div>
      </div>
      <div class=
      "field field-name-taxonomy-vocabulary-10 field-type-taxonomy-term-reference field-label-hidden">
        <div class="field-items">
          <div class="field-item even">
            <a href="/html/type/html5">HTML5</a>
          </div>
          <div class="field-item odd">
            <a href="/html/type/img">Изображения</a>
          </div>
        </div>
      </div>
    </article>
  </div>
</div><?php }} ?>
