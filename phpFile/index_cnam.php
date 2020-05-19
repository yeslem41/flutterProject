<?php 

/*try{
$pdo = new PDO("mysql:host=localhost;dbname=id12941217_macnam","id12941217_weddou","lXn\>8Y-/O\~G5%$");
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
	echo $e->getMessage();
	die("could not connected");
}*/
$array = array();
$mysqli = New mysqli("localhost","id12941217_weddou","lXn\>8Y-/O\~G5%$","id12941217_macnam");

   if(isset($_GET['NIN']) && $_GET['NIN']){
	     $sql = "SELECT `id` FROM `d_dossier` WHERE `numCin`='{$_GET['NIN']}' OR `INAM`='{$_GET['NIN']}'";
	    /*$stm = $pdo->prepare($sql);
        $stm->execute();
	    */
	    $result = $mysqli->query($sql);
		while($row = $result->fetch_assoc()){
			array_push($array,array("id"=>$row['id']));
          	} 
  if(empty($array))
array_push($array,array("noBody"=>"yes"));
		echo json_encode($array);
		}else
          echo json_encode(["error"=>'error service']);

?>