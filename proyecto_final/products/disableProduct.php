<?php
    require_once("../config.php");
    require_once("prodFun.php");

    if (isset($_GET['code'])) {
        $code = $_GET['code'];
        
        if (disableProduct($code)) {
            echo "Product deactivated correctly.";
        } else {
            echo "Error disabling the product.";
        }

        header("Location: index.php");
        exit();
    } else {
        echo "Product code not provided.";
    }
?>