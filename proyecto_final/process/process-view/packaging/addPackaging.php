<?php
    require "packagingFun.php";

    $process = getProcessByID($_SESSION['trac']);
    $quantity = $process['Package_Quantity'];
    $destination = $_SESSION['Destination'];
    $packaging = $process['Packaging'];
    error_log($quantity);

    $materialsUsed = getMaterialsInPackaging();

    if($_SERVER['REQUEST_METHOD']=='POST' || !empty($destination)){

        $quantity = empty($_POST['quantity']) ? $quantity : $_POST['quantity'];
        $destination = empty($_POST['destination']) ? $destination : $_POST['destination'];

        startPackaging($destination);

        $materials = getAvailableMaterial($packaging);

        $validate = true;
    
    
        if($_POST['validate'] == "true"){
            
            $material = $_POST['material'];
            $matQuant = $_POST['mat_quantity'];
            addPackagesQuan($quantity);
            $bool = addMaterialToPackaging($material, $packaging, $matQuant);
            
            
        }
    }

?>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Add Packaging</h1>
            </header>
            <hr>
            <h2>Packages</h2>
            <input type="hidden" name="a" value="addPackaging">
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="product">Destination</h4>
                    <div class="inputs">
                        <input value="<?php echo $destination?>" type="text" name="destination" id="destination" max="25" required>
                    </div>
                </div>
                
                <?php //if(!$validate):?>
                <div class="row-md-5">
                    <div>
                        <button class="btn-primary" type="submit" >Confirm</button>
                    </div>
                </div>
                <?php //endif;?>
            </div>
        </form>

        <?php if($validate): ?>
        <form class="form" action="" method="post" autocomplete="off"> 
            <input type="" name="validate" id="validate" value="true" hidden>
            <hr>
            <h2>Destination</h2>
            <input type="hidden" name="a" value="addPackaging">
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="product">Packages quantity</h4>
                    <div class="inputs">
                        <input value="<?php echo getProcessByID($_SESSION['trac'])['Package_Quantity']?>" type="number" name="quantity" id="quantity" min="2" required <?php echo $readonly?>>
                    </div>
                </div>
            </div>
            <hr>
            <h2>Material Used</h2>
            <div class="rows">       
                <div class="row-md-5">
                    <h4 for="material">Material</h4>
                    <select name="material" id="material" class="inputs">
                    <?php foreach ($materials AS $material):  ?>
                        <option value="<?php echo $material['Code']?>">
                            <?php echo $material['Name']." (".$material['Unit'].")"?>
                        </option>
                    <?php endforeach; ?>
                    </select>
                </div>
                <div class="row-md-5">
                    <h4 for="mat_quantity">Quantity</h4>
                    <div class="inputs">
                        <input type="number" class="input" name="mat_quantity" id="mat_quantity" value="<?php echo $matQuantity?>" min="1" required> 
                    </div>
                </div>
                <?php foreach($materialsUsed AS $material): ?>
                <div class="row-md-5">
                    <div class="inputs">
                        <input class="input" value="<?php echo "[".$material['Code']."] ".$material['Material']?>" readonly>
                    </div>
                </div>
                <div class="row-md-5">
                    <div class="inputs">
                        <input class="input" value="<?php echo $material['Quantity']." ".$material['Unit'] ?>" readonly>
                    </div>
                </div>
                <?php endforeach;?>

            </div>
            <footer class="footer">
                <a class="danger btn-primary danger" style="text-align: center" href="/process/process-view/" >Go back</a>
                <button class="btn-primary"  type="submit">Confirm</button>
            </footer>
            
        </form>
        <?php endif; ?>
    </div>
</main>
<script>
        setTimeout(() => {
            const successMsg = document.getElementById('success-msg');
            const errorMsg = document.getElementById('error-msg');
            if (successMsg) successMsg.style.display = 'none';
            if (errorMsg) errorMsg.style.display = 'none';
        }, 3000);
    </script>