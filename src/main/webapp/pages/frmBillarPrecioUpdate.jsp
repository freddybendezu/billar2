<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<style>
	body{
		font-size: 12px;
	}

</style>

<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
		<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h4>MESA DE BILLAR - PRECIO</h4>

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
	
</body>
</html>