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
		<h1>Actualizar Productos</h1>

		<%
			Entity producto = (Entity) request.getAttribute("producto");
		%>

		<form method="post" action="../update" class="form-horizontal">
			<input type="hidden" name="id" id="id"
				value="<%=producto.getKey().getId()%>" />

			<div class="form-group">
				<label class="col-sm-3 control-label">Categoria:</label>
				<div class="col-sm-2">
					<input type="text" name="codigoCategoria" id="codigoCategoria" value="<%=producto.getProperty("codigoCategoria")%>"  class="form-control" placeholder="NIK" required>
				</div>
			</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Producto:</label>
					<div class="col-sm-3">
						<input type="text" name="nombreProducto" id="nombreProducto"
						value="<%=producto.getProperty("nombreProducto")%>" class="form-control" placeholder="Teléfono" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Unidades x caja:</label>
					<div class="col-sm-3">
						<input type="number"
						name="unidadesXCaja"
						id="unidadesXCaja"
						value="<%=producto.getProperty("unidadesXCaja")%>" class="form-control" placeholder="Teléfono" required>
					</div>
				</div>	
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Nro. cajas compradas:</label>
					<div class="col-sm-2">
						<input type="number" readonly
						name="nroCajasCompradas" id="nroCajasCompradas"
						value="<%=producto.getProperty("nroCajasCompradas")%>"
						class="form-control" 
						placeholder="nroCajasCompradas"
						required>
						<input type="number"
						name="nroCajasCompradas1" id="nroCajasCompradas1"
						class="form-control" 
						placeholder="nroCajasCompradas"
						required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Nro. unidades compradas:</label>
					<div class="col-sm-2">
						<input type="number" readonly
						name="nroUnidadesCompradas" id="nroUnidadesCompradas"
						value="<%=producto.getProperty("nroUnidadesCompradas")%>"
						class="form-control" 
						placeholder="Teléfono"
						required>
						<input type="number"
						name="nroUnidadesCompradas1" id="nroUnidadesCompradas1"
						class="form-control" 
						placeholder="nroCajasCompradas"
						required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Precio x caja:</label>
					<div class="col-sm-3">
						<input type="text"
						name="precioXCaja" id="precioXCaja"
						value="<%=producto.getProperty("precioXCaja")%>"
						class="form-control" 
						placeholder="Teléfono"
						required>
					</div>
				</div>									
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="save" class="btn btn-sm btn-primary" value="Guardar datos">
						<a href="/producto/list" class="btn btn-sm btn-danger">Cancelar</a>
					</div>
				</div>
	
		</form>
	</div>
	</div>	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>