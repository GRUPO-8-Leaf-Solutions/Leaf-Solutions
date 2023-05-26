    var express = require("express");
    var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.get("/ultimas/:idEmpresa", function (req, res) {
    leituraController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idEmpresa", function (req, res) {
    leituraController.buscarMedidasEmTempoReal(req, res);
})

router.post("/coletarMaiorIndice", function (req, res) {
    leituraController.coletarMaiorIndice(req, res);
})


router.post("/coletarMenorIndice", function (req, res) {
    leituraController.coletarMenorIndice(req, res);
})

router.post("/exibirAlertas"), function (req, res){
    leituraController.exibirAlertas(req, res);
}

module.exports = router;