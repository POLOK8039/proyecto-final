<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../config.php";
    include HEAD;

    error_log("ACTION: $action");
    crudRedirect($action, 
        "listProtocols.php", "addProtocol.php", 
        "editProtocol.php","disableProtocol.php"
    );
    include FOOT;
?>