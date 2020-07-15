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
	     	<label>TIENDA:</label>			
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
			<h4>REPORTE DE VENTAS: S/.<span id="monto"></span></h4>
			
		
				<table id="ventasreporte" class="table table-bordered table-hover dataTable" style="width: 100%">
					<thead>
						<tr>
							<th style="display:none;">ID</th>
							<th>#</th>
							<th>TIENDA</th>
							<th>USUARIO</th>
							<th>FECHA VENTA</th>
							<th>HORA VENTA</th>
							<th>TOTAL</th>
							<th>DETALLE</th>
						</tr>
					</thead>
					<tbody>

					
					</tbody>
				</table>
			</div>
		</div>
		
		
		
	<div class="modal fade" id="miModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<h5>RESUMEN DE VENTA</h5>
				</div>
				<div class="modal-body" id="impresion">


					<table>
						<thead>
							<tr>
								<td colspan="6" align="center"><span
									style="color: blue; font-weight: bold; font-size: 18px;">LAS
										ULTIMAS</span></td>
							</tr>
							<tr>
								<td colspan="6" align="center"><span
									style="color: blue; font-weight: bold; font-size: 11px;">GALERIA</span></td>
							</tr>
							<tr>

							</tr>

							<tr>
								<td><b><span style="font-size: 11px;">FECHA</span></b></td>

								<td align="right" colspan="3"><b><span
										style="font-size: 11px;">NOMBRE</span></b></td>

							</tr>

							<tr>
								<td colspan="2"><span style="color: blue; font-size: 11px;" id="fechaventa"></span>
								</td>

								<td align="right" colspan="2"><span
									style="color: blue; font-size: 11px;">POR DEFINIR</span>
								</td>
							</tr>

							<tr>
								<td width="5"><b><span style="font-size: 11px; padding: 3px;">CANT
									</span></b></td>

								<td width="150" align="left" colspan="1" ><b><span
										style="font-size: 11px; padding: 3px;">DESCRIPCION</span></b></td>

								<td width="50" align="left" colspan="1"><b><span
										style="font-size: 11px; padding: 3px;">P UNIT.</span></b></td>

								<td align="left" colspan="1"><b><span
										style="font-size: 11px; padding: 3px;">SUBTOTAL</span></b></td>
							</tr>
						</thead>
						<tbody id="detalle">


						</tbody>
						<tfoot>

							<tr>
								<td colspan="6">_____________________________________________________________</td>
							</tr>

							<tr>

								<td align="right" colspan="3"><b><span
										style="font-size: 11px; padding: 3px;">DESCUENTO S/.</span></b></td>
								<td align="left" colspan="3"><span id="descuentofinal"
									style="color: blue; font-size: 11px; padding: 3px;">0000</span></td>
							</tr>


							<tr>
								<td align="right" colspan="3"><b><span
										style="font-size: 11px; padding: 3px;">TOTAL S/.</span></b></td>
								<td align="left" colspan="3"><span id="totalfinal"
									style="color: blue; font-size: 11px; padding: 3px;">000000</span></td>
							</tr>
						</tfoot>

					</table>


				</div>
				<div class="modal-footer">
					<button type="button" id="btnConfirmar"
						class="btn btn-primary btn-sm">IMPRIMIR VENTA</button>
				</div>
			</div>
		</div>
	</div>
		
		
		
		
</body>
</html>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="<%=request.getContextPath()%>/js1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment.min.js"></script>
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
			var monto=0;
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
						monto=monto+parseFloat(response.productoVentaList[x].properties.total);
						var nuevaFila = "<tr>"
							+"<td style='display:none;'>"+response.productoVentaList[x].key.id+"</td>"
							+"<td>"+x+"</td>"
							+"<td>"+response.productoVentaList[x].properties.tienda + "</td>"
							+"<td>"+response.productoVentaList[x].properties.usuarioventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.fechaventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.horaventa + "</td>"
							+"<td>"+response.productoVentaList[x].properties.total+"</td>"
							+"<td><button type='button' id='btn-ventadetalle' title='VER DETALLE' class='btn btn-primary btn-sm'>DETALLE</a></td>"
						+"</tr>";
						$("#ventasreporte").append(nuevaFila);
					}
					$('#monto').text(monto);
				}
			});

		});


$(document).on('click',	'#btn-ventadetalle', function(event) {
	event.preventDefault();
	$("#detalle tr").remove();
	var id = $(this).closest('tr').children('td:eq(0)').text();
	var fechaventa = $(this).closest('tr').children('td:eq(4)').text();
	var subtotal=0;
	var totalfinal=0;
	$("#fechaventa").text(fechaventa);
	$.ajax({
		url : 'reporte/ventasdetalle/'+id,
		type : 'GET',
		dataType : 'JSON',
		success : function(response) {
			for (var x=0; x<response.productoVentaDetalleList.length; x++){
				var subtotal = parseFloat(response.productoVentaDetalleList[x].properties.cantidadProducto) * parseFloat(response.productoVentaDetalleList[x].properties.precioProducto)
				$("#detalle")
				.append(
						'<tr>'
								+ '<td align="left"><span id="in_nt" style="color: blue; font-size: 11px; padding: 3px;">'
								+ response.productoVentaDetalleList[x].properties.cantidadProducto
								+ '</span></td>'
								+ '<td align="left"><span style="color: blue; font-size: 11px; padding: 3px;">'
								+ response.productoVentaDetalleList[x].properties.nombreProducto
								+ '</span></td>'
								+ '<td align="left"><span id="in_pt" style="color: blue; font-size: 11px; padding: 3px;">'
								+ response.productoVentaDetalleList[x].properties.precioProducto
								+ '</span></td>'
								+ '<td align="left"><span id="in_montoTaco" style="color: blue; font-size: 11px; padding: 3px;">'
								+ subtotal
								+ '</span></td>'
								+ '</tr>');
				totalfinal=totalfinal+subtotal;
				$("#descuentofinal").text("0.00"),
				$("#totalfinal").text(totalfinal),
				$('#miModal').modal();
			}
			
		}
	});

});

$("#btnConfirmar").click(function() {
	printDiv('impresion');	
	location.reload();
});

function printDiv(divName) {
	var printContents = document.getElementById(divName).innerHTML;
	var originalContents = document.body.innerHTML;
	document.body.innerHTML = printContents;
	window.print();
	window.opener = window.parent.self;
	window.close();
}

</script>