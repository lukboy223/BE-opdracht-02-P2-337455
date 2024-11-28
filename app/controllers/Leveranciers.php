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
        
        if (empty($products)) {
           
            $productsData = $products;
            $message = 'Dit bedrijf heeft tot nu toe geen producten geleverd aan Jamin';
            $messageColor = 'alert-danger';
            $messageVisibility = 'flex';
            header('Refresh:3;' .  URLROOT . '/leveranciers/index');
        } else {
            $productsData = $products;
            $message = '';
            $messageColor = '';
            $messageVisibility = '';
        }
        $data = [
            "LeverancierNaam"       => $LeverancierInfo->LeverancierNaam,
            "ContactPersoon"        => $LeverancierInfo->ContactPersoon,
            "LeverancierNummer"     => $LeverancierInfo->LeverancierNummer,
            "Mobiel"                => $LeverancierInfo->Mobiel,
            "Products"              => $productsData,
            'message'               => $message,
            'messageColor'          => $messageColor,
            'messageVisibility'     => $messageVisibility
        ];
        $this->view('leveranciers/view', $data);
    }

    public function AddLevering()
    {
        
    }
}