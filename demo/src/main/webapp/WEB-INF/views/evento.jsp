<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cadastro - Evento</title>
<link
	href='<spring:url value="/resources/bootstrap/css/bootstrap.css" />'
	rel="stylesheet" />
<script
	src='<spring:url value="/resources/bootstrap/js/jquery-3.5.0.min.js" />'></script>
<script
	src='<spring:url value="/resources/bootstrap/js/bootstrap.js" />'></script>

<spring:url value="deleta" var="deleta"></spring:url>
<spring:url value="altera" var="altera"></spring:url>
<spring:url value="/evento/" var="page_evento"></spring:url>
<spring:url value="/casa/" var="casa"></spring:url>
<spring:url value="/cliente/" var="cliente"></spring:url>
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
				<a class="nav-item nav-link active" href="${page_evento}">Eventos<span
					class="sr-only">(current)</span></a> <a
					class="nav-item nav-link active" href="${casa}">Casas De Show</a> <a
					class="nav-item nav-link active" href="${cliente}">Cliente</a>
			</div>
		</div>
	</nav>

	<div class="container mt-3">
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
			<h1>Cadastro - Evento</h1>
		</div>

		<form:form action="/evento/salva" modelAttribute="evento"
			enctype="multipart/form-data" cssClass="mb-2">

			<form:hidden path="id" />
			<form:hidden path="imageEvento" />

			<div class="form-group">
				<label> Nome: </label>
				<form:input path="nome" id="nome" cssClass="form-control"
					required="required" />
			</div>

			<div class="form-group">
				<label>Descrição:</label>
				<form:textarea rows="3" path="descricao" id="descricao"
					cssClass="form-control" required="required" maxlength="2000" />
			</div>

			<div class="form-group">
				<label>Casa de Show:</label> <input name="casa" id="casa"
					type="text" class="form-control" value="${evento.casa_show.nome}"
					required />
			</div>

			<div class="form-group">
				<label>Data:</label> <input name="data" id="data"
					class="form-control" type="date" id="example-date-input"
					value="${evento.data}" required />
			</div>

			<div class="form-group">
				<label>Preço:</label>
				<div class="form-inline">
					<div class="input-group-prepend">
						<div class="input-group-text">R$</div>
					</div>
					<input name="preco" id="preco" class="form-control"
						placeholder="00.00" value="${evento.preco}" required="required" />
				</div>
			</div>

			<div class="form-group">
				<label>Quantidade de ingresso:</label> <input
					name="quantidade_ingresso" id="quantidade_ingresso"
					class="form-control" required="required" placeholder=""
					value="${evento.quantidade_ingresso}" />
			</div>
			<div class="form-group">
				<label>Imagem</label>
				<div class="custom-file">
					<input type="file" name="imagem" class="custom-file-input"
						value="${imagemEvento}" /> <label class="custom-file-label">Escolha
						uma imagem</label>
				</div>
			</div>

			<c:if test="${evento.id ne 0}">
				<div class="mb-5">
					<img class="img-thumbnail"
						src="data:imagem/jpge;base64,${imagemEvento}">
				</div>
			</c:if>

			<input type="submit" name="salva" class="btn btn-primary mb-3"
				value="${evento.id == 0 ? 'Cadastrar' : 'Alterar'}" />

			<c:if test="${evento.id ne 0}">
				<input type="submit" name="cancela" value="Cancelar"
					class="btn btn-danger mb-3" />
			</c:if>

		</form:form>

		<c:if test="${not empty eventos}">

			<table class="table table-bordered  table-striped">

				<thead class="thead-dark">
					<tr>
						<th scope="col">Id</th>
						<th scope="col">Nome</th>
						<th scope="col">Descrição</th>
						<th scope="col">Casa de Show</th>
						<th scope="col">Data</th>
						<th scope="col">Preço</th>
						<th scope="col">Quantidade de Ingresso</th>
						<th scope="col" colspan="2">Ações</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="evento" items="${eventos}">
						<tr>
							<td scope="row">${evento.id}</td>
							<td>${evento.nome}</td>
							<td>${evento.descricao}</td>
							<td>${evento.casa_show.nome}</td>
							<td>${evento.data}</td>
							<td>${evento.preco}</td>
							<td>${evento.quantidade_ingresso}</td>
							<td><a href="${altera}/${evento.id}" class="btn btn-warning">Alterar</a></td>
							<td><a href="${deleta}/${evento.id}" class="btn btn-danger"
								onclick="return confirm('Deseja deletar esse evento?')">Deletar</td>
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