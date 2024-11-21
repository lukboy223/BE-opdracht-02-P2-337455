<?php

class Leveranciers extends BaseController
{
    private $leverancierModel;

    public function __construct()
    {
        $this->leverancierModel = $this->model('Leverancier');
    }
    public function index($error = null)
    {
        if(!is_null($error)){
            $color = 'alert-danger';
            $visibility = 'flex';
        }else{
            $color = '';
            $visibility = '';
        }

        $data = [
            'Magazijn'             => null,
            'message'               => $error,
            'messageColor'          => $color,
            'messageVisibility'     => $visibility
        ];

        $data['Leveranciers'] = $this->leverancierModel->LeverancierOverzicht();

        $this->view('leveranciers/index', $data);
    }

    public function viewProducts(int $leverancierId)
    {

        $products = $this->leverancierModel->ReadProductLeverancierByLevId($leverancierId);
        $LeverancierInfo = $this->leverancierModel->ReadLeverancierById($leverancierId);
        var_dump($LeverancierInfo);
        

        if (empty($products)) {
            $this->index("Geen informatie gevonden met van die leverancier.");
        } else {
            $data = [
                "LeverancierNaam"       => $products[0]->LeverancierNaam,
                "ContactPersoon"        => $products[0]->ContactPersoon,
                "LeverancierNummer"     => $products[0]->LeverancierNummer,
                "Mobiel"                => $products[0]->Mobiel,
                "Products"              => $products,
                'message'               => '0',
                'messageColor'          => '',
                'messageVisibility'     => 'none'
            ];
            $this->view('leveranciers/view', $data);
        }
    }

    public function AddLevering()
    {
        
    }
}