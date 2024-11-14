<?php

class Leveranciers extends BaseController
{
    private $leverancierModel;

    public function __construct()
    {
        $this->leverancierModel = $this->model('Leverancier');
    }
    public function index()
    {

        $data = [
            'Magazijn'             => null,
            'message'               => '',
            'messageColor'          => '',
            'messageVisibility'     => 'none'
        ];

        $data['Leveranciers'] = $this->leverancierModel->LeverancierOverzicht();

        $this->view('leverancier/index', $data);
    }
}