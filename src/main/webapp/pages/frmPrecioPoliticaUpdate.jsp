<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	
<style>
body {
	font-size: 11px;
}
</style>

</head>
<body>
		<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h1>Precio politica</h1>

			<%
				Entity precioPolitica = (Entity) request.getAttribute("precioPolitica");
			%>

			<form method="post" action="../update" class="form-horizontal">
				<input type="hidden" name="id" id="id"
					value="<%=precioPolitica.getKey().getId()%>" />

				<div class="form-group">
					<label class="col-sm-3 control-label">Lun:</label>
					<div class="col-sm-4">
						<input type="text" name="lun" id="lun"
							value="<%=precioPolitica.getProperty("lun")%>"
							class="form-control" placeholder="Lunes" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Mar:</label>
					<div class="col-sm-4">
						<input type="text" name="mar" id="mar"
							value="<%=precioPolitica.getProperty("mar")%>"
							class="form-control" placeholder="Martes" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Mie:</label>
					<div class="col-sm-4">
						<input type="text" name="mie" id="mie"
							value="<%=precioPolitica.getProperty("mie")%>"
							class="form-control" placeholder="Miercoles" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Jue:</label>
					<div class="col-sm-4">
						<input type="text" name="jue" id="jue"
							value="<%=precioPolitica.getProperty("jue")%>"
							class="form-control" placeholder="Jueves" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Vie:</label>
					<div class="col-sm-4">
						<input type="text" name="vie" id="vie"
							value="<%=precioPolitica.getProperty("vie")%>"
							class="form-control" placeholder="Viernes" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Sab:</label>
					<div class="col-sm-4">
						<input type="text" name="sab" id="sab"
							value="<%=precioPolitica.getProperty("sab")%>"
							class="form-control" placeholder="Sabado" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Dom:</label>
					<div class="col-sm-4">
						<input type="text" name="dom" id="dom"
							value="<%=precioPolitica.getProperty("dom")%>"
							class="form-control" placeholder="Domingo" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="save" class="btn btn-sm btn-primary"	value="Guardar datos">
						<a href="/producto/list" class="btn btn-sm btn-danger">Cancelar</a>
					</div>
				</div>

			</form>
		</div>
	</div>
		
</body>
</html>