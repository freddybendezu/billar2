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
   		$('#billareporte').DataTable(); 
   		
   		var total = 0;
   		$('#billareporte').DataTable().rows().data().each(function(value, index){
   		  //Asumiendo que es la columna 5 de cada fila la que quieres agregar a la sumatoria
   		  total += parseFloat(value[6]);
   		$('#total').text(total.toFixed(2));
   		});
   		
   		
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
			<h1>Reporte: S/. <span id="total"></span></h1>
			<hr />
<!-- 			<div class="table-responsive"> -->
				<table id="billareporte"
					class="table table-striped table-hover table-bordered"
					style="width: 100%">
					<thead>

						<tr>
							<th>#</th>
							<th>Usuario</th>
							<th>Fecha</th>
							<th>Mesa</th>
							<th>Estado</th>
							<th>Duracion</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 0;
							List<Entity> billarlist = (List<Entity>) request.getAttribute("billarlist");
							for (Entity e : billarlist) {
						%>


						<tr>
							<td><%=i + 1%></td>
							<td><%=e.getProperty("usuario")%></td>
							<td><%=e.getProperty("inicio")%></td>
							<td><%=e.getProperty("mesanumeroorden")%></td>
							<td><%=e.getProperty("estado")%></td>
							<td><%=e.getProperty("tiempo")%></td>
							<td><%=e.getProperty("montototal")%></td>
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