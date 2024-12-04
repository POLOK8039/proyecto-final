<?php
    require "zoneFun.php";
    session_start();
    if ($_SERVER['REQUEST_METHOD']=='POST') {
        $code = $_POST['code'];
        $area = $_POST['area'];
        $available_capacity = $_POST['available_capacity'];
        $total_capacity = $_POST['total_capacity'];

        $result = addZone(code: $code, area: $area, available_capacity: $available_capacity, total_capacity: $total_capacity);
        if($result){
            $_SESSION['message'] = [
                'text' => 'Successful registration',
                'type' => 'success'
            ];
        } else {
                $_SESSION['message'] = [
                'text' => 'Error',
                'type' => 'error'
            ];
        }
        header("Location: /process/warehouse/zone");
        exit();
    }
?>
    <main class="forms">
        <div class="background">
            <form class="form" action="?a=add" method="post" autocomplete="off">
                <header class="header">
                    <img src="<?php  echo SVG . "icon.svg" ?>">
                    <h1>Add Zone</h1>
                </header>
                <hr>
                <h2>Zone</h2>
                <div class="rows">
                    <div class="row-md-5">
                        <h4 for="code">Code</h4>
                        <div class="inputs">
                            <input name="code" id="code" type="text"  maxlength="5">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="area">Area</h4>
                        <div class="inputs">
                            <input name="area" id="area" type="text" required maxlength="50">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="description">Available capacity (packaging)</h4>
                        <div class="inputs">
                            <input name="available_capacity" id="description" type="number" placeholder="999" required maxlength="10">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="available_quantity">Total capacity (packaging)</h4>
                        <div class="inputs">
                            <input name="total_capacity" id="available_quantity" type="number" placeholder="999" required maxlength="10">
                        </div>
                    </div>
                </div>
                <hr>
                <footer class="footer">
                    <button class="btn-primary" type="submit">Confirm</button>
                </footer>
            </form>
        </div>
    </main>
    <?php include FOOT ?>