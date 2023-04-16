var express = require("express");
var router = express.Router();

var enderecoController = require("../controllers/enderecoController");


router.get("/", function (req, res) {
    enderecoController.testar(req, res);
});

router.get("/listar", function (req, res) {
    enderecoController.listar(req, res);
});

router.post("/cadastrar", function (req, res) {
    enderecoController.cadastrar(req, res);
});


module.exports = router;