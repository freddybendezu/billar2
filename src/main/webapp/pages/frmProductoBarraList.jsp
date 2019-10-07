<!DOCTYPE html>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<link href="<%=request.getContextPath() %>/css1/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css1/dataTables.bootstrap.css" rel="stylesheet" />
	<script src="<%=request.getContextPath() %>/js1/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/js1/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath() %>/js1/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/js1/dataTables.bootstrap.js"></script>
	<script>
	$(document).ready(function() {
   		$('#productosbarra').DataTable(); 
	});
	</script>


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
			<h1>Producto/Barra</h1>
			Funcion: <a href="/producto/list">Agregar productos a la barra</a>
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
<!-- 			</div> -->
		</div>
	</div>

	<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
	<%-- 	<script src="<%=request.getContextPath() %>/js1/bootstrap.min.js"></script>		 --%>



</body>
</html>