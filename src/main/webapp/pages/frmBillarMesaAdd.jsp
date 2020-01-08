<html>
<head>



<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<style type="text/css">
	body{
		font-size: 12px;
	}
	</style>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h4>MESA DE BILLAR</h4>

			<form class="form-horizontal" method="post" action="add">

				<div class="form-group">
					<label class="col-sm-3 control-label">Numero:</label>
					<div class="col-sm-2">
						<input type="text" name="numero" id="numero" class="form-control"
							placeholder="numero" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Descripcion:</label>
					<div class="col-sm-3">
						<input type="text" name="descripcion" id="descripcion" class="form-control"
							placeholder="descripcion" required>
					</div>
				</div>	
				
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="add" class="btn btn-sm btn-primary" value="Guardar datos">
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