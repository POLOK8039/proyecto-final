<?php
    require_once "reportFun.php";
    $reports = getReports();

    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$reports = empty($search) ? getReports() : searchReport($search);
?>
    <main class="tables">
        <div class="background">
            <?php 
            include HEADER 
            ?>
            <h1>Reports</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Folio</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Start date</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>End date</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Report date</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Packed products</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Observations</span>    
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Traceability</span>    
                            <span class="column-order"></span>
                        </th>
                        
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($reports as $report): ?>
                    <tr>
                        <td><?php echo $report['folio'] ?></td>
                        <td><?php echo $report['start_date'] ?></td>
                        <td><?php echo $report['end_date'] ?></td>
                        <td><?php echo $report['report_date'] ?></td>
                        <td><?php echo $report['packed_products'] ?></td>
                        <td><?php echo $report['observations'] ?></td>
                        <td><?php echo $report['traceability'] ?></td>
                    </tr>
                    <?php endforeach;?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>