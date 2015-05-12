<?php

    $allowedTypes = array(
        "image/jpeg",
        "image/png",
        "image/gif"
    );
    $mess = array(
        "SUCCESS_MSG" => "Файл сохранен",
        "WRONG_TYPE" => "Неправильный тип файла",
        "ERROR_MSG" => "Ошибка сохранения файла"
    );

    function getUploadedImages()
    {
        global $allowedTypes;
        $files = scandir(UPLOADS_DIR);
        foreach ($files as $key => &$file)
        {
            if (!in_array(mime_content_type(UPLOADS_DIR . $file), $allowedTypes))
            {
                unset($files[$key]);
            }
            else
            {
                $file = "/lab3/" . UPLOADS . $file;
            }
        }
        return $files;
    }

    function processUploadedFile()
    {
        global $mess;
        $message = "";
        $uploaded = GetParam("uploaded");
        if (!empty($uploaded) && count($_FILES) > 0)
        {
            $res = SaveFile();
            if ($res == 0)
                $message = $mess["SUCCESS_MSG"];
            elseif ($res == 1)
                $message = $mess["WRONG_TYPE"];
            elseif ($res == 2)
                $message = $mess["ERROR_MSG"];
        }
        return $message;
    }

    function SaveFile()
    {
        global $allowedTypes;
        $res = 1;
        if ($_FILES['uploadfile']['error'] > 0)
        {
            $res = 2;
        }
        elseif (in_array($_FILES['uploadfile']['type'], $allowedTypes))
        {
            $uploadfile = UPLOADS_DIR . basename($_FILES['uploadfile']['name']);
            if (copy($_FILES['uploadfile']['tmp_name'], $uploadfile))
                $res = 0;
            else
                $res = 2;
        }
        return $res;
    }
