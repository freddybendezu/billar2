<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
	<!-- Bootstrap -->
	<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
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
	<h4>PERSONAS</h4><a href="frmPersona">AGREGAR PERSONA</a>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>DNI</th>
					<th>Nombres</th>
					<th>Direccion</th>
					<th>Telefono</th>
					<th>Responsabilidad</th>
					<th>Accion</th>
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
					<a href="update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm">Editar</a>
					<a href="delete/<%=e.getKey().getId()%>"title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm">Eliminar</a>
				</td>
			</tr>			
			<%
				i++;}
			%>
		</table>
		</div>
	</div>
</div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>		
