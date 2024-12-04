<?php

require_once __DIR__."/../../../products/prodFun.php";
require_once __DIR__."/../../../boxes/boxFun.php";
require_once __DIR__."/../../../protocols/tag/tagFun.php";
require_once __DIR__."/../tracFun.php";
//require_once __DIR__."/../../../protocols/tagType/tagTypeFun.php";

function addPackage($product, $quantity, $box, $tag_type, $date){
    $db = connectdb();

    $trac_code = $_SESSION['trac'];
    $user = $_SESSION['num'];

    $querypack = "call packing_process($quantity, '$product', $box, '$tag_type', '$date', $trac_code, $user)";

    error_log("Query: $querypack");
    try {
        return mysqli_query($db, $querypack);
    } catch (Exception $e) {
        error_log("Error adding a package: ".$e->getMessage());
        error_log($querypack);
        return false;
    }

}

function loadInfo(){
    $db = connectdb();

    $query = "SELECT * FROM package WHERE packaging = ".$_SESSION['trac'];
}
