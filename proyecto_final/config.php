<?php
define("URL", "http://{$_SERVER['HTTP_HOST']}/");
define("ROOT", "{$_SERVER['DOCUMENT_ROOT']}/");
define("PDFDIR", ROOT . "uploads/");


define("STYLE", "/styles/");

define("HEADER", ROOT . "home/header.php");
define("HEAD", ROOT . "home/head.php");
define("ASIDE", ROOT . "home/aside.php");
define("HOME", ROOT . "home/home.php");
define("FOOT", ROOT . "home/foot.php");
define("FOOTER", ROOT . "home/footer.php");

define("SIDEBAR", ROOT . "src/sidebar.php");
define("CSS",  "/src/css/");
define("JS",  "/src/js/");
define("SVG", "/src/svg/");
define("IMG", "/src/img/");

include 'dbconfig.php';

require_once __DIR__."/login/logFun.php";

function getAction(){
    return isset($_GET['a']) ? $_GET['a'] : null;
}
function connectdb()
{
    try {
        $db = mysqli_connect(DBHOST, DBUSER, DBPASSW, DBNAME);
        //echo "<p>Conectado<p>";
        return $db;
    } catch (Exception $e) {
        error_log($e->getMessage());
        return false;
    }
}
function validateSession(){
    //Notice: session_start(): Ignoring session_start() because a session is already active
    //Por eso agregue este if
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    if(!isset($_SESSION['num'])){
        header("Location: /login/");
        exit();
    }
}
function nullDb($param)
{
    return $param == '' ? "NULL" : $param;
}

function crudRedirect($action, $listFile, $addFile, $editFile, $deleteFile = ""){
    switch($action){
        
        case 'add': include $addFile;
            break;
        
        case 'edit': include $editFile;
            break;
        
        case 'del': include $deleteFile;
            break;
        
        default: include $listFile;
        break;
    }

}