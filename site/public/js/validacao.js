function login() {
    var email = inputEmail.value
    var token = inputToken.value

    if (email == "leafadm@leaf.com" && token == 123456) {
        window.location.href = "../dashboard/dashboardPage.html"
    }else{
        alert("Senha e/ou Usuario incorreto")
    }
}