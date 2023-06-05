process.env.AMBIENTE_PROCESSO = "desenvolvimento";
// process.env.AMBIENTE_PROCESSO = "producao";

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA = process.env.AMBIENTE_PROCESSO == "desenvolvimento" ? 3333 : 8080;

var app = express();

var indexRouter = require("./src/routes/index");
var usuariosRouter = require("./src/routes/usuarios");
var usuarioEnderecoRouter = require("./src/routes/usuariosEndereco");
var usuariosEstufaRouter = require("./src/routes/usuariosEstufa");
var leituraRouter = require("./src/routes/leitura");
var setoresRouter = require("./src/routes/setores");
var subSetores = require("./src/routes/subSetores");
var funcionario = require("./src/routes/funcionario")

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuariosRouter);
app.use("/usuariosEndereco", usuarioEnderecoRouter);
app.use("/usuariosEstufa", usuariosEstufaRouter);
app.use("/leitura", leituraRouter);
app.use("/estufa", usuariosEstufaRouter);
app.use("/setores", setoresRouter);
app.use("/subSetores", subSetores);
app.use("/funcionario", funcionario)

// app.use("/empresa", empresaRouter);

app.listen(PORTA, function () {
    console.log(`Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar: http://localhost:${PORTA} \n
    Você está rodando sua aplicação em Ambiente de ${process.env.AMBIENTE_PROCESSO} \n
    \t\tSe "desenvolvimento", você está se conectando ao banco LOCAL (MySQL Workbench). \n
    \t\tSe "producao", você está se conectando ao banco REMOTO (SQL Server em nuvem Azure) \n
    \t\t\t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'`);
});
