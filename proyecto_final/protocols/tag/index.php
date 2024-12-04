<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../config.php";
    include HEAD;
    
    crudRedirect($action,
    "listTags.php", "addTag.php", "editTag.php"
);

    include FOOT;
?>