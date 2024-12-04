<?php
    require "prodFun.php";
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $protocols = getProtocols();

    if($_SERVER['REQUEST_METHOD']=='POST'){
        $code = $_POST['code'];
        $name = $_POST['name'];
        $description = $_POST['description'];
        $height = $_POST['height'];
        $width = $_POST['width'];
        $length = $_POST['length'];
        $weight = $_POST['weight'];
        $packaging_protocol = $_POST['packaging_protocol'];

        $result = addProduct(
            code: $code, name: $name, description: $description,
            height: $height, width: $width, 
            length: $length, weight: $weight, packaging_protocol: $packaging_protocol
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
        header("Location: index.php");
        exit();
    }
?>
<head>
    <script src="productForm.js"></script>
</head>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Add Products</h1>
            </header>
            <hr>
            <h2>Products</h2>
            <div class="rows">
                <div class="row-sm-3">
                    <h4 for="code">Code</h4>
                    <div class="inputs">
                        <input name="code" id="code" type="text" required maxlength="5">
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="name">Product Name</h4>
                    <div class="inputs">
                        <input name="name" id="name" type="text" required maxlength="50">
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="description">Description</h4>
                    <div class="inputs">
                        <input name="description" id="description" type="text"  required maxlength="255">
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="height">Height (cm)</h4>
                    <div class="inputs">
                        <input name="height" id="height" type="number" required >
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="width">Width (cm)</h4>
                    <div class="inputs">
                        <input name="width" id="width" type="number" required >
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="length">Length (cm)</h4>
                    <div class="inputs">
                        <input name="length" id="length" type="number" required >
                    </div>
                </div>
                
                <div class="row-md-5">
                    <h4 for="weight">Weight  (g)</h4>
                    <div class="inputs">
                        <input name="weight" id="weight" type="number" placeholder="12.5" required>
                    </div>
                </div>
                <div class="row-md-5">
                    <h4 for="packaging_protocol">Packaging Protocol</h4>
                    <div class="inputs">
                        <select class="input" required name="packaging_protocol" id="packaging_protocol options">
                            <?php 
                                while ($protocol = mysqli_fetch_assoc($protocols)):   
                                    echo "<option value='{$protocol['num']}'>{$protocol['name']}</option>";
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