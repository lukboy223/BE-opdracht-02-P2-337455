<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
<div class="row mt-3" style="display: <?= $data['messageVisibility'] ?>;">
        <div class="col-2"></div>
        <div class="col-8">
            <div class="alert text-center <?= $data['messageColor'] ?>" role="alert">
                <?= $data['message']; ?>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <h3>Levering product</h3>
            <ul>
                <li>Product naam: <?= $data['data'][0]->ProductNaam ?></li>
                <li>Leverancier: <?= $data['data'][0]->LeverancierNaam ?></li>
                <li>Contact persoon: <?=$data['data'][0]->ContactPersoon ?></li>
                <li>Leverancier Nummer: <?= $data['data'][0]->LeverancierNummer ?></li>
                <li>Mobiel: <?= $data['data'][0]->Mobiel ?></li>
            </ul>
        </div>
        <div class="col-2"></div>
    </div>
    <form action="<?= URLROOT; ?>/Leveranciers/AddLevering" method="post">
                <div class="mb-3">
                    <label for="aantalLev" class="form-label">Aantal:</label>
                    <input name="aantalLev" type="number" class="form-control" id="aantalLev" placeholder="0" value="<?= $data['aantalLev'] ?>">
                    <div class="errorFrom"><?= $data['aantalLevError'] ?></div>
                </div>

                <div class="mb-3">
                    <label for="datumLev">Datum Levering:</label>
                    <input type="date" name="datumLev" id="datumLev" class="form-control" placeholder="Vul hier de postcode in" value="<?= $data['datumLev'] ?>">
                    <div class="errorFrom"><?= $data['datumLevError'] ?></div>
                </div>

                <input type="hidden" name="PPLId" value="<?= $data['data'][0]->PPLId ?>">

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Sla op</button>
                </div>
            </form>

    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
           
            <a href="<?= URLROOT; ?>/magazijns/index">Terug</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
