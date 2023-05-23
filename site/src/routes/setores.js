var express = require("express");
var router = express.Router();

var setoresController = require("../controllers/setoresController");

router.post("/qtdSetores", function (req, res) {
    setoresController.qtdSetores(req, res);
});

router.post("/exibirQtdSetores", function (req, res) {
    setoresController.exibirQtdSetores(req, res);
});

module.exports = router;