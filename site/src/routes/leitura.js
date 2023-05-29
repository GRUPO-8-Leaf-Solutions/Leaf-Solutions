    var express = require("express");
    var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.get("/ultimas/:idEmpresa", function (req, res) {
    leituraController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idEmpresa", function (req, res) {
    leituraController.buscarMedidasEmTempoReal(req, res);
})


router.post("/obterMenorIndice", function (req, res){
    leituraController.obterMenorIndice(req, res);
} )



router.post("/obterMaiorIndice", function (req, res){
    leituraController.obterMaiorIndice(req, res);
} )


router.post("/obterCaptacoes", function (req, res){
    leituraController.obterCaptacoes(req, res);
})

module.exports = router;