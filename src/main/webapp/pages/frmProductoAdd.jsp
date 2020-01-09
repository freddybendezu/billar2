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
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h4>PRODUCTOS</h4>
			<form class="form-horizontal" method="post" action="add">
				<div class="form-group">
					<label class="col-sm-3 control-label">Categoria:</label>
					<div class="col-sm-2">
						<input type="text" name="codigoCategoria" id="codigoCategoria" class="form-control"
							placeholder="codigoCategoria" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">BarCode</label>
					<div class="col-sm-3">
						<input type="text" name="barCode" id="barCode" class="form-control"
							placeholder="barCode" required>
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
</body>
</html>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
