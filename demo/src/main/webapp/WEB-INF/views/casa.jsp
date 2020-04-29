<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cadastro - Casas de Show</title>
<spring:url value="deleta" var="deleta"></spring:url>
<spring:url value="altera" var="altera"></spring:url>

<spring:url value="/evento/" var="evento"></spring:url>
<spring:url value="/casa/" var="page_casa"></spring:url>
<spring:url value="/cliente/" var="cliente"></spring:url>
<spring:url value="/eventos-app/" var="index"></spring:url>

<link
	href='<spring:url value="/resources/bootstrap/css/bootstrap.css" />'
	rel="stylesheet" />
<script
	src='<spring:url value="/resources/bootstrap/js/jquery-3.5.0.min.js" />'></script>
<script
	src='<spring:url value="/resources/bootstrap/js/bootstrap.js" />'></script>

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
					class="nav-item nav-link active" href="${page_casa}">Casas De
					Show</a> <a class="nav-item nav-link active" href="${cliente}">Cliente</a>
			</div>
		</div>
	</nav>

	<div class="container">
		<c:if test="${not empty messageError}">
			<div id="divErro" class="alert alert-danger" role="alert">
				${messageError}</div>
		</c:if>
		<c:if test="${not empty messageSuccess}">
			<div id="divSucesso" class="alert alert-success" role="alert">
				${messageSuccess}</div>
		</c:if>

		<div class="pb-2 mt-4 mb-2 border-bottom">
			<!--  header -->
			<h1>Cadastro - Casa de Show</h1>
		</div>

		<form:form action="/casa/salva" modelAttribute="casa"
			enctype="multipart/form-data" cssClass="mb-2">

			<form:hidden path="id" />
			<form:hidden path="imageCasa" />

			<div class="form-group">
				<label> Nome: </label>
				<form:input path="nome" id="nome" cssClass="form-control"
					required="required" />
			</div>


			<div class="form-group">
				<label>Endereco:</label>
				<form:input path="endereco" id="endereco" cssClass="form-control"
					required="required" />
			</div>


			<div class="form-group">
				<label>Capacidade:</label> <input name="capacidade" id="capacidade"
					class="form-control" required="required" />
			</div>

			<div class="form-group">
				<label>Imagem</label>
				<div class="custom-file">
					<input type="file" name="imagem" class="custom-file-input"
						value="${imagemCasa}" /> <label class="custom-file-label">Escolha
						uma imagem</label>
				</div>
			</div>

			<c:if test="${casa.id ne 0}">
				<div class="mb-5">
					<img class="img-thumbnail"
						src="data:imagem/jpge;base64,${imagemCasa}">
				</div>
			</c:if>

			<input type="submit" name="salva" class="btn btn-primary mb-2"
				value="${casa.id == 0 ? 'Cadastrar' : 'Alterar'}" />

			<c:if test="${casa.id ne 0}">
				<input type="submit" name="cancela" value="Cancelar"
					class="btn btn-danger mb-2" />
			</c:if>
		</form:form>


		<c:if test="${not empty casas}">

			<table class="table table-bordered  table-striped">

				<thead class="thead-dark">
					<tr>
						<th scope="col">Id</th>
						<th scope="col">Nome</th>
						<th scope="col">Endereço</th>
						<th scope="col">Capacidade</th>
						<th scope="col" colspan="2">Ações</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="casa" items="${casas}">
						<tr>
							<td scope="row">${casa.id}</td>
							<td>${casa.nome}</td>
							<td>${casa.endereco}</td>
							<td>${casa.capacidade}</td>
							<td><a href="${altera}/${casa.id}" class="btn btn-warning">Alterar</a></td>
							<td><a href="${deleta}/${casa.id}" class="btn btn-danger"
								onclick="return confirm('Deseja deletar essa casa?')">Deletar</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</c:if>
	</div>

	

	<script type="text/javascript">
		$(document).ready(function() {
			$('#divErro').delay(5000).fadeOut('slow');
			$('#divSucesso').delay(5000).fadeOut('slow');
		});
	</script>


</body>
</html>