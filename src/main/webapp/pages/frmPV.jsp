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
	#listaProductoBarra{
		font-size: 11px;
	}	
</style>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
		  <div class="table-responsive">
			 <div class="col-md-5">
			 
				<table class="table table-striped table-hover table-bordered" id="listaProducto">
				<thead>
					<tr>
						<th>Stock</th>
						<th>BarCode</th>
						<th>Producto</th>
						<th>Precio</th>
						<th>Accion</th>
						<th style="display: none;"></th>
					</tr>

				</thead>
				<tbody>
					<%
						List<Entity> productoBarraList = (List<Entity>) request.getAttribute("productoBarraList");
						for (Entity e : productoBarraList) {
					%>
        		
					<tr>
					<td id="totalUnidades"><%=e.getProperty("totalUnidades")%></td>
						<td id="barCode"><%=e.getProperty("barCode")%></td>
						<td id="nombreProducto"><%=e.getProperty("nombreProducto")%></td>
						<td id="precioProducto"><%=e.getProperty("precioProducto")%></td>
						<td><a href='#' title='unidades' class='btn btn-danger btn-sm' id='btnUnidades'><i class="fa fa-plus"></i></a></td>
						
						<td id="codigoProducto" style="display: none;"><%=e.getProperty("codigoProducto")%></td>
					</tr>
				
					
					<%
						}
					%>
					</tbody>
				</table>
			  </div>
		

			 <div class="col-md-6">
				<div class="row" style="height:300px;" >	
					
						<table class="table table-striped table-hover table-bordered" id="listaProductoBarra">
						
						<tr>
							<th>Cantidad</th>
							<th>BarCode</th>
							<th>Producto</th>
							<th>Precio</th>
							<th>Subtotal</th>
							<th>Accion</th>
							<th style="display: none;"></th>
						</tr>

						</table>
					
				</div>
				<hr />
					<div class="row">		
				          <div class="col-md-4">
				             <label for="total">Total</label>
				             <input type="text" class="form-control" id="total" value="0.00">	
				          </div>
				          <div class="col-md-4">
				             <label for="tmpefectivos">Efectivo </label>
				             <input type="text" class="form-control" id="efectivo" value="0.00">	
				          </div>
				          <div class="col-md-4">
				             <label>Vuelto</label>
				             <input type="text" class="form-control" id="vuelto" value="0.00">	
				          </div>
				    </div>
				    <hr />
				    <div class="row">
					    <div class="col-md-8"></div>
						<div class="col-sm-4">
							<a href="#" class="btn btn-sm btn-primary" id="btnConfirmar">Confirmar</a>
							<a href="/caja/list" class="btn btn-sm btn-danger">Cancelar</a>
						</div>
					</div>
			</div>
		</div>

		</div>
	</div>

<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
<%-- 	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script> --%>
	
