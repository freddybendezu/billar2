<!DOCTYPE html>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>

<head>
<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.standalone.min.css" rel="stylesheet"/>

<style type="text/css">
body {
	font-size: 12px;
}
</style>

</head>


<body>
	
		<jsp:include page="nav.jsp" />
	
	<div class="container">


		<div class="form-group row">
	    <div class="form-group col-md-3">
			<label>FECHA:</label>
			<div class="input-group date">
				<div class="input-group-addon">
					<i class="fa fa-calendar"></i>
				</div>
				<input type="text" class="form-control pull-right" id="txtfecha">
			</div>
	    </div>
	    
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
	      
	    <div class="form-group col-md-3">
	      	<label>USUARIO:</label>		
			<select name="cbousuario" class="form-control" id="cbousuario">
				<option value=""></option>
	 				<% 
	 					List<Entity> usuario = (List<Entity>) request.getAttribute("personaList");
	 					for (Entity e : usuario) {		
	 				%>
							<option value="<%=e.getKey().getId()%>"><%=e.getProperty("nombres")%></option>
	 				<% } %>
			</select>
	    </div>
	    <button type="button" class="btn btn-primary" id="btnbuscar">FILTRAR</button>
	  </div>

		<div class="content" id="imprimir">
			<h4>REPORTE DE VENTAS</h4>
		
				<table id="ventasreporte" class="table table-bordered table-hover dataTable" style="width: 100%">
					<thead>
						<tr>
							<th>#</th>
							<th>Codigo de Barra</th>
							<th>Usuario</th>
							<th>Fecha de Venta</th>
							<th>Hora de Venta</th>
							<th>Total</th>
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
	$('#txtfecha').datepicker({
	    format: 'yyyy-mm-dd',
	    autoclose: true,
	    todayHighlight: true,
	   	locale:'es'
	}).datepicker("setDate", new Date());
});

$(document).on('click',	'#btnbuscar', function(event) {
			event.preventDefault();
			var fecha = $('#txtfecha').val();
			var barra = $('#cbobarra').val();
			var usuario = $('#cbousuario').val();
			var total=0;
			$.ajax({
				url : 'reporte/ventas',
				type : 'GET',
				dataType : 'JSON',
				data : {
					fecha: fecha,
					barra: barra,
					usuario: usuario
				},
				success : function(response) {
					$("#ventasreporte tbody").empty();
					for (var x=0; x<response.productoVentaList.length; x++){
						total=total+parseFloat(response.productoVentaList[x].properties.montototal);
						var nuevaFila = "<tr>"
							+"<td>"+x+"</td>"
							+"<td>"+response.productoVentaList[x].properties.codigoBarra + "</td>"
							+"<td>"+response.productoVentaList[x].properties.usuarioventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.fechaventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.horaventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.total+"</td>"
						+"</tr>";
						$("#ventasreporte").append(nuevaFila);	
					}
				}
			});

		});
		
</script>