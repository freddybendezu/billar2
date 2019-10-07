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
		<h1>Personas</h1>

		<%
			Entity persona = (Entity) request.getAttribute("persona");
		%>

		<form method="post" action="../update" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label">DNI</label>
				<div class="col-sm-4">
					<input type="text" name="dni" id="dni" value="<%=persona.getKey().getId()%>"  class="form-control" placeholder="dni" required readonly="readonly">
				</div>
			</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Contraseña:</label>
					<div class="col-sm-3">
						<input type="password" name="contrasena" id="contrasena"
						value="<%=persona.getProperty("contrasena")%>" class="form-control" placeholder="contrasena" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Nombres:</label>
					<div class="col-sm-3">
						<input type="text"
						name="nombres"
						id="nombres"
						value="<%=persona.getProperty("nombres")%>" class="form-control" placeholder="nombres" required>
					</div>
				</div>	
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Direccion:</label>
					<div class="col-sm-3">
						<input type="text"
						name="direccion" id="direccion"
						value="<%=persona.getProperty("direccion")%>"
						class="form-control" 
						placeholder="Teléfono"
						required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Telefono:</label>
					<div class="col-sm-3">
						<input type="text"
						name="telefono" id="telefono"
						value="<%=persona.getProperty("telefono")%>"
						class="form-control" 
						placeholder="telefono"
						required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Responsabilidad:</label>
					<div class="col-sm-3">
						<input type="text"
						name="responsabilidad" id="responsabilidad"
						value="<%=persona.getProperty("responsabilidad")%>"
						class="form-control" 
						placeholder="responsabilidad"
						required>
					</div>
				</div>
														
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="save" class="btn btn-sm btn-primary" value="Guardar datos">
						<a href="/persona/list" class="btn btn-sm btn-danger">Cancelar</a>
					</div>
				</div>
	
		</form>
	</div>
	</div>	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>