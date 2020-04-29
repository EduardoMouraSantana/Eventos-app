<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cadastro - Cliente</title>
<link
	href='<spring:url value="/resources/bootstrap/css/bootstrap.css" />'
	rel="stylesheet" />
<script
	src='<spring:url value="/resources/bootstrap/js/jquery-3.5.0.min.js" />'></script>
<script
	src='<spring:url value="/resources/bootstrap/js/bootstrap.js" />'></script>
<script
	src='<spring:url value="/resources/js/jquery.maskedinput-1.1.4.pack.js" />'></script>


<spring:url value="deleta" var="deleta"></spring:url>
<spring:url value="altera" var="altera"></spring:url>
<spring:url value="/evento/" var="evento"></spring:url>
<spring:url value="/casa/" var="casa"></spring:url>
<spring:url value="/cliente/" var="page_cliente"></spring:url>
<spring:url value="/eventos-app/" var="index"></spring:url>

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
		style="height: 60px;">
		<a class="navbar-brand" href="${index}">LoungeEventos</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<a class="nav-item nav-link active" href="${evento}">Eventos<span
					class="sr-only">(current)</span></a> <a
					class="nav-item nav-link active" href="${casa}">Casas De Show</a> <a
					class="nav-item nav-link active" href="${page_cliente}">Cliente</a>
			</div>
		</div>
	</nav>

	<div class="container mt-3">
		<c:if test="${not empty messageError}">
			<div id="divmErro" class="alert alert-danger" role="alert">
				${messageError}</div>
		</c:if>
		<c:if test="${not empty messageSuccess}">
			<div id="divSucesso" class="alert alert-success" role="alert">
				${messageSuccess}</div>
		</c:if>

		<div class="pb-2 mt-4 mb-2 border-bottom">
			<!--  header -->
			<h1>Cadastro - Cliente</h1>
		</div>


		<form:form action="/cliente/salva" name="form"
			modelAttribute="cliente" cssClass="mb-2">

			<form:hidden path="id" />

			<div class="form-group">
				<label> Nome: </label>
				<form:input path="nome" id="nome" cssClass="form-control"
					required="required" />
			</div>

			<div class="form-group">
				<label>Cpf:</label> <input id="cpf" name="cpf" class="form-control"
					required="required" onblur="ValidarCPF(form.cpf)"
					placeholder="000.000.000-00" />
			</div>

			<div class="form-group">
				<label>Email:</label>
				<form:input path="email" name="email" id="email"
					cssClass="form-control" required="required"
					onchange="ValidarEmail(form.email)" />
			</div>

			<input type="submit" name="salva" class="btn btn-primary mb-2"
				value="${cliente.id == 0 ? 'Cadastrar' : 'Alterar'}" />

			<c:if test="${cliente.id ne 0}">
				<input type="submit" name="cancela" value="Cancelar"
					class="btn btn-danger mb-2" />
			</c:if>

		</form:form>

	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#divErro').delay(5000).fadeOut('slow');
			$('#divSucesso').delay(5000).fadeOut('slow');
			$("#cpf").mask("999.999.999-99");

		});
		function ValidarCPF(Objcpf) {
			var cpf = Objcpf.value;
			exp = /\.|\-/g
			cpf = cpf.toString().replace(exp, "");
			var digitoDigitado = eval(cpf.charAt(9) + cpf.charAt(10));
			var soma1 = 0, soma2 = 0;
			var vlr = 11;

			for (i = 0; i < 9; i++) {
				soma1 += eval(cpf.charAt(i) * (vlr - 1));
				soma2 += eval(cpf.charAt(i) * vlr);
				vlr--;
			}
			soma1 = (((soma1 * 10) % 11) == 10 ? 0 : ((soma1 * 10) % 11));
			soma2 = (((soma2 + (2 * soma1)) * 10) % 11);

			var digitoGerado = (soma1 * 10) + soma2;
			if (digitoGerado != digitoDigitado) {
				alert('CPF Invalido!');
				Objcpf.value = "";
			}
		};
		function ValidarEmail(Objemail) {
			var email = Objemail.value;
			var emailFilter = /^.+@.+\..{2,}$/;
			var illegalChars = /[\(\)\<\>\,\;\:\\\/\"\[\]]/

			if (!(emailFilter.test(email)) || email.match(illegalChars)) {
				Objemail.value = "";
				alert('Por favor, informe um email válido');
			}

		};
	</script>
	
	
</body>
</html>