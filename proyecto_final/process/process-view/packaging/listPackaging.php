<?php
    require_once("../../config.php");
    require "packagingFun.php";
    $packagings = getPackagings();
?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add";
            include HEADER;
            ?>
            <h1>Packagings</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Code</span>
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
                        <th>
                            <span>Package quantity</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Zone</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Outbound</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Tag</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($packagings as $packaging): ?>
                    <tr>
                        <td><?php echo $packaging['code']; ?></td>
                        <td><?php echo $packaging['height']; ?></td>
                        <td><?php echo $packaging['width']; ?></td>
                        <td><?php echo $packaging['length']; ?></td>
                        <td><?php echo $packaging['volume']; ?></td>
                        <td><?php echo $packaging['weight']; ?></td>
                        <td><?php echo $packaging['package_quantity']; ?></td>
                        <td><?php echo $packaging['zone']; ?></td>
                        <td><?php echo $packaging['outbound']; ?></td>
                        <td><?php echo $packaging['tag']; ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>