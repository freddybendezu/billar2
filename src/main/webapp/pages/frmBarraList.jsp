<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
	<!-- Bootstrap -->
	<link href="<%=request.getContextPath() %>/css1/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css1/style_nav.css" rel="stylesheet">

	<style>
		.content {
			margin-top: 80px;
		}
	</style>
</head>      
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<jsp:include page="nav.jsp" />
	</nav>
<div class="container">
 <div class="content">
	<h1>Barras</h1> Funcion : <a href="frmBarra">Agregar barra</a>
		<hr/>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>Nombre</th>
					<th>Descripcion</th>
				</tr>	
			
			<%
				int i = 0;
				List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
				for (Entity e : barra) {					
			%>
			
			<tr>
				<td><%= i + 1 %></td>
				<td><%=e.getProperty("nombre")%></td>
				<td><%=e.getProperty("descripcion")%></td>
				<td>
					<a href="update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
					<a href="delete/<%=e.getKey().getId()%>"title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
				</td>
			</tr>			
			<%
				i++;}
			%>
		</table>
		</div>
	</div>
</div>
		
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/js1/bootstrap.min.js"></script>		
</body>
</html>