</body>
</html>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script  type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<script>
$(document).ready(function(){
	
	$('#listaProducto').DataTable(); 

    $(document).on('click','#btnUnidades', function(event) {
                event.preventDefault();
               	var barcode= $(this).parents("tr").find("td")[1].innerHTML;
                var producto = $(this).parents("tr").find("td")[2].innerHTML;
                var precio = $(this).parents("tr").find("td")[3].innerHTML; 
                var cantidad = 1;
                var codigo = $(this).parents("tr").find("td")[5].innerHTML;
                var subtotal = precio * cantidad;
                var nuevaFila = "<tr><td id='tmpcantidad' name='tmpcantidad'>" + cantidad + 
                "</td><td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
				"</td><td id='tmpproducto' name='tmpproducto'>" + producto + 
				"</td><td id='tmpprecio' name='tmpprecio'>" + precio +
				"</td><td id='tmsubtotal' name='tmsubtotal'>" + subtotal +
				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-remove'></i></a>" + 
				"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo + "</td></tr>";
                
                				var saldoUnidad = parseInt($(this).parents("tr").find("td")[0].innerHTML) - 1;
                		      	
                		        if (saldoUnidad >= 0){
                		      		$(this).parents("tr").find("td")[0].innerHTML = saldoUnidad;
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
        			$('#listaProductoBarra #tmpcantidad').each(function() {			
        				if(i==numFila){
        					unidadesTotal=$(this).html();
        				}	
        				i++;
        			});		
        		}
        		
        		
        		cantidad = parseInt(cantidad)+parseInt(unidadesTotal);
        		var subtotal = precio * cantidad;
        		var nuevaFila1 = "<td id='tmpcantidad' name='tmpcantidad'>" + cantidad + 
        		"</td><td id='tmpbarcode' name='tmpbarcode'>" + barcode + 
				"</td><td id='tmpproducto' name='tmpproducto'>" + producto + 
				"</td><td id='tmpprecio' name='tmpprecio'>" + precio +
				"</td><td id='tmsubtotal' name='tmsubtotal'>" + subtotal +
				"</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><i class='fa fa-remove'></i></a>" + 
				"</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>" + codigo + "</td>";
        	    
        	    if (encontrado == false){
        	    	$("#listaProductoBarra").append(nuevaFila);
        	    }else{
        	    	$("#listaProductoBarra").find("tr:eq(" + numFila + ")").html(nuevaFila1);
        	    }
        	    
        	    var total = $("#total").val();
        	    
                $("#total").val(parseFloat(total) + parseFloat(precio));

           });

    $(document).on('click','#btnQuitar', function(event) {
                event.preventDefault();
                
                var producto = $(this).parents("tr").find("td")[0].innerHTML;
                var cajas = $(this).parents("tr").find("td")[1].innerHTML;
                var unidades = $(this).parents("tr").find("td")[0].innerHTML;
                var codigo = $(this).parents("tr").find("td")[6].innerHTML;
                var precio = $(this).parents("tr").find("td")[3].innerHTML;
                var subtotal = $(this).parents("tr").find("td")[4].innerHTML;
                var cont = 1
                var fila = 0;
                var i = 1;
               
                var total = $("#total").val();
                
                
                $('#listaProducto #codigoProducto').each(function() {
                            if (codigo == $(this).html()) {
                                fila = cont;
                            }
                            cont++;
                        });

                $('#listaProducto #totalUnidades').each(function() {
                            if (i == fila) {
                                unidadesCompradas = parseInt($(this).html()) + parseInt(unidades);
                                
                                $(this).parents("tr").find("td")[0].innerHTML = unidadesCompradas;
                                
                                $("#total").val(parseFloat(total) - parseFloat(subtotal));
                            }
                            i++;
                        });

                $(this).closest('tr').remove();

            });

   $("#btnConfirmar").click(function() {

          var tmpCodigoProducto = "";
          var tmpBarCode = "";
          var tmpNombreProducto = "";
          var tmpPrecioProducto = "";
          var tmpCantidadProducto = "";
          var tmpTotal = 0;

          $('#listaProductoBarra #tmpcodigo').each(function() {
              tmpCodigoProducto += $(this).html() + ",";
          });
          
          $('#listaProductoBarra #tmpbarcode').each(function() {
              tmpBarCode += $(this).html() + ",";
          });

          $('#listaProductoBarra #tmpproducto').each(function() {
              tmpNombreProducto += $(this).html() + ",";
          });
          
          $('#listaProductoBarra #tmpprecio').each(function() {
        	  tmpPrecioProducto += $(this).html() + ",";
          });              

          $('#listaProductoBarra #tmpcantidad').each(function() {
        	  tmpCantidadProducto += $(this).html() + ",";
          });
          
          tmpCodigoBarra = $("#barra").val();
          tmpTienda = $("#tienda").val();
          tmpTotal = $("#total").val();
          console.log(tmpTotal);
          tmpCodigoProducto = tmpCodigoProducto.substring(0,tmpCodigoProducto.length - 1);
          tmpBarCode = tmpBarCode.substring(0,tmpBarCode.length - 1);
          tmpNombreProducto = tmpNombreProducto.substring(0,tmpNombreProducto.length - 1);
          tmpPrecioProducto = tmpPrecioProducto.substring(0,tmpPrecioProducto.length - 1);
          tmpCantidadProducto = tmpCantidadProducto.substring(0,tmpCantidadProducto.length - 1);
		  
          $.ajax({
                        url: 'registrarVenta',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            flag: '1',
                            tmpCodigoBarra: tmpCodigoBarra,
                            tmpTienda: tmpTienda,
                            tmpPrecioProducto: tmpPrecioProducto,
                            tmpCodigoProducto: tmpCodigoProducto,
                            tmpBarCode: tmpBarCode,
                            tmpNombreProducto: tmpNombreProducto,
                            tmpCantidadProducto: tmpCantidadProducto,
                            tmpTotal: tmpTotal
                        },
                        
                        success: function(res) {
                        	console.log(res[0]);
                        	if(res[0] == "exito"){
          						location.reload();
                        	}
                        }

          });
   })

})


</script>
<!-- IMPRIMIR -->

