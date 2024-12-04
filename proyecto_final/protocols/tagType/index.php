<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../config.php";
    include HEAD;
    
    crudRedirect($action,
    "listTagType.php", "addTagType.php", "editTagType.php"
);

    include FOOT;
?>