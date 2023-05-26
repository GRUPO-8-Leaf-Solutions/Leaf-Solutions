var express = require("express");
var router = express.Router();

var setoresController = require("../controllers/setoresController");


router.post("/exibirQtdSetores", function (req, res) {
    setoresController.exibirQtdSetores(req, res);
});

router.post("/obterSetores", function (req, res) {
    setoresController.obterSetores(req, res);
});

router.get("/obterSetoresInner/:idEstufa", function (req, res) {
    setoresController.obterSetoresInner(req, res);
});

module.exports = router;