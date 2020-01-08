<!DOCTYPE html>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
 	<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
<style>
	body{
		font-size: 11px;
	}
	h1{
		font-size: 18px;
	}
	#listaProducto{
		font-size: 11px;
	}
</style>

</head>
<body>
<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h4>PRODUCTOS EN TIENDA</h4>
			<a href="/producto/list">AGREGAR PRODUCTOS A LA TIENDA</a>
			<hr />
<!-- 			<div class="table-responsive"> -->
				<table id="productosbarra"
					class="table table-striped table-hover table-bordered"
					style="width: 100%">
					<thead>

						<tr>
							<th>#</th>
							<th>Barra</th>
							<th>Producto</th>
							<th>Cajas</th>
							<th>Unidad</th>
							<th>Total unidades</th>
							<th>Accion</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 0;
							List<Entity> productoBarra = (List<Entity>) request.getAttribute("productoBarraList");
							for (Entity e : productoBarra) {
						%>


						<tr>
							<td><%=i + 1%></td>
							<td><%=e.getProperty("nombreBarra")%></td>
							<td><%=e.getProperty("nombreProducto")%></td>
							<td><%=e.getProperty("cajas")%></td>
							<td><%=e.getProperty("unidades")%></td>
							<td><%=e.getProperty("totalUnidades")%></td>
							<td><a href="update/<%=e.getKey().getId()%>"
								title="Editar datos" class="btn btn-primary btn-sm"><span
									class="glyphicon glyphicon-edit" aria-hidden="true"></span></a> <a
								href="delete/<%=e.getKey().getId()%>" title="Eliminar"
								onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')"
								class="btn btn-danger btn-sm"><span
									class="glyphicon glyphicon-trash" aria-hidden="true"></span></a></td>
						</tr>


						<%
							i++;
							}
						%>
					</tbody>
				</table>
		</div>
	</div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script>
	$(document).ready(function() {
   		$('#productosbarra').DataTable(); 
	});
	</script>