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
	    
	    <div class="form-group col-md-3">
	     	<label>MESA:</label>			
			<select name="cbomesa" class="form-control" id="cbomesa">
				<option value=""></option>
 				<%
 					List<Entity> billarmesa = (List<Entity>) request.getAttribute("billarmesaList");
 					for (Entity e : billarmesa) {		
 				%>
						<option value="<%=e.getKey().getId()%>"><%=e.getProperty("numero")%></option>
 				<% } %>			
			</select>
	    </div>
	    <button type="button" class="btn btn-primary" id="btnbuscar">FILTRAR</button>
	  </div>	
	

		<div class="content" id="imprimir">
			<h4>
				TOTAL: S/. <span id="total"></span>
			</h4>
			<div class="col-sm-12">

				<table id="billareporte"
					class="table table-bordered table-hover dataTable"
					style="width: 100%">
					<thead>
						<tr>
							<th>#</th>
							<th>Usuario</th>
							<th>Fecha</th>
							<th>Hora inicio</th>
							<th>Mesa</th>
							<th>Estado</th>
							<th>Duracion</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>

		</div>
	</div>


</body>
</html>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"	crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
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
				var mesa = $('#cbomesa').val();
				var usuario = $('#cbousuario').val();
				var total=0;
				$.ajax({
					url : 'reporte/general',
					type : 'GET',
					dataType : 'JSON',
					data : {
						fecha: fecha,
						mesa: mesa,
						usuario: usuario
					},
					success : function(response) {
						$("#billareporte tbody").empty();
						for (var x=0; x<response.billarlist.length; x++){
							total=total+parseFloat(response.billarlist[x].properties.montototal);
							var nuevaFila = "<tr>"
								+"<td>"+x+"</td>"
								+"<td>"+response.billarlist[x].properties.usuario + "</td>"
								+"<td>"+response.billarlist[x].properties.fecha+"</td>"
								+"<td>"+response.billarlist[x].properties.horainicio+"</td>"
								+"<td>"+response.billarlist[x].properties.mesanumeroorden+"</td>"
								+"<td>"+response.billarlist[x].properties.estado+"</td>"
								+"<td>"+response.billarlist[x].properties.tiempo+"</td>"
								+"<td>"+response.billarlist[x].properties.montototal+"</td>"
							+"</tr>";
							$("#billareporte").append(nuevaFila);	
						}
						$('#total').text(total);
					}

				});

			});
</script>
