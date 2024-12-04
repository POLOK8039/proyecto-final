<?php
    require_once("../../config.php");
    require "protocolFun.php";
    
    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        $protocol = getProtocolByNumber($num);

        if (!$protocol || !isset($protocol['num'])) {
            echo "Protocol not found";
            exit;
        }      
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $num = $_POST['num'];
        $name = $_POST['name'];
        $file = $_FILES['pdf'];
        
        error_log("Filename: ".$_FILES['pdf']['name']);

        error_log("POST PDF: $name  ".$_FILES['pdf']['name']);
        $file_name = !empty($_FILES['pdf']['name']) ? $_FILES['pdf']['name'] : $_POST['old_file_name'];
        
        error_log("new file name: $file_name | old: ".$_POST['old_file_name']);
        if (updateProtocol(num:$num, name:$name, file_name:$file_name, file: $file)) {
            echo "<div class='div-msg' id='success-msg'><span class='msg'>Protocol successfully updated.</span></div>";
        } else {
            echo "<div class='div-msg' id='success-msg'><span class='msg'>Error updating protocol.</span></div>";
        }
        header("Location: /protocols/protocol");
        exit();
    }
?>
<head>
    <script src="protocolForm.js"></script>
</head>


<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off" enctype="multipart/form-data">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Edit Protcol</h1>
            </header>
            <?php if(validateUser("ADMIN")):?>
                <a class="btn-primary" href="?a=del&num=<?php echo $protocol['num']; ?>" onclick="return confirm('Are you sure you want to disable this protocol?');">Disable</a>
            <?php endif; ?>                
            <hr>
            <h2>Protocol</h2>
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="num">Num</h4>
                    <div class="inputs">
                        <input name="num" id="num" type="text"  value="<?php echo $protocol['num']; ?>" readonly>
                    </div>
                </div>
                <div class="row-md-5">
                    <h4 for="name">Name of protocol</h4>
                    <div class="inputs">
                        <input name="name" id="name" type="text" maxlength="50" value="<?php echo $protocol['name']; ?>">
                    </div>
                </div>
            </div>
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="old_file_name">Actual File</h4>
                    <div class="inputs">
                        <input name="old_file_name" id="old_file_name" type="text"  value="<?php echo $protocol['file_name']; ?>" readonly>
                    </div>
                </div>
                <div class="row-md-5">
                    <h4 for="pdf">New file</h4>
                    <input class="inputs" name="pdf" id="pdf" type="file" accept=".pdf" >
                </div>

            </div>
            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Confirm</button>
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