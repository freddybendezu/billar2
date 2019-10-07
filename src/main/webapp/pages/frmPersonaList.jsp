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
	<div class="container">
		<jsp:include page="nav.jsp" />
		</div>
	</nav>
	
<div class="container">
 <div class="content">
	<h1>Personas</h1> Funcion : <a href="frmPersona">Agregar persona</a>
		<hr/>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>DNI</th>
					<th>Nombres</th>
					<th>Direccion</th>
					<th>Telefono</th>
					<th>Responsabilidad</th>
				</tr>	
			
			<%
				int i = 0;
				List<Entity> persona = (List<Entity>) request.getAttribute("personaList");
				for (Entity e : persona) {					
			%>
			
			<tr>
				<td><%= i + 1 %></td>
				<td><%=e.getKey().getId()%></td>
				<td><%=e.getProperty("nombres")%></td>
				<td><%=e.getProperty("direccion")%></td>
				<td><%=e.getProperty("telefono")%></td>
				<td><%=e.getProperty("responsabilidad")%></td>
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