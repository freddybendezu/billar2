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
	<h1>Billar mesas</h1> Funcion : <a href="billarmesaadd">Agregar mesa</a>
		<hr/>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>Numero</th>
					<th>Descripcion</th>
					<th>Estado</th>
					<th>Acciones</th>
				</tr>	
			
			<%
				int i = 0;
				List<Entity> billarmesa = (List<Entity>) request.getAttribute("billarmesalist");
				for (Entity e : billarmesa) {					
			%>
			
			<tr>
				<td><%= i + 1 %></td>
				<td><%=e.getProperty("numero")%></td>
				<td><%=e.getProperty("descripcion")%></td>
				<td><%=e.getProperty("estado")%></td>
				<td>
					<a href="/billarprecio/update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
					<a href="/billarprecio/delete/<%=e.getKey().getId()%>"title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
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