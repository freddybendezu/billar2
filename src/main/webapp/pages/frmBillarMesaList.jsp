<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
	<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<style type="text/css">
	body{
		font-size: 12px;
	}
	</style>
	<script>
	$(document).ready(function() {
   		$('#mesalist').DataTable(); 
	});
	
	</script>
</head>
      
<body>
<jsp:include page="nav.jsp" />
<div class="container">
 <div class="content">
	<h4>MESA DE BILLAR</h4><a href="billarmesaadd">AGREGAR MESA</a>
		<div class="col-sm-12">
			<table id="mesalist" class="table table-bordered table-hover dataTable">
			<thead>

				<tr>
					<th>#</th>
					<th>Numero</th>
					<th>Descripcion</th>
					<th>Estado</th>
					<th>Acciones</th>
				</tr>	
			</thead>
			<tbody>
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
					<a href="/billarprecio/update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm">PRECIO</span></a>
					<a href="/billar/delete/<%=e.getKey().getId()%>"title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm">ELIMINAR</span></a>
				</td>
			</tr>			
			<%
				i++;}
			%>
			</tbody>
		</table>
		</div>
	</div>
</div>
		
</body>
</html>