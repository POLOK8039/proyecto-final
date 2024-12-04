<?php
    require "packageFun.php";

    $products = getProducts();
    

    if($_SERVER['REQUEST_METHOD']=='POST'){

        $quantity = $_POST['quantity'];
        $prodCode = $_POST['product'];
        $product = getProductByCode($prodCode);

        $validate = $prodCode != null && $quantity > 0;
    
        if($validate){

            $readonly = "readonly";
            $disabled = "disabled";
            $minVol = $product['height'] * $product['width'] * $product['length'] * $quantity;
            $boxes = getBoxesByVol($minVol);
            $tag_types = getTagTypes();
        }

        if($_POST['validate'] == "true"){
        
            $boxCode = $_POST['box'];
            $tag_type = $_POST['tag_type'];
            $date = $_POST['date'];

            $bool = addPackage($prodCode, $quantity, $boxCode, $tag_type, $date);
            
            if($bool){
                header("Location: /process/process-view/");
            }
        }
    }

?>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Add Package</h1>
            </header>
            <hr>
            <h2>Products</h2>
            <input type="hidden" name="a" value="addPackage">
            <div class="rows">
                <div class="row-md-5">
                    <h4 for="product">Product</h4>
                    <select class="inputs" id="product" name="product" <?php echo $disabled; ?>>

                        <?php $first = $prodCode==null ? 'selected' : '';?>
                        <option value="" disabled <?php echo $first?>>Select a product</option>
                        
                        <?php foreach ($products AS $product):  
                            $selected = ($prodCode == $product['code']) ? ' selected' : '';
                        ?>
                        <option value="<?php echo $product['code'].'"'.$selected?>>
                            <?php echo $product['name']?> 
                        </option>
                    <?php endforeach; ?>
                    </select>
                </div>
                <div class="row-md-5">
                    <h4 for="quantity">Quantity</h4>
                    <div class="inputs">
                        <input name="quantity" id="quantity" type="number" value = "<?php echo $quantity?>" required min="2"<?php echo $readonly; ?>>

                    </div>
                </div>
                
                <?php if(!$validate):?>
                <div class="row-md-5">
                    <button class="btn-primary">Validate</button>
                </div>
                <?php endif;?>
            </div>
        </form>

        <?php if($validate): ?>
        <form class="form" action="" method="post" autocomplete="off"> 
            <input type="" name="product" id="product" value="<?php echo $prodCode?>" hidden>
            <input type="" name="quantity" id="quantity" value="<?php echo $quantity?>" hidden>
            <input type="" name="validate" id="validate" value="true" hidden>

            <div class="rows">       
                <div class="row-md-5">
                    <h4 for="box">Box</h4>
                    <select name="box" id="box" class="inputs">
                    <?php foreach ($boxes AS $box):  ?>
                        <option value="<?php echo $box['num']?>">
                            <?php echo '['.$box['num'].'] '.$box['height'].'cm x'.$box['width'].'cm x'.$box['width'].'cm'?> 
                        </option>
                    <?php endforeach; ?>
                    </select>
                </div>
                <div class="row-md-5">
                    <h4 for="date">Tag Type</h4>
                    <select id="tag_type" name="tag_type" class="inputs">
                    <?php foreach ($tag_types AS $tag_type):  ?>
                        <option value="<?php echo $tag_type['code']?>">
                            <?php echo $tag_type['description']?> 
                        </option>
                    <?php endforeach; ?>
                    </select>
                </div>
                <div class="row-md-5">
                    <h4 for="date">Date</h4>
                    <div class="inputs">
                        <input class="input" type="date" name="date" id="date" value="<?php echo date("Y-m-d"); ?>"required>
                    </div>
                </div>
            </div>
            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Confirm</button>
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