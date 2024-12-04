<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../config.php";
    include HEAD;

    crudRedirect($action,
        "listBoxes.php", "addBox.php", "editBox.php", "disableBox.php"
    );

    include FOOT;
?>