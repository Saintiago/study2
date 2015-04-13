<?php
    function GetParam($paramName)
    {
        return (isset($_GET[$paramName]))
            ? $_GET[$paramName]
            : '';
    }

    function GetAllParams()
    {
        foreach ($_GET as $name => $value)
        {
            $arParams[$name] = GetParam($name);
        }
        return $arParams;
    }