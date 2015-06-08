<?php
    function findDvd($title)
    {
        $title = dbQuote($title);
        $query = "SELECT * FROM dvd WHERE title LIKE '%{$title}%'";
        return dbQuery($query);
    }