var express = require("express");
var router = express.Router();

var funcionarioController = require("../controllers/funcionarioController");


router.post("/autenticar_two", function (req, res) {
    funcionarioController.login(req, res);
});

module.exports = router;