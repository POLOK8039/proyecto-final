<?php
    require_once("../config.php");
    require "boxFun.php";

    $boxes = getBoxes();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$boxes = empty($search) ? getBoxes() : searchBox($search);
?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add"; 
            include HEADER;
            ?>
            <h1>Boxes</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Number</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Height</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Width</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Length</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Volume</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Weight</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody id="box">
                    <?php foreach($boxes as $box): ?>
                    <tr>
                        <td><?php echo $box['num'] ?></td>
                        <td><?php echo $box['height'].' cm' ?></td>
                        <td><?php echo $box['width'].' cm' ?></td>
                        <td><?php echo $box['length'].' cm' ?></td>
                        <td><?php echo $box['volume'].' cm3' ?></td>
                        <td><?php echo $box['weight'].' g' ?></td>
                        <?php if(validateUser("ADMIN", "SUPER")):?>
                        <td>
                            <a class="btn" href="?a=edit&num=<?php echo $box['num'];?>">Edit</a>
                        </td>
                        <?php endif; ?>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>
   