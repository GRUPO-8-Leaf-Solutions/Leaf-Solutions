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

router.post("/exibirQtdSubSetores", function (req, res) {
    setoresController.buscarSubSetor(req, res);
});

router.post("/exibirQtdSensor", function (req, res) {
    setoresController.buscarSensor(req, res);
});

module.exports = router;