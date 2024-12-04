<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../config.php";

    include HEAD;
    
    crudRedirect($action,
        "listProducts.php", "addProduct.php", "editProduct.php", "disableProduct.php"
    );

    include FOOT;
?>