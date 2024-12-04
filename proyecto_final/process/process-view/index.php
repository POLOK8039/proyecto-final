<?php

$action = isset($_GET['a']) ? $_GET['a'] : null;

include $_SERVER['DOCUMENT_ROOT']."/config.php";
require_once 'tracFun.php';

session_start();
if(isset($_GET['t'])){
    unset($_SESSION['trac']);
    $_SESSION['trac'] = $_GET['t'];
    error_log("Prueba action: ".$_GET['t']." | ".$_SESSION['trac']);
    header("Location: /process/process-view/");
    exit();
}


include HEAD;

switch($action){

    case 'add': 
        unset($_SESSION['trac']);
        unset($_SESSION['destination']);
        $_SESSION['trac'] = startProcess()['Traceability'];
        header("Location: /process/process-view/");
        exit();

    case 'addPackage': $page = 'package/addPackage.php';
    break;

    case 'addPackaging': $page = 'packaging/addPackaging.php';
    break;

    case 'addWarehouse': $page = 'warehouse/addWarehouse.php';
    break;

    case 'select': $page = 'options.php';
    break;

    case 'incident': $page = 'incident/addIncident.php';
    break;
    
    default: 
        $page = empty($_SESSION['trac']) ? 'options.php' : 'home.php';
}

include $page;

include FOOT;