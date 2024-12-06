<?php

class Leverancier
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    public function LeverancierOverzicht(){
        try {

            $sql = "CALL spReadLeverancier()";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }

    public function ReadProductLeverancierByLevId($id){
        try {

            $sql = "CALL spReadProductLeverancierByLevId($id)";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadLeverancierById($id){
        try {

            $sql = "CALL spReadLeverancierById($id)";

            $this->db->query($sql);

            return $this->db->single();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadProductLeverancierByProId($productId)
    {
        try {

            $sql = "CALL spReadProductLeverancierByProId(:id)";

            $this->db->query($sql);

            $this->db->bind(':id', $productId, PDO::PARAM_INT);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
}
