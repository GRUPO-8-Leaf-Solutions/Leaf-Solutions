    var express = require("express");
    var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.get("/ultimas/:idEstufa", function (req, res) {
    leituraController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idEstufa", function (req, res) {
    leituraController.buscarMedidasEmTempoReal(req, res);
})

router.get("/maiorIndice/:idEstufa", function (req, res) {
    leituraController.coletarMaiorIndice(req, res);
})


router.get("/menorIndice/:idEstufa", function (req, res) {
    leituraController.coletarMenorIndice(req, res);
})

module.exports = router;