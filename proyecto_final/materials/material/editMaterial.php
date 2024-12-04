<?php
    require "materialFun.php";
    session_start();
    $unit_of_measures = getUnitMeasure();
    
    if (isset($_GET['code'])) {
        $code = $_GET['code'];
        $material = getMaterialByCode($code);

        if (!$material) {
            echo "Material not found";
            exit;
        }         
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $code = $_POST['code'];
        $name = $_POST['material_name'];
        $description = $_POST['description'];
        $available_quantity = $_POST['available_quantity'];
        $active = 1; 
        $unit_of_measure = $_POST['unit_of_measure'];

        if (updateMaterial(code: $code, name: $name, description: $description, available_quantity: $available_quantity, active: $active, unit_of_measure: $unit_of_measure)) {
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
        header("Location: index.php");
        exit();
    }
?>
<head>     
    <script src="materialForm.js"></script>  
</head>

    <main class="forms">
        <div class="background">
            <form class="form" action="" method="post" autocomplete="off">
                <header class="header">
                    <img src="<?php  echo SVG . "icon.svg" ?>">
                    <h1>Edit Materials</h1>
                </header>
                <?php if(validateUser("ADMIN")):?>
                <a  class="btn-primary" href="?a=del&code=<?php echo $material['code']; ?>" onclick="return confirm('Are you sure you want to disable this material?');">Disable</a>
                <?php endif; ?>
                <hr>
                <h2>Material</h2>
                <div class="rows">
                    <div class="row-sm-3">
                        <h4 for="code">Code</h4>
                        <div class="inputs">
                            <input name="code" id="code" type="text" placeholder="pla" value="<?php echo $material['code']; ?>" required maxlength="5"  readonly>
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="material_name">Name of material</h4>
                        <div class="inputs">
                            <input name="material_name" id="material_name" type="text" placeholder="Plastic" value="<?php echo $material['name']; ?>" required maxlength="50">
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="description">Description</h4>
                        <div class="inputs">
                            <input name="description" id="description" type="text" placeholder="Durable plastic" value="<?php echo $material['description']; ?>" required maxlength="255">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="available_quantity">Available Quantity</h4>
                        <div class="inputs">
                            <input name="available_quantity" id="available_quantity" type="number" placeholder="999" value="<?php echo $material['available_quantity']; ?>" required>
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="unit_of_measure">Unit of measure</h4>
                        <div class="inputs">
                            <select class="input" required name="unit_of_measure" id="unit_of_measure options">
                                <?php 
                                    while ($unit = mysqli_fetch_assoc($unit_of_measures)): 
                                        $selected = $material['unit_of_measure'] === $unit['code'] ? 'selected' : '';
                                        echo "<option value='{$unit['code']}' $selected>{$unit['description']}</option>";
                                    endwhile; 
                                ?>
                            </select>
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