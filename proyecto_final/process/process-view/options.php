<?php
    require_once "tracFun.php";
    $traceabilities = getTraceabilities();
?>
    <main class="tables">
        <div class="background">
            <?php 
            include HEADER 
            ?>
            <h1>Process</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>ID</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Date</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Product</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Packaging ID</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>State</span>    
                            <span class="column-order"></span>
                        </th>                        
                        <th>
                            <span>Actions</span>    
                        </th>                        
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($traceabilities as $trac): ?>
                    <tr>
                        <td><?php echo $trac['ID'] ?></td>
                        <td><?php echo $trac['Date'] ?></td>
                        <td><?php echo $trac['Product'] ?></td>
                        <td><?php echo $trac['Packaging_ID'] ?></td>
                        <td><?php echo $trac['State'] ?></td>
                        <td>
                            <a class="btn" href="?t=<?php echo $trac['ID'] ?>">SELECT</a>
                        </td>
                    </tr>
                    <?php endforeach;?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>