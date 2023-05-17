var express = require("express");
var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.get("/ultimas/:idEstufa", function (req, res) {
    leituraController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idEstufa", function (req, res) {
    leituraController.buscarMedidasEmTempoReal(req, res);
})

module.exports = router;