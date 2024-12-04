<?php
    require_once("../../config.php");
    require "unitFun.php";
    $units = getUnits();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$units = empty($search) ? getUnits() : searchUnit($search);
?>
    <main class="tables">
        <div class="background">
        <?php include HEADER; ?>
        <h1>Unit of measure</h1>
            <table class="table">
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
                    <?php foreach ($units as $unit): ?>
                    <tr>
                        <td><?php echo $unit['code']; ?></td>
                        <td><?php echo $unit['description']; ?></td>

                        <?php if(validateUser("ADMIN", "SUPER")):?>
                        <td>
                            <a href="?a=edit&code=<?php echo $unit['code']; ?>" class="btn">Edit</a>
                        </td>
                        <?php endif;?>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>