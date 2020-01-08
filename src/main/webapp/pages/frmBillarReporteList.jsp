<!DOCTYPE html>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	 <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.print.min.js"></script>
	
<style type="text/css">
	body{
		font-size: 12px;
	}
</style>

</head>
<body>
		<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content" id="imprimir">
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
		
		</div>
	</div>
	
	<div class="col-11" style="position:absolute; top: 10%;  text-align:right;width:5000px">
	
			<button  type="button"  class="btn btn-primary" class="btn" onclick="printDiv('imprimir')"value="imprimir div" >Confirmar</button>
			<a href="/billar/list" class="btn btn-sm btn-danger">Cancelar</a></div>
</body>
</html>
	
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#billareporte').DataTable({
			 paging: false,
			 columnDefs: [{
			   targets: 'no-sort',
			   orderable: false
			 }],
			 dom: '<"row"<"col-sm-6"Bl><"col-sm-6"f>>' +
			   '<"row"<"col-sm-12"<"table-responsive"tr>>>' +
			   '<"row"<"col-sm-5"i><"col-sm-7"p>>',
			 fixedHeader: {
			   header: true
			 },
			 buttons: {
			   buttons: [{
			     extend: 'print',
			     text: '<i class="fa fa-print"></i> Print',
			     title: $('h1').text(),
			     exportOptions: {
			       columns: ':not(.no-print)'
			     },
			     footer: true,
			     autoPrint: false
			   }, {
			     extend: 'pdf',
			     text: '<i class="fa fa-file-pdf-o"></i> PDF',
			     title: $('h1').text(),
			     exportOptions: {
			       columns: ':not(.no-print)'
			     },
			     footer: true
			   }],
			   dom: {
			     container: {
			       className: 'dt-buttons'
			     },
			     button: {
			       className: 'btn btn-default'
			     }
			   }
			 }
			});
   			
   		var total = 0;
   		$('#billareporte').DataTable().rows().data().each(function(value, index){
   		  //Asumiendo que es la columna 5 de cada fila la que quieres agregar a la sumatoria
   		  total += parseFloat(value[6]);
   		$('#total').text(total.toFixed(2));
   		});
	});
	
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
