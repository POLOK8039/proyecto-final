<?php
    require "warehouseFun.php";
    $zones = getZones();
    //session_start();
    if ($_SERVER['REQUEST_METHOD']=='POST') {
        $zone = $_POST['zone'];

        if(addPackagingInZone($zone)){
            header("Location: /process/process-view/");
            exit();
        } else {
            error_log("Error al agregar la zona");
        }
    }
?>
<head>
    <script src="warehouse.js"></script>
</head>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php echo SVG . 'icon.svg'; ?>">
                <h1>Select Zone</h1>
            </header>
            <hr>
            <h2>Warehouse</h2>
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="code">Zone</h4>
                    <select name="zone" id="zone" class="inputs" required>
                        <?php foreach($zones AS $zone):?>
                            <option value="<?php echo $zone['code']?>" ><?php echo "[{$zone['code']}] {$zone['area']} | Available: {$zone['available_capacity']}" ?></option>
                        <?php endforeach?>
                    </select>
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