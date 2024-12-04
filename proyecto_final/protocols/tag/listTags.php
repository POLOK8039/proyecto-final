<?php
    require_once "../../config.php";
    require "tagFun.php";
    $tags = getTags();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$tags = empty($search) ? getTags() : searchTag($search);
?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add";
            include HEADER;
            ?>
            <table class="table">
                <h1>Tags</h1>
                <thead>
                    <tr>
                        <th>
                            <span>Date</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Barcode</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Tag type</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Destination</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($tags as $tag): ?>
                    <tr>
                        <td><?php echo $tag['date']; ?></td>
                        <td><?php echo $tag['barcode']; ?></td>
                        <td><?php echo $tag['tag_type']; ?></td>
                        <td><?php echo $tag['destination']; ?></td>
                        <?php if(validateUser("ADMIN","SUPER")):?>
                        <td>
                            <a class="btn" href="?a=edit&num=<?php echo $tag['num'];?>">Edit</a>
                        </td>
                        <?php endif;?>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>