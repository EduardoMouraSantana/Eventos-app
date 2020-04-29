<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoungeEventos - Início</title>

<link
	href='<spring:url value="/resources/bootstrap/css/bootstrap.css" />'
	rel="stylesheet" />
<script
	src='<spring:url value="/resources/bootstrap/js/jquery-3.5.0.min.js" />'></script>
<script
	src='<spring:url value="/resources/bootstrap/js/bootstrap.js" />'></script>

<spring:url value="detalhe" var="detalhe"></spring:url>
<spring:url value="/evento/" var="evento"></spring:url>
<spring:url value="/casa/" var="casa"></spring:url>
<spring:url value="/cliente/" var="cliente"></spring:url>
<spring:url value="/eventos-app/" var="index"></spring:url>

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="height: 60px;">
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
					class="nav-item nav-link active" href="${cliente}">Cliente</a>
			</div>
		</div>
	</nav>
	<div class="container mt-3">
		<div class="row">
			<c:forEach var="evento" items="${eventos}">
			
				<div class="col-lg-4 col-md-5 mb-3">
					<div class="card h-100" style="width: 22rem; ">
						<a><img class="card-img-top" src="data:image/jpge;base64,${evento.base64}"></a>
						<div class="text-center mt-2">
						
							<h5 class="card-title">
								<a href="${detalhe}/${evento.id}">${evento.nome}</a>
							</h5>
							<h6>R$ ${evento.preco}</h6>
							
						</div>
						<div class="card-footer text-center">
							<small> ${evento.quantidade_ingresso} ingressos</small>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<jsp:include page="${request.contextPath}/eventos-app/rodape"></jsp:include>
</body>
</html>