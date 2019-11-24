<!DOCTYPE html>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	
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
			<h3>Reporte: S/. <span id="total"></span></h3>
			<hr />
		
			
			
 		<div class="col-sm-12">
				<table id="billareporte"
				class="table table-bordered table-hover dataTable"
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
		<div class="col-sm-4">
			<button type="button" class="btn btn-primary" class="btn" onclick="fn_aceptar_final(")>Confirmar</button>
			<a href="/billar/list" class="btn btn-sm btn-danger">Cancelar</a>
		</div>
		</div>
	</div>
</body>
</html>