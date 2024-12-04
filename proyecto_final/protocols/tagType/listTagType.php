<?php
    require_once "../../config.php";
    require "tagTypeFun.php";
    $tagTypes = getTagTypes();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$tagTypes = empty($search) ? getTagTypes() : searchTagType($search);
?>
<main class="tables">
    <div class="background">
        <?php 
        $link="?a=add";
        include HEADER;
        ?>
        <table class="table">
            <h1>Tags type</h1>
            <thead>
                <tr>
                    <th>
                        <span>Code</span>
                        <span class="column-order"></span>
                    </th>
                    <th>
                        <span>Description</span>
                        <span class="column-order"></span>
                    </th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($tagTypes as $tagType): ?>
                <tr>
                    <td><?php echo $tagType['code']; ?></td>
                    <td><?php echo $tagType['description']; ?></td>
                    <?php if(validateUser("ADMIN","SUPER")):?>
                    <td>
                        <a class="btn" href="?a=edit&code=<?php echo $tagType['code'];?>">Edit</a>
                    </td>
                    <?php endif;?>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <?php include FOOTER ?>
    </div>
</main>
