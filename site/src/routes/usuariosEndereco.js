var express = require("express");
var router = express.Router();

var usuarioControllerEnd = require("../controllers/usuarioControllerEnd");


//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarEnd", function (req, res) {
    usuarioControllerEnd.cadastrarEnd(req, res);
});

router.get("/", function (req, res) {
    usuarioControllerEnd.testar(req, res);
});

router.get("/listar", function (req, res) {
    usuarioControllerEnd.listar(req, res);
});


module.exports = router;