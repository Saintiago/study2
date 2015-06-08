<?php
    require_once('include/common.inc.php');
    header('Content-type: text/html; charset=utf-8');
    $surveys = GetSurveyList();
?>
<table>
    <tr>
        <td>
            <h1>Store survey</h1>    
            <form action="survey.php" name="survey" method="get">
                <input type="hidden" name="action" value="store" />
                Name: <input type="text" name="first_name" value="" /><br />
                Last name: <input type="text" name="last_name" value="" /><br />
                Email: <input type="text" name="email" value="" /><br />
                Age: <input type="text" name="age" value="" /><br />
                <input type="submit" value="Save" />
            </form>    
        </td>
        <td>
            <h1>Surveys</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>First name</th>
                    <th>Last name</th>
                    <th>Email</th>
                    <th>Age</th>    
                </tr>
                <?
                    foreach ($surveys as $key => $survey) 
                    {
                    ?>
                        <tr>
                            <td>
                                <a href="survey.php?action=show&id=<?= $survey['id'] ?>" title="Подробно">
                                    <?= $survey['id'] ?>
                                </a>
                            </td>
                            <td><?= $survey['first_name'] ?></td>
                            <td><?= $survey['last_name'] ?></td>
                            <td><?= $survey['email'] ?></td>
                            <td><?= $survey['age'] ?></td>
                        </tr>        
                    <?
                    }
                    ?>
            </table>    
        </td>
    </tr>
</table>
