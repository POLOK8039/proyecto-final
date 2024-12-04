<?php
    require_once("../../../config.php");
    require "zoneFun.php";
    $zones = getZones();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$zones = empty($search) ? getZones() : searchZone($search);
?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add";
            include HEADER;
            ?>
            <h1>Zones</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Code</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Area</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Available capacity</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Total capacity</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($zones as $zone): ?>
                    <tr>
                        <td><?php echo $zone['code']; ?></td>
                        <td><?php echo $zone['area']; ?></td>
                        <td><?php echo $zone['available_capacity'].' (packaging)'; ?></td>
                        <td><?php echo $zone['total_capacity'].' (packaging)'; ?></td>
                        <?php if(validateUser("ADMIN", "SUPER")):?>
                        <td>
                            <a class="btn" href="?a=edit&code=<?php echo $zone['code'];?>">Edit</a>
                        </td>
                        <?php endif;?>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>