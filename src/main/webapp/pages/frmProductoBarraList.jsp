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
	<div class="form-group row">
		<div class="form-group col-md-3">
	     	<label>Tienda:</label>			
			<select name="cbobarra" class="form-control" id="cbobarra">
				<option value=""></option>
 				<%
 					List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
 					for (Entity e : barra) {		
 				%>
						<option value="<%=e.getKey().getId()%>"><%=e.getProperty("nombre")%></option>
 				<% } %>			
			</select>
	    </div>
	    <button type="button" class="btn btn-primary" id="btnbuscar">FILTRAR</button>
	    <button  type="button"  class="btn btn-success" class="btn" onclick="printDiv('imprimir')"value="imprimir div" >IMPRIMIR</button>
	</div>
	
		<div class="content" id="imprimir">
			<h4>PRODUCTOS EN TIENDA</h4>
			<a href="/producto/list">AGREGAR PRODUCTOS A LA TIENDA</a>
				
				<table id="productosbarra"  class="table table-striped table-hover table-bordered" style="width: 100%">
					<thead>
						<tr>
							<th>#</th>
							<th>Tienda</th>
							<th>BarCode</th>
							<th>Producto</th>
							<th>Cajas</th>
							<th>Unidad</th>
							<th>Total unidades</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
					
				</table>
		</div>
	</div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
		//$('#productosbarra').DataTable(); 
});

$(document).on('click',	'#btnbuscar', function(event) {
	event.preventDefault();
	var barra = $('#cbobarra').val();
	var precioXUnidad=0;
	$.ajax({
		url : 'barra/producto',
		type : 'GET',
		dataType : 'JSON',
		data : {
			codigoBarra: barra
		},
		success : function(response) {
			$("#productosbarra tbody").empty();
			for (var x=0; x<response.productoBarraList.length; x++){
				var nuevaFila = "<tr>"
					+"<td>"+x+"</td>"
					+"<td>"+response.productoBarraList[x].properties.nombreBarra+"</td>"
					+"<td>"+response.productoBarraList[x].properties.barCode+"</td>"
					+"<td>"+response.productoBarraList[x].properties.nombreProducto+"</td>"
					+"<td>"+response.productoBarraList[x].properties.cajas+"</td>"
					+"<td>"+response.productoBarraList[x].properties.unidades+"</td>"
					+"<td>"+response.productoBarraList[x].properties.totalUnidades+"</td>"
				+"</tr>";
				$("#productosbarra").append(nuevaFila);	
			}
		}
	})
	})

</script>
<script>

function printDiv(nombreDiv) {
     var contenido= document.getElementById(nombreDiv).innerHTML;
     var contenidoOriginal= document.body.innerHTML;

     document.body.innerHTML = contenido;

     window.print();

     document.body.innerHTML = contenidoOriginal;
}
</script>