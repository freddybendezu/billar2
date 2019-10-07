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
			<h1>Agregar Productos</h1>

			<form class="form-horizontal" method="post" action="add">

				<div class="form-group">
					<label class="col-sm-3 control-label">Categoria:</label>
					<div class="col-sm-2">
						<input type="text" name="codigoCategoria" id="codigoCategoria" class="form-control"
							placeholder="codigoCategoria" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Producto:</label>
					<div class="col-sm-3">
						<input type="text" name="nombreProducto" id="nombreProducto" class="form-control"
							placeholder="nombreProducto" required>
					</div>
				</div>	
				<div class="form-group">
					<label class="col-sm-3 control-label">Unidades x caja:</label>
					<div class="col-sm-3">
						<input type="text" name="unidadesXCaja" id="unidadesXCaja" class="form-control"
							placeholder="unidadesXCaja" required>
					</div>
				</div>	
				<div class="form-group">
					<label class="col-sm-3 control-label">Nro. cajas compradas:</label>
					<div class="col-sm-3">
						<input type="text" name="nroCajasCompradas" id="nroCajasCompradas" class="form-control"
							placeholder="nroCajasCompradas" required>
					</div>
				</div>					
				<div class="form-group">
					<label class="col-sm-3 control-label">Nro. Unidades Compradas:</label>
					<div class="col-sm-3">
						<input type="text" name="nroUnidadesCompradas" id="nroUnidadesCompradas" class="form-control"
							placeholder="nroUnidadesCompradas" required>
					</div>
				</div>	
				<div class="form-group">
					<label class="col-sm-3 control-label">Precio x caja:</label>
					<div class="col-sm-3">
						<input type="text" name="precioXCaja" id="precioXCaja" class="form-control"
							placeholder="precioXCaja" required>
					</div>
				</div>	
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="add" class="btn btn-sm btn-primary" value="Guardar datos">
						<a href="/producto/list" class="btn btn-sm btn-danger">Cancelar</a>
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