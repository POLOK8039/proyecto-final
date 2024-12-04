<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../../config.php";
    
    include HEAD;
    
    crudRedirect($action,
    "listOuts.php", "addOut.php", "editOut.php"
);

    include FOOT;
?>