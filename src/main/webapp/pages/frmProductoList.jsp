<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
	<!--  Altera el nav..
	<link href="<%=request.getContextPath() %>/css1/bootstrap.min.css" rel="stylesheet"> -->
	
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
	<h4>ALMACEN</h4><a href="frmProducto">AGREGAR PRODUCTO</a>
<!-- 		<div class="table-responsive"> -->
			<table class="table table-striped table-hover table-bordered" id="listaProducto">
			<thead>
			
				<tr>
					<th>Categoria</th>
					<th>BarCode</th>
					<th>Producto</th>
					<th>Unid. x caja</th>
					<th>Cajas</th>
					<th>Unidades</th>
					<th>Precio x caja</th>
					<th>Precio x unidad</th>
					<th>Accion</th> 
					<th style="display:none;">Codigo</th> 
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
				<td><a href="update/<%=e.getKey().getId()%>" title="Editar datos" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
					 <a href="delete/<%=e.getKey().getId()%>"title="Eliminar" onclick="return confirm(\'Esta seguro de borrar los datos '.$row['nombres'].'?\')" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
					 
					 <a href='#' title='Cajas' class='btn btn-danger btn-sm' id='btnCajas'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span></a>
					 <a href='#' title='unidades' class='btn btn-danger btn-sm' id='btnUnidades'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span></a>
					 <a href="/precioPolitica/update/<%=e.getKey().getId()%>" title="Precios de venta" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
				</td>
				<td id="codigoProducto" style="display:none;"><%=e.getKey().getId()%></td>
			</tr>			
			<%
				}
			%>
			</tbody>
		 </table>
<!-- 		</div> -->
		
		<hr/>
		
		<div class="table-responsive">
			<form method="post" action="agregarProductoBarra" class="form-horizontal">
				<select name="barra" class="form-control" id="barra">
					<option value="">- Selecciona barra -</option>
 					<% int i = 0; 
 					List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
 					for (Entity e : barra) {		
 					%>
					<option value="<%=e.getKey().getId()%>"><%=e.getProperty("nombre")%></option>
 					<% } %>
				</select> 				
				<table class="table table-striped table-hover" id="listaProductoBarra">			
				<tr>
					<th>BarCode</th>
					<th>Producto</th>
					<th>Cajas</th>
					<th>Unidades</th>
					<th>Accion</th>
					<th style="display:none;"></th>
				</tr>

		 		</table>
					
				<div class="col-sm-4">							
					<a href="#" class="btn btn-sm btn-primary" id="btnAgregarProductoBarra">Agregar</a>
					<a href="/producto/list" class="btn btn-sm btn-danger">Cancelar</a>
				</div>						

					
		  </form>
		</div>		
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
$(document).ready(function(){
	
	$(document).on('click', '#btnCajas', function (event) {
	    event.preventDefault();
	    var barcode = $(this).parents("tr").find("td")[1].innerHTML;
        var producto = $(this).parents("tr").find("td")[2].innerHTML;
        var cajas = 1;
        var unidades = 0;
        var codigo = $(this).parents("tr").find("td")[8].innerHTML;
        var nuevaFila = "<tr><td id='tmpbarcode' name='tmpbarcode'>" + barcode +
        "<td id='tmpproducto' name='tmpproducto'>" + producto +
        				"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
        				"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
        				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>" + 
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
						"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>" + 
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
        var codigo = $(this).parents("tr").find("td")[8].innerHTML;
        var nuevaFila = "<tr><td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
        "<td id='tmpproducto' name='tmpproducto'>" + producto +
        				"</td><td id='tmpcajas' name='tmpcajas'>" + cajas + 
        				"</td><td id='tmpunidades' name='tmpunidades'>" + unidades + 
        				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>" + 
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
						"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>" + 
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
				tmpbarcode+=$(this).html() + ",";
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
					console.log("Exito");
					location.reload();						
				}
				
			});	     
     });
     
     
		$('#listaProducto').DataTable(); 
	
});






</script>
