<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../config.php";
    
    include HEAD;
    
    crudRedirect($action,
    "listWarehouse.php", "addWarehouse.php", "editWarehouse.php"
);

    include FOOT;
?>