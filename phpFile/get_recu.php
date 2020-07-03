<?php
/*try{
$pdo = new PDO("mysql:host=localhost;dbname=id12941217_macnam","id12941217_weddou","lXn\>8Y-/O\~G5%$");
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
	echo $e->getMessage();
	die("could not connected");
}*/
    $mysqli = New mysqli("localhost","id12941217_weddou","lXn\>8Y-/O\~G5%$","id12941217_macnam");
     $mysqli->set_charset("utf8");
         $libelle = '';
         $idLang=21;
        $array = array();
        if(isset($_GET['recu']) && $_GET['recu'] && isset($_GET['cheked']) && $_GET['cheked']){
            
        if($_GET['cheked'] == 'affiliation'){
                      Affiliation();
        }else{
            if($_GET['cheked'] == 'rembourser'){
                                Rembourser();
           }else{
               //nous allons jamais arrivé ici
                 $array["recuId"] = "no";
                 die(json_encode($array));
            }                    
              }
 
        if(empty($array)){array_push($array,array("noBody"=>"yes"));}
		}else{array_push($array,array("noBody"=>"yes"));}

      echo json_encode($array);
     
 //fonction pour affiliation
  function Affiliation(){
         global $mysqli, $idLang,$libelle,$array;
               $Dsql = "SELECT `idRecu` FROM `d_immat_recu` WHERE `numRecu`='{$_GET['recu']}'";
               $Dresult = $mysqli->query($Dsql);
            if($Dresult->num_rows>0){
                    $array["recuId"] = "yes";
                    
                }else{
                    $array["recuId"] = "no";
                    die(json_encode($array));
                }
         
            if($_GET['lang'] == 'araffiliation')
                $l = 'araffiliation';
            else
                $l = 'fraffiliation';
                
    $sql = "SELECT INAM , fkidEtatDossier FROM d_dossier WHERE fkidRecu='{$_GET['recu']}'";            
    $result = $mysqli->query($sql);  
	     if($result->num_rows>0){
	     $use = $result->fetch_assoc();
        $inam = $use["INAM"];
	       $fkidEtat =  $use["fkidEtatDossier"];
	          if($fkidEtat)
	             $idLang = $fkidEtat;
	         if($inam)  
	            $array["ARid"] = $inam;
	        else
	           $array["ARid"] = null;
	             
                $langSql = "SELECT $l FROM `table_lang` WHERE `id`='$idLang'";    
                $langResult = $mysqli->query($langSql);
                 $libelle=$langResult->fetch_assoc()[$l];
                 $array["libelle"]=$libelle;
                 
	             }

	   $array["cheked"]="affiliation";
// if($Dresult->num_rows>0){$array["ARid"] = "yes";}else{$array["ARid"] = "no";}

	
     }
 //fonction pour rembourser
     function Rembourser(){
         
         global $mysqli, $idLang,$libelle,$array;
         $mntRembpourse='';
          $sql = "SELECT `idRecu` FROM `d_immat_recu` WHERE `ncin`='{$_GET['recu']}'";
	      $result = $mysqli->query($sql);             
                if($result->num_rows>0){
                    $array["recuId"] = "yes";
                    
                }else{
                    $array["recuId"] = "no";
                    die(json_encode($array));
                }
         
            if($_GET['lang'] == 'arrembourser')
                $l = 'arrembourser';
            else
                $l = 'frrembourser';
                
         $Dsql = "SELECT `id` FROM `d_remb_recu` WHERE `numRecu`='{$_GET['recu']}'";
	     /*$Dstm = $pdo->prepare($Dsql);$Dstm->execute();*/
	     $Dresult = $mysqli->query($Dsql);
	     if($Dresult->num_rows>0){
	     $user = $Dresult->fetch_assoc();
	     $userId = $user["id"];
	          $Lsql = "SELECT etat.id, numSinistre FROM d_remb_recu r JOIN d_remb_sinistre s ON r.id = s.fkidRecu JOIN ref_remb_etat etat ON s.fkidEtat = etat.id WHERE r.id='$userId'";
                    $Lresult = $mysqli->query($Lsql);
                if($Lresult->num_rows > 0){
                        $row=$Lresult->fetch_assoc();
                        $idLang = $row["id"];
                        $numSinistre = $row["numSinistre"];
                        $Rsql = "SELECT `mntRembourse` FROM `d_remb_bord_lines`  WHERE `numSinistre`='$numSinistre'";
                        $Rresult = $mysqli->query($Rsql);
                       $mntRembpourse = $Rresult->fetch_assoc()['mntRembourse'];
                        
                        }
                $langSql = "SELECT $l FROM `table_lang` WHERE `id`='$idLang'";    
                $langResult = $mysqli->query($langSql);
                 $libelle=$langResult->fetch_assoc()[$l];
                 $array["libelle"]=$libelle;
                 
	             }

	   $array["cheked"]="rembourser";
if($Dresult->num_rows>0){$array["ARid"] = "yes";}else{$array["ARid"] = "no";}

	if($mntRembpourse){$array["mntR"]=$mntRembpourse;}else{$array["mntR"]=null;}
	
     }  
       
?>