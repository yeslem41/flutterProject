<?php
/*try{
$pdo = new PDO("mysql:host=localhost;dbname=id12941217_macnam","id12941217_weddou","lXn\>8Y-/O\~G5%$");
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
	echo $e->getMessage();
	die("could not connected");
}*/
    $mysqli = New mysqli("localhost","id12941217_weddou","lXn\>8Y-/O\~G5%$","id12941217_macnam");
        $array = array();
        if(isset($_GET['recu']) && $_GET['recu'] && isset($_GET['cheked']) && $_GET['cheked']){
	    $sql = "SELECT `id` FROM `d_immat_recu` WHERE `ncin`='{$_GET['recu']}'";
	    $result = $mysqli->query($sql);
	   /* $stm = $pdo->prepare($sql);$stm->execute();*/
	   
        if($_GET['cheked'] == 'affiliation'){
        $Dsql = "SELECT `id` FROM `d_immat_recu` WHERE `numRecu`='{$_GET['recu']}'";
	     /*$Dstm = $pdo->prepare($Dsql);$Dstm->execute();*/
	     $Dresult = $mysqli->query($Dsql);
        }else{
         $Dsql = "SELECT `id` FROM `d_remb_recu` WHERE `numRecu`='{$_GET['recu']}'";
	     /*$Dstm = $pdo->prepare($Dsql);$Dstm->execute();*/
	     $Dresult = $mysqli->query($Dsql);
        }
        
 if($result->num_rows>0){array_push($array,array("recuId"=>"yes"));}else{array_push($array,array("recuId"=>"no"));}
	   
if($Dresult->num_rows>0){array_push($array,array("ARid"=>"yes"));}else{array_push($array,array("ARid"=>"no"));}

	if($_GET['cheked'] == 'affiliation'){array_push($array,array("cheked"=>"affiliation"));}else{array_push($array,array("cheked"=>"rembourser"));}	   
        if(empty($array)){array_push($array,array("noBody"=>"yes"));}
		
		}else{array_push($array,array("noBody"=>"erreur du service"));}
		
       echo json_encode($array);
?>