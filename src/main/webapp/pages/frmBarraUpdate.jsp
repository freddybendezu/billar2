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
			Entity barra = (Entity) request.getAttribute("barra");
		%>

		<form method="post" action="../update" class="form-horizontal">
			<input type="hidden" name="id" id="id"
				value="<%=barra.getKey().getId()%>" />

			<div class="form-group">
				<label class="col-sm-3 control-label">Nombre:</label>
				<div class="col-sm-4">
					<input type="text" name="nombre" id="nombre" value="<%=barra.getProperty("nombre")%>"  class="form-control" placeholder="NIK" required>
				</div>
			</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Descripcion:</label>
					<div class="col-sm-3">
						<textarea name="descripcion" id="descripcion"
						class="form-control" placeholder="descripcion" required>
						<%=barra.getProperty("descripcion")%>
						</textarea>
					</div>
				</div>							
				<div class="form-group">
					<label class="col-sm-3 control-label">&nbsp;</label>
					<div class="col-sm-6">
						<input type="submit" name="save" class="btn btn-sm btn-primary" value="Guardar datos">
						<a href="/barra/list" class="btn btn-sm btn-danger">Cancelar</a>
					</div>
				</div>
	
		</form>
	</div>
	</div>	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>