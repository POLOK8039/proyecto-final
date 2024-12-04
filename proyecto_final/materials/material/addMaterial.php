<?php
    if(!validateUser("ADMIN","SUPER")){
        header("Location: /materials/");
        exit;
    }
    require "materialFun.php";
    session_start();
    $unit_of_measures = getUnitMeasure();

    if ($_SERVER['REQUEST_METHOD']=='POST') {

        $code = $_POST['code'];
        $name = $_POST['material_name'];
        $description = $_POST['description'];
        $available_quantity = $_POST['available_quantity'];
        $unit_of_measure = $_POST['unit_of_measure'];

        $result = addMaterial(
            code: $code, name: $name,
            description: $description, available_quantity: $available_quantity,
            unit_of_measure: $unit_of_measure
        );
        
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
        header("Location: /materials/material/");
        exit();
    }


    if(isset($_POST['btn_find'])){
        $seller_name = $_POST['find_seller'];
        $query = "SELECT * FROM seller WHERE name LIKE '%$seller_name%';";
    }
    
?>
<script src="materialForm.js"></script>
<main class="forms">
    
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Add Materials</h1>
            </header>
            <hr>
            <h2>Material</h2>
            <div class="rows">
                <div class="row-sm-3">
                    <h4 for="code">Code</h4>
                    <div class="inputs">
                        <input name="code" id="code" type="text" placeholder="pla"  required maxlength="5">
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="material_name">Name of material</h4>
                    <div class="inputs">
                        <input name="material_name" id="material_name" type="text" placeholder="Plastic" maxlength="50">
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="description">Description</h4>
                    <div class="inputs">
                        <input name="description" id="description" type="text" placeholder="Durable plastic" required maxlength="255">
                    </div>
                </div>
                <div class="row-md-5">
                    <h4 for="available_quantity">Quantity</h4>
                    <div class="inputs">
                        <input name="available_quantity" id="available_quantity" type="number" placeholder="17" required>
                    </div>
                </div>
                <div class="row-md-5">
                    <h4 for="unit_of_measure">Unit of measure</h4>
                    <div class="inputs">
                        <select class="input" required name="unit_of_measure" id="unit_of_measure options">
                            <?php 
                                while ($unit_of_measure = mysqli_fetch_assoc($unit_of_measures)):   
                                    echo "<option value='{$unit_of_measure['code']}'>{$unit_of_measure['description']}</option>";
                                endwhile; 
                            ?>
                        </select>
                    </div>
                </div>
            </div>
            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Confirm</button>
                <button class="btn-primary" onclick="window.history.back()">Cancelar</button>
            </footer>
        </form>
    </div>
</main>
<<<<<<< HEAD:materials/material/addMaterial.php
<script>
        setTimeout(() => {
            const successMsg = document.getElementById('success-msg');
            const errorMsg = document.getElementById('error-msg');
            if (successMsg) successMsg.style.display = 'none';
            if (errorMsg) errorMsg.style.display = 'none';
        }, 3000);
</script>
=======
<?php include FOOT ?>



