<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
<link rel="stylesheet" type="text/css"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
<style>
body {
	font-size: 11px;
}

h1 {
	font-size: 18px;
}

#listaProducto {
	font-size: 11px;
}
</style>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<div class="row">
				<div class="col-sm-12">
					<h4>ALMACEN</h4>
					<a href="frmProducto">AGREGAR PRODUCTO</a>
					<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#miModal">Importar de excel</button>
				</div>
			</div>

			

<!-- 					<div class="table-responsive"> -->
			<div class="row">
				<div class="col-sm-12">
					<table class="table table-striped table-hover table-bordered" width="99%" id="listaProducto">
						<thead>
							<tr>
								<th>CATEGORIA</th>
								<th>BARCODE</th>
								<th>PRODUCTO</th>
								<th>UNID X CAJAS</th>
								<th>CAJAS COMP</th>
								<th>UNID COMP</th>
								<th>PREC COMP X CAJA</th>
								<th>PREC COMP X UNID</th>
								<th>PREC VENTA UNIT X MENOR</th>
								<th>PREC VENTA UNIT X MAYOR</th>
								<th>CANT PARA PREC UNIT X MAYOR</th>
								<th style="width: 155px;">ACCION</th>
								<th style="display: none;">CODIGO</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<Entity> productos = (List<Entity>) request.getAttribute("productoList");
								for (Entity e : productos) {
							%>

							<tr>
								<td id="codigoCategoria"><%=e.getProperty("codigoCategoria")%></td>
								<td id="barCode"><%=e.getProperty("barCode")%></td>
								<td id="nombreProducto"><%=e.getProperty("nombreProducto")%></td>
								<td id="unidadesXCaja"><%=e.getProperty("unidadesXCaja")%></td>
								<td id="nroCajasCompradas"><%=e.getProperty("nroCajasCompradas")%></td>
								<td id="nroUnidadesCompradas"><%=e.getProperty("nroUnidadesCompradas")%></td>
								<td id="precioXCaja"><%=e.getProperty("precioXCaja")%></td>
								<td id="precioXUnidad"><%=e.getProperty("precioXUnidad")%></td>
								<td id="precioVentaUnitxMenor"><%=e.getProperty("PrecioVentaUnitarioxMenor")%></td>
								<td id="precioVentaUnitxMayor"><%=e.getProperty("PrecioVentaUnitarioxMayor")%></td>
								<td id="cantidadParaPrecioUnitarioxMayor"><%=e.getProperty("cantidadParaPrecioUnitarioxMayor")%></td>
								
								<td><a href="update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm"><i	class='fa fa-edit'></i></a>
									<a href="delete/<%=e.getKey().getId()%>" title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm"><i class='fa fa-trash'></i></a>
									<a href='#' title='Cajas' class='btn btn-danger btn-sm' id='btnCajas'><i class='fa fa-plus'></i></a> 
									<a href='#' title='unidades' class='btn btn-danger btn-sm' id='btnUnidades'><i class='fa fa-plus'></i></a>
									<a href="/precioPolitica/update/<%=e.getKey().getId()%>" title="Precios de venta" class="btn btn-primary btn-sm"><i class='fa fa-edit'></i></a>
								</td>
								<td id="codigoProducto" style="display: none;"><%=e.getKey().getId()%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
			
				</div>
			</div>
<!-- 					</div> -->

			<hr />

			<div class="table-responsive">
				<form method="post" action="agregarProductoBarra"
					class="form-horizontal">
					<select name="barra" class="form-control" id="barra">
						<option value="">- Selecciona barra -</option>
						<%
							int i = 0;
							List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
							for (Entity e : barra) {
						%>
						<option value="<%=e.getKey().getId()%>"><%=e.getProperty("nombre")%></option>
						<%
							}
						%>
					</select>
					<table class="table table-striped table-hover"
						id="listaProductoBarra">
						<tr>
							<th>BarCode</th>
							<th>Producto</th>
							<th>Cajas</th>
							<th>Unidades</th>
							<th>Accion</th>
							<th style="display: none;"></th>
						</tr>

					</table>

					<div class="col-sm-4">
						<a href="#" class="btn btn-sm btn-primary"
							id="btnAgregarProductoBarra">Agregar</a> <a href="/producto/list"
							class="btn btn-sm btn-danger">Cancelar</a>
					</div>


				</form>
			</div>
		</div>
	</div>



	<div class="modal fade" id="miModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form class="form-horizontal" method="post" action="importar" id="frm-importar"
					enctype="multipart/form-data">
					<div class="modal-header">
						<p>CARGAR PRODUCTOS</p>
					</div>
					<div class="modal-body">
						<input type="file" name="file" id="file"> <br>
					</div>
					<div class="modal-footer">
						<button type="submit" id="btn-importar"
							class="btn btn-primary btn-sm">IMPORTAR</button>
					</div>
				</form>
			</div>
		</div>
	</div>



</body>
</html>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" language="javascript"
	src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript"
	src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>


<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>


<script>

$('#listaProducto').DataTable( {
    dom: 'Bfrtip',
    buttons: [
        'copyHtml5',
        'excelHtml5',
        'csvHtml5',
        'pdfHtml5'
    ]
} ); 

$(document).ready(function(){
	
	$(document).on('click', '#btnCajas', function (event) {
	    event.preventDefault();
	    var barcode = $(this).parents("tr").find("td")[1].innerHTML;
        var producto = $(this).parents("tr").find("td")[2].innerHTML;
        var cajas = 1;
        var unidades = 0;
        var codigo = $(this).parents("tr").find("td")[12].innerHTML;
        var nuevaFila = "<tr><td id='tmpbarcode' name='tmpbarcode'>" + barcode +
        "<td id='tmpproducto' name='tmpproducto'>" + producto +
        				"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
        				"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
        				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-trash'></i></a>" + 
        				"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo +"</td></tr>";
      	
        var saldoCaja = parseInt($(this).parents("tr").find("td")[4].innerHTML) - 1;
      	
        if (saldoCaja >= 0){
      		$(this).parents("tr").find("td")[4].innerHTML = saldoCaja;
      	}else{
      		return false;
      	}
      	
      	
		var x = 1;
		var encontrado = false;
		var cajas1 = 0;
		var repetido = "F";
		var numFila=0;
		var cajasTotal=0;
		var unidadesTotal = 0; 
		var cont = 1;
		var i = 1;
		$('#listaProductoBarra #tmpcodigo').each(function() {		
			if(codigo==$(this).html()){		
				repetido="T";
				encontrado = true;
				numFila=cont;				
			}          		
			cont++;
		});	 

		if(repetido=="T"){		
		$('#listaProductoBarra #tmpcajas').each(function() {			
			if(i==numFila){
				cajasTotal=$(this).html();
			}	
			i++;
		});		
		}
		i = 1;
		if(repetido=="T"){		
			$('#listaProductoBarra #tmpunidades').each(function() {			
				if(i==numFila){
					unidadesTotal=$(this).html();
				}	
				i++;
			});		
		}
		
		cajas = parseInt(cajas)+parseInt(cajasTotal);
		unidades = parseInt(unidades)+parseInt(unidadesTotal);
	    var nuevaFila1 = "<td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
	    "<td id='tmpproducto' name='tmpproducto'>" + producto + 
						"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
						"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
						"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-trash'></i></a>" + 
						"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo +"</td>";
	    
	    if (encontrado == false){
	    	$("#listaProductoBarra").append(nuevaFila);
	    }else{
	    	$("#listaProductoBarra").find("tr:eq(" + numFila + ")").html(nuevaFila1);
	    }
	    
	});
		

	$(document).on('click', '#btnUnidades', function (event) {
	    event.preventDefault();
	    var barcode = $(this).parents("tr").find("td")[1].innerHTML;
        var producto = $(this).parents("tr").find("td")[2].innerHTML;
        var cajas = 0;
        var unidades = 1;
        var codigo = $(this).parents("tr").find("td")[12].innerHTML;
        var nuevaFila = "<tr><td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
        				"<td id='tmpproducto' name='tmpproducto'>" + producto +
        				"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
        				"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
        				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-trash'></i></a>" + 
        				"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo +"</td></tr>";
        
        				var saldoUnidad = parseInt($(this).parents("tr").find("td")[5].innerHTML) - 1;
        		      	
        		        if (saldoUnidad >= 0){
        		      		$(this).parents("tr").find("td")[5].innerHTML = saldoUnidad;
        		      	}else{
        		      		return false;
        		      	} 				
        				
		var x = 1;
		var encontrado = false;
		var cajas1 = 0;
		var repetido = "F";
		var numFila=0;
		var cajasTotal=0;
		var unidadesTotal = 0; 
		var cont = 1;
		var i = 1;
		$('#listaProductoBarra #tmpcodigo').each(function() {		
			if(codigo==$(this).html()){		
				repetido="T";
				encontrado = true;
				numFila=cont;				
			}          		
			cont++;
		});	 

		if(repetido=="T"){		
		$('#listaProductoBarra #tmpcajas').each(function() {			
			if(i==numFila){
				cajasTotal=$(this).html();
			}	
			i++;
		});		
		}
		i = 1;
		if(repetido=="T"){		
			$('#listaProductoBarra #tmpunidades').each(function() {			
				if(i==numFila){
					unidadesTotal=$(this).html();
				}	
				i++;
			});		
		}
		
		cajas = parseInt(cajas)+parseInt(cajasTotal);
		unidades = parseInt(unidades)+parseInt(unidadesTotal);
	    var nuevaFila1 = "<td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
	    				"<td id='tmpproducto' name='tmpproducto'>" + producto +
						"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
						"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
						"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-trash'></i></a>" + 
						"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo +"</td>";
	    
	    if (encontrado == false){
	    	$("#listaProductoBarra").append(nuevaFila);
	    }else{
	    	$("#listaProductoBarra").find("tr:eq(" + numFila + ")").html(nuevaFila1);
	    }
	    
	});
	
	
	$(document).on('click', '#btnQuitar', function (event) {
	    event.preventDefault();
	    var barcode = $(this).parents("tr").find("td")[0].innerHTML;
	    var producto = $(this).parents("tr").find("td")[1].innerHTML;
	    var cajas = $(this).parents("tr").find("td")[2].innerHTML;
	    var unidades = $(this).parents("tr").find("td")[3].innerHTML;
	    var codigo = $(this).parents("tr").find("td")[5].innerHTML;
	    var cont = 1
		var fila = 0;
	    var i = 1;

	    $('#listaProducto #codigoProducto').each(function() {		
			if(codigo==$(this).html()){
				fila = cont;				
			}          		
			cont++; 
		});
	    
		$('#listaProducto #nroCajasCompradas').each(function() {			
			if(i==fila){
				console.log(cajas);
				cajasCompradas = parseInt($(this).html()) + parseInt(cajas);
				$(this).parents("tr").find("td")[3].innerHTML = cajasCompradas;
			}	
			i++;
		});	
		
		i = 1;
		
		$('#listaProducto #nroUnidadesCompradas').each(function() {			
			if(i==fila){
				unidadesCompradas = parseInt($(this).html()) + parseInt(unidades);
				$(this).parents("tr").find("td")[4].innerHTML = unidadesCompradas;
			}	
			i++;
		});	
	    
	    $(this).closest('tr').remove();	   
	    
	});
	
	
	
	
	
	
	 $("#btnAgregarProductoBarra").click(function(){
						
			var tmpCodigoProducto="";
			var tmpBarCode="";
			var tmpNombreProducto="";
			var tmpCajas="";
  			var tmpUnidades="";
			
			$('#listaProductoBarra #tmpcodigo').each(function() {
				tmpCodigoProducto+=$(this).html() + ",";          
      		});
			
			$('#listaProductoBarra #tmpbarcode').each(function() {
				tmpBarCode+=$(this).html() + ",";
     		});
			
			$('#listaProductoBarra #tmpproducto').each(function() {
				tmpNombreProducto+=$(this).html() + ",";
     		});
			
			$('#listaProductoBarra #tmpcajas').each(function() {
				tmpCajas+=$(this).html() + ",";         
      		});
			
			$('#listaProductoBarra #tmpunidades').each(function() {
				tmpUnidades+=$(this).html() + ",";
      		});
			tmpCodigoBarra = $("#barra").val();
			tmpNombreBarra = $("#barra option:selected").text();
			tmpCodigoProducto = tmpCodigoProducto.substring(0, tmpCodigoProducto.length-1);
			tmpBarCode = tmpBarCode.substring(0, tmpBarCode.length-1);
			tmpNombreProducto = tmpNombreProducto.substring(0, tmpNombreProducto.length-1);
			tmpCajas = tmpCajas.substring(0, tmpCajas.length-1);
			tmpUnidades = tmpUnidades.substring(0, tmpUnidades.length-1);

			$.ajax({
				url:'agregarProductoBarra',
				type:'POST',
				dataType:'JSON',
				data:{ 
					flag:'1',
					tmpCodigoBarra:tmpCodigoBarra,
					tmpNombreBarra:tmpNombreBarra,
					tmpCodigoProducto:tmpCodigoProducto,
					tmpBarCode:tmpBarCode,
					tmpNombreProducto:tmpNombreProducto,
					tmpCajas:tmpCajas,
					tmpUnidades:tmpUnidades
				},
				 
				success:function(response){
					
					location.reload();						
				}
				
			});	     
     });
     
	
});



$(document).on('click', '#btn-importar', function (event) {
    event.preventDefault();
	 var form = $('#frm-importar')[0];
		// Create an FormData object
     var data = new FormData(form);
	
	
		
 	$.ajax({
                type: "POST",
                url: "/producto/importar",
                data: data,
                contentType: false,
                processData: false,
                cache: false,
                /*beforeSend: function(xhr, settings) {
                    xhr.setRequestHeader("Content-Type", "multipart/form-data;boundary=gc0p4Jq0M2Yt08jU534c0p");
                    settings.data = {name: "file", file: inputElement.files[0]};                    
                },*/
                success: function (result) {                        
                    if ( result == "Exito" ) {
                    	location.reload();
                    } else {
						
                    }
                },
                error: function (result) {
                    
                }
            });

});



</script>
