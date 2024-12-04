<?php
    require_once("../../config.php");
    
    require "protocolFun.php";
    $protocols = getProtocols();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$protocols = empty($search) ? getProtocols() : searchProduct($search);

?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add";
            include HEADER 
            ?>
            <h1>Protocols</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Code</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Name</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>File</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($protocols as $protocol):?>
                    <tr>
                        <td><?php echo  $protocol['num'];?> </td>
                        <td><?php echo  $protocol['name'];?></td>
                        <td><?php echo  $protocol['file_name'];?></td>
                        <td>
                            <?php if(validateUser("ADMIN", "SUPER")): ?>
                                <a class="btn" href="?a=edit&num=<?php echo $protocol['num'];?>">Edit</a>
                            <?php endif; ?>
                            
                            <a class="btn" 
                            href="<?php echo URL . 'uploads/' . $protocol['file_name']; ?>"
                            onclick="<?php if (!checkProtocolFile($protocol['file_name'])): ?>
                                            alert('The protocol is not available online. Please request instructions from the nearest supervisor.');
                                            return false;
                                        <?php endif; ?>">
                            View
                            </a>


                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>