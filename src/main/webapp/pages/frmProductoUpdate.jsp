<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<style type="text/css">
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
		<h4>PRODUCTOS</h4>

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
						placeholder="Cajas"
						required>
						<input type="number"
						name="nroCajasCompradas1" id="nroCajasCompradas1"
						class="form-control" 
						placeholder="Cajas"
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
						placeholder="Unidades"
						required>
						<input type="number"
						name="nroUnidadesCompradas1" id="nroUnidadesCompradas1"
						class="form-control" 
						placeholder="Unidades"
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
</body>
</html>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
