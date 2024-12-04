<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../config.php";

    include HEAD;
    
    crudRedirect($action,
        "listReport.php", "addReport.php", "editReport.php"
    );

    include FOOT;
?>