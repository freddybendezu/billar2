<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/css1/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css1/style_nav.css"
	rel="stylesheet">
<style>
.content {
	margin-top: 80px;
}
</style>

<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<jsp:include page="nav.jsp" />
	</nav>
	<div class="container">
		<div class="content">
			<h1>Billar Precio politica</h1>

			<%
				Entity billarPrecio = (Entity) request.getAttribute("billarprecio");
			%>

			<form method="post" action="../update" class="form-horizontal">
				<input type="hidden" name="id" id="id"
					value="<%=billarPrecio.getKey().getId()%>" />

				<div class="form-group">
					<label class="col-sm-3 control-label">Hora inicio normal:</label>
					<div class="col-sm-4">
						<input type="text" name="horainicionormal" id="h0"
							value="<%=billarPrecio.getProperty("horainicionormal")%>"
							class="form-control" placeholder="horainicionormal" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Hora fin normal:</label>
					<div class="col-sm-4">
						<input type="text" name="horafinnormal" id="horafinnormal"
							value="<%=billarPrecio.getProperty("horafinnormal")%>"
							class="form-control" placeholder="horafinnormal" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Precio hora normal:</label>
					<div class="col-sm-4">
						<input type="text" name="precionormal" id="precionormal"
							value="<%=billarPrecio.getProperty("precionormal")%>"
							class="form-control" placeholder="precionormal" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Incremento:</label>
					<div class="col-sm-4">
						<input type="text" name="incremento" id="incremento"
							value="<%=billarPrecio.getProperty("incremento")%>"
							class="form-control" placeholder="incremento" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Numero horas descuento:</label>
					<div class="col-sm-4">
						<input type="text" name="numerohorasdescuento" id="numerohorasdescuento"
							value="<%=billarPrecio.getProperty("numerohorasdescuento")%>"
							class="form-control" placeholder="numerohorasdescuento" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Porcentaje descuento:</label>
					<div class="col-sm-4">
						<input type="text" name="porcentajedescuento" id="porcentajedescuento"
							value="<%=billarPrecio.getProperty("porcentajedescuento")%>"
							class="form-control" placeholder="porcentajedescuento" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Precio unitario taco:</label>
					<div class="col-sm-4">
						<input type="text" name="preciounitariotaco" id="preciounitariotaco"
							value="<%=billarPrecio.getProperty("preciounitariotaco")%>"
							class="form-control" placeholder="preciounitariotaco" required>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="save" class="btn btn-sm btn-primary"	value="Guardar datos">
						<a href="/billar/billarmesalist" class="btn btn-sm btn-danger">Cancelar</a>
					</div>
				</div>

			</form>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>