<?php
/*
 * Использовать глобальную переменную $g_dbLink
 * только внутри модуля database.inc.php
 *
 * Функции mysqli используем только внутри
 * модуля database.inc.php
 */
$g_dbLink = NULL;

function dbConnect()
{
    global $g_dbLink;
    $g_dbLink = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if (mysqli_connect_errno())
    {
        echo "Unable to connect to DB";
        exit();
    }
}

/**
 * Выполняет SQL запрос SELECT переданный в переменной query.
 * Возвращает ассоциативный массив, если данные есть
 * или пустой массив, если данных нет
 *
 * @param string $query
 * @return array
 */
function dbSelect($query)
{
    global $g_dbLink;
    $data = array();
    $result = mysqli_query($g_dbLink, $query);
    if (!is_bool($result))
    {
        while ($row = mysqli_fetch_assoc($result))
        {
            array_push($data, $row);
        }
        mysqli_free_result($result);
    }
    return $data;
}

/**
 * Выполняет SQL запрос INSERT переданный в переменной query.
 * Возвращает true если операция выполнена успешно
 * и false в обратном случае
 *
 * @param string $query
 * @return array
 */
function dbInsert($query)
{
    global $g_dbLink;
    $result = array();
    $result = mysqli_query($g_dbLink, $query);
    return $result;
}

/**
 * Экранирует строку
 * 
 * @param string $str
 * @return string
 */
function dbQuote($str) 
{
    global $g_dbLink;
    return mysqli_real_escape_string($g_dbLink, $str);
}

function dbClose()
{
	global $g_dbLink;
    mysqli_close($g_dbLink);
}