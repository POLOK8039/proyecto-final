<?php
    if(!validateUser("ADMIN","SUPER")){
        header("Location: /tag/");//verificar desde donde es
        exit;
    }
    require "tagFun.php";
    
    $tag_types = getTagTypes();

    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        $tag = getTagByNumber($num);
        if (!$tag) {
            echo "Tag not found";
            exit;
        }
    }

    if ($_SERVER['REQUEST_METHOD']=='POST') {

        $num = $_POST['num'];
        $date = $_POST['date'];
        $tag_type = $_POST['tag_type'];
        $destination = $_POST['destination'];

        $result = updateTag(num:$num, 
            date: $date, tag_type:$tag_type, destination:$destination
        );

        if ($result) {
            echo "<div class='div-msg' id='success-msg'><span class='msg'>Tag updated successfully</span></div>";
        } else {
            echo "<div class='div-msg' id='error-msg'><span class='msg'>Error updating tag</span></div>";
        }
        header("Location: index.php");
        exit();
    }
?>
<script src="tagForm.js"></script>

<main class="forms">
    
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Edit tags</h1>
            </header>
            <hr>
            <h2>Tag</h2>
            <div class="rows">
                <div class="row-sm-3">
                    <h4 for="num">Num</h4>
                    <div class="inputs">
                        <input name="num" id="num" type="number" value="<?php echo $tag['num']; ?>" readonly>
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="date">Date</h4>
                    <div class="inputs">
                        <input name="date" id="date" type="date" value="<?php echo $tag['date']; ?>" required>
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="tag_type">Tag Type</h4>
                    <div class="inputs">
                        <select class="input" required name="tag_type" id="tag_type">
                            <?php 
                                while ($tag_type = mysqli_fetch_assoc($tag_types)):
                                    $selected = $tag['tag_type'] === $tag_type['code'] ? 'selected' : '';
                                    echo "<option value='{$tag_type['code']}' $selected>{$tag_type['description']}</option>";
                                endwhile; 
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="destination">Destination</h4>
                    <div class="inputs">
                        <input name="destination" id="destination" type="text" placeholder="Cuba"  maxlength="25"   value="<?php echo $tag['destination']; ?>" required>
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
<script>
        setTimeout(() => {
            const successMsg = document.getElementById('success-msg');
            const errorMsg = document.getElementById('error-msg');
            if (successMsg) successMsg.style.display = 'none';
            if (errorMsg) errorMsg.style.display = 'none';
        }, 3000);
    </script>