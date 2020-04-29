<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Detalhes - Evento</title>
<link
	href='<spring:url value="/resources/bootstrap/css/bootstrap.css" />'
	rel="stylesheet" />
<script
	src='<spring:url value="/resources/bootstrap/js/jquery-3.5.0.min.js" />'></script>
<script
	src='<spring:url value="/resources/bootstrap/js/bootstrap.js" />'></script>

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

	<div class="container mt-4">
		<div class="text-center">
			<h3>Detalhes do evento</h3>
			<hr />
		</div>
		<div class="col-lg-12 md-6 d-flex justify-content-center">
			<div class="card h-100" style="width: 55rem;"">
				<a><img class="card-img-top"
					src="data:image/jpge;base64,${imageEvento}"></a>
				<div class="text-center mt-2">

					<h5 class="card-title">${evento.nome}</h5>
					<h6>Valor do ingresso: R$${evento.preco}</h6>
					<h6>Descricao: ${evento.descricao}</h6>
					<h6>Data: ${evento.data}</h6>
					<h6>Endereço: ${evento.casa_show.endereco}</h6>
					<h6>Casa de Show: ${evento.casa_show.nome}</h6>
					<div class="row d-flex justify-content-center">
						<input class="form-control col-2 mr-3" type="number"
							name="quantidade" min="1" max="4">
						<button class="btn btn-success">Comprar</button>
					</div>


				</div>
				<div class="card-footer text-center mt-3">
					<medium> ${evento.quantidade_ingresso} ingressos
					disponíveis</medium>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="${request.contextPath}/eventos-app/rodape"></jsp:include>
</body>
</html>