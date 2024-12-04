<?php
    require_once("../config.php");
    require "boxFun.php";
    session_start(); 
    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        $box = getBoxByNumber($num);

        if (!$box || !isset($box['num'])) {
            echo "Box not found";
            exit;
        }      
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $num = $_POST['num'];
        $height = $_POST['height'];
        $width = $_POST['width'];
        $length = $_POST['length'];
        $weight = $_POST['weight'];

        if (updateBox(num:$num, height:$height, width:$width, length:$length, weight:$weight)) {
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
    <script src="boxForm.js"></script>
</head>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="POST" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Edit Boxes</h1>
            </header>
            
            <?php if(validateUser("ADMIN")):?>
                <a class="btn-primary" href="?a=del&num=<?php echo $box['num']; ?>" onclick="return confirm('¿Are you sure you want to disable this box?');">Disable</a>
            <?php endif; ?>
            <hr>
            <h2>Dates</h2>
            <div class="rows">
                <div class="row-sm-3">
                    <h4>Box Number</h4>
                    <div class="inputs">
                    <input type="number" name="num" value="<?php echo $box['num']; ?>" readonly>
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4>Height (cm)</h4>
                    <div class="inputs">
                    <input type="number" name="height" id="height" value="<?php echo $box['height']; ?>" required>

                    </div>
                </div>
                <div class="row-sm-3">
                    <h4>Width (cm)</h4>
                    <div class="inputs">
                    <input type="number" name="width" id="width"value="<?php echo $box['width']; ?>" required>

                    </div>
                </div>
                <div class="row-md-5">
                    <h4>Length (cm)</h4>
                    <div class="inputs">
                    <input type="number" name="length" id="length" value="<?php echo $box['length']; ?>" required>

                    </div>
                </div>
                <div class="row-md-5">
                    <h4>Weight (g)</h4>
                    <div class="inputs">
                    <input type="number" name="weight" id="weight"  value="<?php echo $box['weight']; ?>" required>

                    </div>
                </div>
            </div>
            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Update</button>
            </footer>
        </form>
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