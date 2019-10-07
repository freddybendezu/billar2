<%@page import="java.util.ArrayList"%> 
<%@page import="pe.com.suriados.bean.*"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%
         String usuario= (String)request.getAttribute("usuario");
         String clave= (String)request.getAttribute("clave");        
         String idRol= (String)request.getAttribute("idRol");
         String codusuario= (String)request.getAttribute("codusuario");
         String nombreCompleto= (String)request.getAttribute("nombreCompleto");
         String idBarra=(String)request.getAttribute("idBarra");
         %>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="">
      <meta name="author" content="">
      <title>Suria</title>
      <!-- Bootstrap Core CSS -->
      <link href="<%=request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">
      <!-- MetisMenu CSS -->
      <link href="<%=request.getContextPath() %>/css/metisMenu.min.css" rel="stylesheet">
      <!-- Custom CSS -->
      <link href="<%=request.getContextPath() %>/css/sb-admin-2.css" rel="stylesheet">
      <!-- Morris Charts CSS -->
      <link href="<%=request.getContextPath() %>/css/morris.css" rel="stylesheet">
      <!-- Custom Fonts -->
      <link href="<%=request.getContextPath() %>/css/font-awesome.min.css" rel="stylesheet" type="text/css">
      <link rel="stylesheet" href="<%=request.getContextPath() %>/css/calendarStyle.css">

   </head>
   <style>
      a:hover{
      background: #e7e7e7;
      color:#23527c;
      }
      thead{
          font-weight: bold;
      }
   </style>
   <body>
   <div class="container-full">
      <div id="wrapper">
      <!-- Navigation -->
      <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0;background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%); ">
         <div class="navbar-header">LOGO</div>
         <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown"><%=nombreCompleto%></li>
            <li>
                  	<a  href="<%=request.getContextPath() %>/sProducto?flag=1&idRol=<%=idRol%>&codusuario=<%=codusuario%>&nombreCompleto=<%=nombreCompleto%>&idBarra=<%=idBarra%>&&usuario=<%=usuario%>&&clave=<%=clave%>" style="font-weight:bold;" ><i class="fa fa-dashboard fa-fw"></i>Inicio</a>
                  </li>
                  <%--                           <%if(idRol.equals("1")){ %> --%>
                  <li>
                     <a id="men1" href="#"  onclick="fn_Barra()" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw" ></i>Productos en Barra</a>
                  </li>
                  <li>
                     <a  href="#"  id="btnCategoria"  data-toggle="modal" data-target="#myModalCategoria" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw"></i>Categoria de Productos</a>
                  </li>
                  <li>
                     <a href="#"  id="btnAlmacen" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw"></i>Almacen de productos</a>
                  </li>
                  <li>
                     <a href="#"  id="btnAsignarEmpBarra"  data-toggle="modal" data-target="#myModalEmpBarra" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw"></i>Asignacion de Barras</a>
                  </li>
                  <%--                         <%}%> --%>
                  <li>
                     <a href="#" data-toggle="modal" data-target="#myModalReporte1" id="btn_reporte1" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw"></i>Reporte de Stock de barras</a>
                  </li>
                  <!--      <li>
                     <a href="#" data-toggle="modal" data-target="#myModalReporte2" id="btn_reporte2" style="font-weight:bold;">REPORTE DE STOCK GENERAL</a>
                     </li> -->
                  <%--                                   <%if(idRol.equals("1")){ %> --%>
                  <li>
                     <a href="#" data-toggle="modal" data-target="#myModalReporteBarra" id="btn_reporteGananciaBarra" style="font-weight:bold;"><i class="fa fa-dashboard fa-fw"></i>Reporte de Ganancias</a>
                  </li>
                  <%--                          <%} %> --%>
            
            <li class="dropdown">
            	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
            		<i class="fa fa-user fa-fw"></i>
            		<i class="fa fa-caret-down"></i>
               	</a>
               	<ul class="dropdown-menu dropdown-user">
                  <li>
                  	<a href="<%=request.getContextPath() %>/sInterPagina?flag=2&idRol=<%=idRol%>&codusuario=<%=codusuario%>&nombreCompleto=<%=nombreCompleto%>&idBarra=<%=idBarra%>&&usuario=<%=usuario%>&&clave=<%=clave%>">
                  		<i class="fa fa-gear fa-fw"></i>
                  		Ir Billar
                  	</a>
                  </li>
                  <li class="divider"></li>
                  <li>
                  	<a href="<%=request.getContextPath() %>/jsp/login.jsp">
                  		<i class="fa fa-sign-out fa-fw"></i> 
                  		Cerrar Sesion
                  	</a>
                  </li>
               </ul>
            </li>
         </ul>

         <input type="hidden" id="idBarra" value="<%=idBarra %>">
         <input type="hidden" id="codusuario" value="<%=codusuario %>">
         <input type="hidden" id="usuario" value="<%=usuario %>">
         <input type="hidden" id="clave" value="<%=clave %>">
      	</nav>
      </div>
      <div id="wrapper" >
      	<div class="row"><div class="col-xs-12 col-md-8"><br/><br/><br/></div></div>
        <div class="row">
        	<div class="col-md-1"></div>
        	<div class="col-md-6">
            	<table id="mitablaProducto" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline">
            	   <thead>
     				 <tr>
                        <td>Producto</td>
                        <td>Cantidad</td>
                        <td>Precio</td>
                        <td>Subtotal</td>
                        <td>Accion</td>
                        <td style="visibility:hidden;">Codigoooooooo</td>
                     </tr>
                   </thead>

                 </table>

             </div>
             <div class="col-md-5">
             	<div class="row">		
        			<div class="col-lg-3"><label for="usr">Buscar Producto:</label></div>
        			<div class="col-lg-5"><input type="text" class="form-control" id="inputNombre"></div>
        			<div id="divCargar"></div>	
        		</div>
        		<div class="row">
        			<div class="col-lg-5" id="moduloProducto"></div>
        		</div>
        	</div>
      </div>
       <div class="row">
       	<div class="col-md-1"></div>
          <div class="col-md-1">
             <label for="totalboleta">Total</label>
             <input type="text" class="form-control" id="totalboleta" value="0.00">	
          </div>
          <div class="col-md-1">
             <label for="tmpefectivos">Efectivo </label>
             <input type="text" class="form-control" id="tmpefectivos" value="0.00">	
          </div>
          <div class="col-md-1">
             <label>Vuelto</label>
             <input type="text" class="form-control" id="vuelto" value="0.00">	
          </div>
       </div>
       <br/>
       <div class="row">
       	<div class="col-md-1"></div>
        <div class="col-md-1"><button class="btn btn-info btn-fi	ll btn-wd" id="btnRegistrarTienda">Terminar venta</button></div>
        <div class="col-md-1"><button class="btn btn-info btn-fi	ll btn-wd" id="btnRegistrarCancelar">Cancelar venta</button></div>
        <div class="col-md-1"><button class="btn btn-info btn-fi	ll btn-wd" id="btnRegistrarImprimir">Imprimir venta</button></div>
       </div>
	</div>
	
	
	
	
	

      <div id="divIdTiendaBoleta">
         <h1></h1>
      </div>
      <div class="modal fade" id="myModalEmpBarra" role="dialog">
         <div class="modal-dialog  modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
               <div class="modal-header" style="background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%);">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title" style="color:white;font-size: 20px;
                     font-weight: bold;">Asignacion de barras</h4>
               </div>
               <div class="modal-body-EmpBarraF">
               </div>
            </div>
         </div>
      </div>
      <!-- Modal cantidad -->
      <div class="modal fade" id="myModalcantidad" role="dialog">
         <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title">Modal Header</h4>
               </div>
               <div class="modal-body-cantidad">
               </div>
            </div>
         </div>
      </div>
      <!-- fin Modal cantidad -->
      <!-- Modal -->
      <div class="modal fade" id="myModalBarra" role="dialog">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header" style="color:#fff;background:#337ab7;font-weight:bold;">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title" style="font-weight:bold;">Productos en Barra</h4>
               </div>
               <div class="modal-body-barra">
               </div>
            </div>
         </div>
      </div>
      <!--Fin Modal -->
      <!-- Modal -->
      <div class="modal fade" id="myModalAlmacen" role="dialog">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title">XXX</h4>
               </div>
               <div class="modal-body-Almacen">
                  Datos del almacen  almacen.html
               </div>
               <div class="modal-footer-Almacen">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <!--Fin Modal -->
      <!-- Modal -->
      <div class="modal fade" id="myModalCategoria" role="dialog">
         <div class="modal-dialog modal-lg" style="width: 68%;">
            <div class="modal-content">
               <div class="modal-header" style="background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%);color:#fff;font-weight:bold;">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title" style="font-weight:bold;">Categoria de Productos</h4>
               </div>
               <div class="modal-body-Categoria">
               </div>
            </div>
         </div>
      </div>
      <!--Fin Modal -->
      <!-- Modal Reporte -->
      <div class="modal fade" id="myModalReporte1" role="dialog">
         <div class="modal-dialog modal-lg" style="width: 68%;">
            <div class="modal-content">
               <div class="modal-header" style="background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%);color:#fff;font-weight:bold;">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title" style="font-weight: bold;">Reporte de ventas</h4>
               </div>
               <div class="modal-body-reporte1">
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Salir</button>
               </div>
            </div>
         </div>
      </div>
      <!-- fin Modal Reporte -->
      <!-- Modal Reporte -->
      <div class="modal fade" id="myModalReporteBarra" role="dialog">
         <div class="modal-dialog modal-lg" style="width: 68%;">
            <div class="modal-content">
               <div class="modal-header" style="background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%);color:#fff;font-weight:bold;">
                  <button type="button" class="close" data-dismiss="modal" style="background: red;color: #f7f1f1;width: 3%;border-radius: 2px;">&times;</button>
                  <h4 class="modal-title" style="font-weight:bold;">Reporte de ganancias</h4>
               </div>
               <div class="modal-body-ReporteGananciaBarra">
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Salir</button>
               </div>
            </div>
         </div>
      </div>
      <!-- fin Modal Reporte -->
      <!-- Modal Re´prte -->
      <div class="modal fade" id="myModalReporte2" role="dialog">
         <div class="modal-dialog modal-lg" style="width: 68%;">
            <div class="modal-content">
               <div class="modal-header" style="background: linear-gradient(to bottom, #286090 0%,#3977ad 39%,#286090 100%,#286090 100%,#286090 100%,#286090 100%);color:#fff;font-weight:bold;">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" style="font-weight:bold;">Reporte de ganacias</h4>
               </div>
               <div class="modal-body-reporte2">
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Salir</button>
               </div>
            </div>
         </div>
      </div>
  </div>    
      
      <!-- fin Modal Reporte -->
      <!-- jQuery -->
      <script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
      <!-- Bootstrap Core JavaScript -->
      <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
      <!-- Metis Menu Plugin JavaScript -->
      <script src="<%=request.getContextPath() %>/js/metisMenu.min.js"></script>
      <!-- Morris Charts JavaScript 
         <script src="<=request.getContextPath() %>/js/raphael.min.js"></script>
         <script src="<=request.getContextPath() %>/js/morris.min.js"></script>
         <script src="<=request.getContextPath() %>/js/morris-data.js"></script>
         -->
      <!-- Custom Theme JavaScript -->
      <!--<script src="<=request.getContextPath() %>/js/sb-admin-2.js"></script>
         <script src="<=request.getContextPath() %>/js/jquery-1.12.4.js"></script>-->
      <script src="<%=request.getContextPath() %>/js/jquery-ui.js"></script>
      <!-- 
         <script src="<=request.getContextPath() %>/js/jquery.maskMoney.js"></script>
          -->
      <script type="text/javascript">
  	
  	$("#togg").click(function(){
  	    $("#subRepor").toggle();
  	});
  	
  	$(function(){ 
  		 	
  		
  		var idBarra=$("#idBarra").val();
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sProducto',
  			type:'GET',
  			data:{ 
  				flag:'4',
  				bandera:'4',
  				idBarra:idBarra,
  				ruta:"/jsp/productos.jsp"
  				 },
  			 
  			success:function(html){	
  						
  				 $("#moduloProducto").html(html);
  				
  				}
  			});
  		
   		$("#btnRegistrarImprimir").click(function(){
  			 
   			var total=$("#totalboleta").val();
  			var efectivo=$("#tmpefectivos").val();
  			var vuelto=$("#vuelto").val();
       	
  		
  			
  			
  			total=total.replace("S/.", "");
  			efectivo=efectivo.replace("S/.", "");
  			vuelto=vuelto.replace("S/.", "");
  			
  			
  			var tmpid="";
  			var tmpCodigo="";
  			var tmpCantidad="";
  			var tmpTotalProducto="";
       		var tmpPrecioUnitario="";
  			var tmpNombre="";
  					
  			
  			$('#mitablaProducto .tmpid').each(function() {
  				tmpid+=$(this).html() + ",";
                  
              });	
  			$('#mitablaProducto .tmpcodigo').each(function() {
  				tmpCodigo+=$(this).html() + ",";
               
           });
  			$('#mitablaProducto .tmpdescripcion').each(function() {
  				tmpNombre+=$(this).html() + ",";
               
           });
  			$('#mitablaProducto .tmpcantidad ').each(function() {
  				tmpCantidad+=$(this).html() + ",";
               
           });
  			$('#mitablaProducto .tmpprecio').each(function() {
  				tmpPrecioUnitario+=$(this).html() + ",";
               
           });
  			$('#mitablaProducto .tmpsubtotal').each(function() {
  				tmpTotalProducto+=$(this).html() + ",";
               
           });
       
  			tmpid=tmpid.substring(0,tmpid.length-1);
  			tmpCodigo=tmpCodigo.substring(0,tmpCodigo.length-1);
  			tmpNombre=tmpNombre.substring(0,tmpNombre.length-1);
  			tmpCantidad=tmpCantidad.substring(0,tmpCantidad.length-1);
  			tmpPrecioUnitario=tmpPrecioUnitario.substring(0,tmpPrecioUnitario.length-1);
  			tmpTotalProducto=tmpTotalProducto.substring(0,tmpTotalProducto.length-1);
  			
  			idBarra=$("#idBarra").val();
  			
  			
  			$.ajax({
  				url:'<%=application.getContextPath()%>/sComprobante',
  				type:'POST',
  				dataType:'JSON',
  				data:{ 
  					flag:'1',
  					idBarra:idBarra,
  					tmpid:tmpid,
  					tmpCodigo:tmpCodigo,
  					tmpCantidad:tmpCantidad,
  					tmpTotalProducto:tmpTotalProducto,
  					tmpNombre:tmpNombre,
  					tmpPrecioUnitario:tmpPrecioUnitario,
  					total:total,
  					efectivo:efectivo,
  					vuelto:vuelto
  					 },
  				 
  				success:function(response){	
  					
  					if(response.flagE<0){
  						
  					//	alert("el producto "+response.productoE + " no cuenta con stock");
  						
  						
  					}else{
  						
  						imprimir(response.listProductosTodos,response.total,response.efectivo,response.vuelto);
  						
  						location.reload();
  						
  					}
  					
  					
  					
  					
  					
  					
  				}
  			});
  			
  			
  			 
  		 });
  		
  		
  		 $("#btnRegistrarCancelar").click(function(){
  			 
  			 location.reload();
  			 
  		 });
  		 
  		
  		 $("#btnRegistrarTienda").click(function(){

  			 
  	 			var total=$("#totalboleta").val();
  				var efectivo=$("#tmpefectivos").val();
  				var vuelto=$("#vuelto").val();
  	     	
  			
  				
  				
  				total=total.replace("S/.", "");
  				efectivo=efectivo.replace("S/.", "");
  				vuelto=vuelto.replace("S/.", "");
  				
  				
  				var tmpid="";
  				var tmpCodigo="";
  				var tmpCantidad="";
  				var tmpTotalProducto="";
  	     		var tmpPrecioUnitario="";
  				var tmpNombre="";
  						
  				
  				$('#mitablaProducto .tmpid').each(function() {
  					tmpid+=$(this).html() + ",";
  	                
  	            });	
  				$('#mitablaProducto .tmpcodigo').each(function() {
  					tmpCodigo+=$(this).html() + ",";
  	             
  	         });
  				$('#mitablaProducto .tmpdescripcion').each(function() {
  					tmpNombre+=$(this).html() + ",";
  	             
  	         });
  				$('#mitablaProducto .tmpcantidad ').each(function() {
  					tmpCantidad+=$(this).html() + ",";
  	             
  	         });
  				$('#mitablaProducto .tmpprecio').each(function() {
  					tmpPrecioUnitario+=$(this).html() + ",";
  	             
  	         });
  				$('#mitablaProducto .tmpsubtotal').each(function() {
  					tmpTotalProducto+=$(this).html() + ",";
  	             
  	         });
  	     
  				tmpid=tmpid.substring(0,tmpid.length-1);
  				tmpCodigo=tmpCodigo.substring(0,tmpCodigo.length-1);
  				tmpNombre=tmpNombre.substring(0,tmpNombre.length-1);
  				tmpCantidad=tmpCantidad.substring(0,tmpCantidad.length-1);
  				tmpPrecioUnitario=tmpPrecioUnitario.substring(0,tmpPrecioUnitario.length-1);
  				tmpTotalProducto=tmpTotalProducto.substring(0,tmpTotalProducto.length-1);
  				
  				idBarra=$("#idBarra").val();
  				
  				
  				$.ajax({
  					url:'<%=application.getContextPath()%>/sComprobante',
  					type:'POST',
  					dataType:'JSON',
  					data:{ 
  						flag:'1',
  						idBarra:idBarra,
  						tmpid:tmpid,
  						tmpCodigo:tmpCodigo,
  						tmpCantidad:tmpCantidad,
  						tmpTotalProducto:tmpTotalProducto,
  						tmpNombre:tmpNombre,
  						tmpPrecioUnitario:tmpPrecioUnitario,
  						total:total,
  						efectivo:efectivo,
  						vuelto:vuelto
  						 },
  					 
  					success:function(response){	
  						
  						if(response.flagE<0){
  							
  						//	alert("el producto "+response.productoE + " no cuenta con stock");
  							
  							
  						}else{
  							
  							
  							location.reload();
  							
  						}
  						
  						
  						
  						
  						
  						
  					}
  				});
  				
  				
  				
  				
           
           });

  	     function imprimir(listado,total,efectivo,vuelto){
           	
         	   
         	   
         	   
         	   var content = document.getElementById("divIdTiendaBoleta").innerHTML;       	    
         	  var mywindow = window.open('', 'Print', 'height=600,width=800');
         	 
         	  var contenidoDetalle="";
         	  
         	var	contenido="<div style='margin-left:25%;'><span style='margin-left:7%;'> SURIA JUEGOS </span><br/>"+
    			"<span style='margin-left:7%;'>SALON DE JUEGOS</span><br/>"+
    			"<span>BOLETA DE VENTA ELECTRONICA</span><br/><br/>"+
    			"<span>--------------------------------------------</span><br/>"+
    			"<span>DESCRIPCION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbspIMPORTE</span><br/>"+
    			"<span>--------------------------------------------</span><br/>";
    			
    			for ( var a = 0; a < listado.length ; a++) {
    				contenidoDetalle=contenidoDetalle+"<span>"+listado[a].nombre+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+listado[a].precioVenta+"</span><br/>";	
    				
    			}  			
    			contenido=contenido+contenidoDetalle+"<br/>"+
    			"<span>--------------------------------------------</span><br/>"+
    			"<span>Total:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S./"+total+"</span>"+"<br/>"+
    			"<span>--------------------------------------------</span><br/>"+
    			"<span>Efectivo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S./"+efectivo+"</span><br/>"+
    			"<span>--------------------------------------------</span><br/>"+
    			"<span>Vuelto:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S./"+vuelto+"</span>"+"</div>";
    		
    			
    			
    			
    			
         	//for ( var a = 0; a < listado.length; a++) {
  				
  		//	"<span>"+listado.ProductosBean[a].nombre +"           "+ listado.ProductosBean[a].precioVenta+"<span>";
  			
  			/*$("#"+response.auxAlquiler[a].id_mesa_billar).val(response.auxAlquiler[a].hora_inicio);
  				*/
  				
  			
    			

    		  //  mywindow.document.write("<p>hola</p>");
    		   
    		  //   mywindow.document.write('<html><head><title>Print</title>');
    		 //   mywindow.document.write('</head><body>');
    		  
    		  mywindow.document.write(contenido);
  		   
    		  /*  mywindow.document.write('<span>HORA DE INICIO : '+tInicio+'</span><br/>');
    		    mywindow.document.write('<span>HORA DE FINAL : '+tFinal+'</span><br/>');
    		    mywindow.document.write('<span>TIEMPO TRANSCURRIDO : '+transcurrido+'</span><br/>');
    		    mywindow.document.write('<span>TACO EXTRA : '+tExtra+'</span><br/>');
    		    mywindow.document.write('<span>PRECIO TOTAL : '+precioTotal+' </span>');
    		    */
    		   // mywindow.document.write('</body></html>');
    		   
    		    mywindow.document.close();
    		    mywindow.focus();
    		    mywindow.print();
    		    mywindow.close();
          	   
            }
            
            
  	/*
  	$.ajax({
  		url:'<=application.getContextPath()%>/sProducto',
  		type:'GET',
  		data:{ 
  			flag:'4',
  			bandera:'4',
  			ruta:"/jsp/Tienda/productos.jsp"
  			 },
  		 
  		success:function(html){	
  					
  			 $("#moduloProducto").html(html);
  			
  			}
  		});

  	 $('#tmpefectivos').maskMoney();
  		 */ 
  	});
  	
  	
  	$("#tmpefectivos").keydown(function(){
  		
  		var total=$('#totalboleta').val();
  		var efectivo=$('#tmpefectivos').val();
  		var vuelto=""; 
  		
  		
  		if(efectivo=="" || efectivo ==null ){
  						
  		//	$('#tmpefectivos').val("0.00").trim();
  			$('#vuelto').val("0.00").trim();
  			
  			
  			
  		}else{
  			total=total.replace("S/.", "");
  			efectivo=efectivo.replace("S/.", "");
  			
  			
  			vuelto=parseFloat(efectivo)-parseFloat(total);
  			
  			if(isNaN(vuelto) ){
  				console.log(vuelto);
  				vuelto="0.00";
  				$("#vuelto").val(vuelto);
  			}else{
  				$("#vuelto").val(vuelto.toFixed(2));
  			}
  			
  		
  		
  		}
  		
  		
  		
  	
  		
  	
  	
  		
  		
  	});
  	
  	$("#tmpefectivos").keyup(function(){	
  		var total=$('#totalboleta').val();
  		var efectivo=$('#tmpefectivos').val();
  		var vuelto=""; 
  		
  		if(efectivo=="" || efectivo ==null ){
  			
  			//$('#tmpefectivos').val("0.00");
  			$('#vuelto').val("0.00");
  			
  			
  			
  		}else{
  			total=total.replace("S/.", "").trim();
  			efectivo=efectivo.replace("S/.", "").trim();	
  			
  			
  			vuelto=parseFloat(efectivo)-parseFloat(total);
  			
  			if(isNaN(vuelto) ){
  				console.log(vuelto);
  				vuelto="0.00";
  				$("#vuelto").val(vuelto);
  			}else{
  				$("#vuelto").val(vuelto.toFixed(2));
  			}
  		
  		
  		}
  		
  		
  	});
  		
  	
  	
  	$("#btnAsignarEmpBarra").click(function(){
  	
  		
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sInterPagina',
  			type:'GET',
  			data:{ 
  				flag:'7',
  				ruta:"/jsp/asignacionBarra.jsp"
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-EmpBarraF").html(html);
  				
  				 $("#btnAsignarEmpBarra").css({"background-color": "#eee", "color": "#286090"});
  				 $("#men1").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAlmacen").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnCategoria").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporteGananciaBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporte1").css({"background-color": "#23527c;", "color": "#fff"});
  				 
  				 
  				}
  			});
  		
  	});	
  		
  	$("#btnAlmacen").click(function(){
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sInterPagina',
  			type:'GET',
  			data:{ 
  				flag:'7',
  				ruta:"/jsp/Tienda/ManteniminetoAlmacen/principal.jsp"
  				 },
  			success:function(html){	
  						
  				 $("#page-wrapper").html(html);
  				
  				 $("#btnAlmacen").css({"background-color": "#eee", "color": "#286090"});
  				 $("#men1").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAsignarEmpBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnCategoria").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporteGananciaBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporte1").css({"background-color": "#23527c;", "color": "#fff"});
  				}
  			});
  		
  	});
  	
  	
  	
  	$("#btnLimpiarCategoria").click(function(){
  		
  		$("#txt_nombre").val("");
  		$("#txt_descripcion").val("");
  		
  		
  		
  		
  		
  	});

  	
  	$("#btn_reporte1").click(function(){
  	
  		var codusuario=	$("#codusuario").val();
  		var idBarra=	$("#idBarra").val();
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sBarra',
  			type:'GET',
  			data:{ 
  				flag:'2',
  				codusuario:codusuario,
  				idBarra:idBarra,
  				ruta:'/jsp/Tienda/Reporte/reporte1.jsp'
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-reporte1").html(html);
  			
  				 $("#btn_reporte1").css({"background-color": "#eee", "color": "#286090"});
  				 $("#men1").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAsignarEmpBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnCategoria").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAlmacen").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporteGananciaBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 
  				}
  			});
  	});
  	
  	
  	
  	$("#btn_reporteGananciaBarra").click(function(){
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sBarra',
  			type:'GET',
  			data:{ 
  				flag:'2',
  				ruta:'/jsp/Tienda/Reporte/reporte2.jsp'
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-ReporteGananciaBarra").html(html);
  				
  				 $("#btn_reporteGananciaBarra").css({"background-color": "#eee", "color": "#286090"});
  				 $("#men1").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAsignarEmpBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnCategoria").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAlmacen").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporte1").css({"background-color": "#23527c;", "color": "#fff"});
  				 
  				}
  			});
  	});
  	
  	
  	$("#btn_reporte2").click(function(){
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sBarra',
  			type:'GET',
  			data:{ 
  				flag:'2',
  				ruta:'/jsp/Tienda/Reporte/reporte3.jsp'
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-reporte2").html(html);
  				
  				}
  			});
  		
  	});
  	
  	
  	
  	$("#btnCategoria").click(function(){
  	    
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sInterPagina',
  			type:'GET',
  			data:{ 
  				flag:'5',
  				ruta:'/jsp/Tienda/MantenimientoCategoria/principal.jsp'
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-Categoria").html(html);
  				 $("#btnCategoria").css({"background-color": "#eee", "color": "#286090"});
  				 $("#men1").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAlmacen").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btnAsignarEmpBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporteGananciaBarra").css({"background-color": "#23527c;", "color": "#fff"});
  				 $("#btn_reporte1").css({"background-color": "#23527c;", "color": "#fff"});
  			}
  			});
  		
  		
  	});
  	
  	
  	
  	 $("#inputNombre").keydown(function(){
  	      
  		 var nombreProducto= $("#inputNombre").val();
  		 var idBarra=$("#idBarra").val();
  		 
  			$.ajax({
  				url:'<%=application.getContextPath()%>/sProducto',
  				type:'GET',
  				data:{ 
  					flag:'1',
  					nombreProducto:nombreProducto,
  					idBarra:idBarra
  					 },
  				 cache:false,
  				 beforeSend:function(){
  					$("#divCargar").empty().html('<img src="<%=application.getContextPath()%>/img/loader/ajax-load.gif" />'); 
  				 },
  				 success:function(html){	
  					 $("#divCargar").empty(); 	
  					 $("#moduloProducto").html(html);
  					
  				}
  			});
  	 
  	 });
  	   
  	 
  	 $("#inputNombre").keyup(function(){
  		
  	     
  		 var nombreProducto= $("#inputNombre").val();
  		 var idBarra=$("#idBarra").val();
  		 
  			$.ajax({
  				url:'<%=application.getContextPath()%>/sProducto',
  				type:'GET',
  				data:{ 
  					flag:'1',
  					nombreProducto:nombreProducto,
  					idBarra:idBarra
  					 },
  					 cache:false,
  					 beforeSend:function(){
  						$("#divCargar").empty().html('<img src="<%=application.getContextPath()%>/img/loader/ajax-load.gif" />'); 
  					 },
  				success:function(html){	
  					$("#divCargar").empty(); 
  					 	
  					 $("#moduloProducto").html(html);
  					
  				}
  			});
  	    
  	 });
  	
  	 function fn_Barra(){
  			
  		 $.ajax({
  				url:'<%=application.getContextPath()%>/sInterPagina',
  				type:'GET',
  				data:{ 
  					flag:'7',
  					ruta:"/jsp/principal.jsp"
  					 },
  				success:function(html){	
  							
  					 $("#page-wrapper").html(html);
  					 $("#men1").css({"background-color": "#eee", "color": "#286090"});
  					 $("#btnCategoria").css({"background-color": "#23527c;", "color": "#fff"});
  					 $("#btnAlmacen").css({"background-color": "#23527c;", "color": "#fff"});
  					 $("#btnAsignarEmpBarra").css({"background-color": "#23527c;", "color": "#fff"});
  					 
  					 
  					}
  				});
  	 }
  		
  	
  	
  	
  	function cargarInterfaz(id,codigo,nombreProducto,precio){
  		
  		var nombreCampo="input"+id;
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sInterPagina',
  			type:'GET',
  			data:{ 
  				flag:'3',
  				nombreCampo:nombreCampo,
  				codigo:codigo,
  				nombreProducto:nombreProducto,
  				precio:precio
  				 },
  			 
  			success:function(html){	
  						
  				 $(".modal-body-cantidad").html(html);
  				
  			}
  		});
  		
  		
  	}
  	
  	 function obtenerPrecioxProducto(){
  	      	
  	      	var preciototal=parseFloat("0.0");
  	      
  	      	$('#mitablaProducto .tmpsubtotal').each(function() {
  	      	
  	      		 preciototal+=parseFloat($(this).text().replace("S/.",""));
  	      			      		
  	          });
  	      	   
  	    		
  	    		$("#totalboleta").val(preciototal.toFixed(2));
  	      
  	      }
  	
  	 
  	 

  	 
  	 
  	 
  	 
  	 
   	function obtenerInput(id, nombreCampo, codigo, nombre, precio) {
  	    var repetido = "F";
  	    var cont = 1;
  	    var numFila = 0;
  	    var i = 1;
  	    var cantidadT = 0;
  	    console.log("id---->" + id);
  	    console.log("nombreCampo---->" + nombreCampo);
  	    console.log("codigo---->" + codigo);
  	    console.log("nombre---->" + nombre);
  	    console.log("precio---->" + precio);

  	    var cantidad = 1;
  	    console.log("cantidad---->" + cantidad);
  	    $('#mitablaProducto .tmpcodigo').each(function() {
  	        if (codigo == $(this).html()) {
  	            repetido = "T";
  	            numFila = cont;
  	        }
  	        cont++;
  	    });

  	    if (repetido == "T") {
  	        $('#mitablaProducto .tmpcantidad').each(function() {
  	            if (i == numFila) {
  	                cantidadT = $(this).html();
  	            }
  	            i++;
  	        });

  	        cantidad = parseInt(cantidad) + parseInt(cantidadT);
  	        var n = $('tr:last td', $("#mitablaProducto")).length;
			tds += '<tbody>'
  	        for (var i = 0; i < n; i++) {
  	            if (i == 0) {   
  	              	tds += '<td class="tmpdescripcion">' + nombre + '</td>';
  	            } else if (i == 1) {
  	            	tds += '<td class="tmpcantidad">' + cantidad + '</td>';
  	            } else if (i == 2) {
  	            	tds += '<td class="tmpprecio">' + 'S/.' + parseFloat(precio).toFixed(2) + '</td>';
  	            } else if (i == 3) {
  	            	tds += '<td class="tmpsubtotal">' + 'S/.' + (parseFloat(precio) * parseInt(cantidad)).toFixed(2) + '</td>';
  	            } else if (i == 4) {
  	            	tds += '<td><a onclick="fn_eliminar(this)"><img src="<%=application.getContextPath()%>/img/delete.png" height="25" width="25" ></a></td>';
  	            } else {
  	            	tds += '<td style="visibility:hidden;" class="tmpid">' + id + '</td>';
  	            }
  	        }

  	        var nu = $('tr:last', $("#mitablaProducto")).length;

  	        $("#mitablaProducto").find("tr:eq(" + numFila + ")").html(tds);

  	    } else {

  	        var total = 0.0;
  	        var n = $('tr:last td', $("#mitablaProducto")).length;
  	        var tds = '<tr style="background:#fff;">';
  	        for (var i = 0; i < n; i++) {
  	            if (i == 0) {   
  	              	tds += '<td class="tmpdescripcion">' + nombre + '</td>';
  	            } else if (i == 1) {
  	            	tds += '<td class="tmpcantidad">' + cantidad + '</td>';
  	            } else if (i == 2) {
  	            	tds += '<td class="tmpprecio">' + 'S/.' + parseFloat(precio).toFixed(2) + '</td>';
  	            } else if (i == 3) {
  	            	tds += '<td class="tmpsubtotal">' + 'S/.' + (parseFloat(precio) * parseInt(cantidad)).toFixed(2) + '</td>';
  	            } else if (i == 4) {
  	            	tds += '<td><a onclick="fn_eliminar(this)"><img src="<%=application.getContextPath()%>/img/delete.png" height="50" width="50" ></a></td>';
  	            } else {
  	            	tds += '<td style="visibility:hidden;" class="tmpid">' + id + '</td>';
  	            }
  	        }
  	        tds += '</tr></tbody>';
  	        $("#mitablaProducto").append(tds);
  	    }

  	    obtenerPrecioxProducto();

  	} 	 
  	 
  	 
  	 
  	 
  	 
  	 
  	
  	
  	
  	
  	 function fn_eliminar(r) {
           var i = r.parentNode.parentNode.rowIndex;
           document.getElementById("mitablaProducto").deleteRow(i);
           
           obtenerPrecioxProducto();
       }
   
  	 function fn_eliminar_fila(r) {
           var i = r.parentNode.parentNode.rowIndex;
           document.getElementById("dataTables-example-stockGeneralVacio").deleteRow(i);
         
       }
  	 
  	
  	function fn_pasarProducto(id,idAlmacen,codigo,nombre,cantidadGrupal,cantidadUnitaria){
  			
  			console.log("id"+id);
  			console.log("idAlmacen"+idAlmacen);
  			console.log("codigo"+codigo);
  			console.log("nombre"+nombre);
  			console.log("cantidadUnitaria"+cantidadUnitaria);
  			console.log("cantidadGrupal"+cantidadGrupal);
  			
  		
  			var idBarra=$("#txt_barraopc1").val();
  					
  			if(idBarra=="-1"){
  				
  			alert("debe de seleccionar un select");	
  				
  			}else{		
  			
  					$.ajax({
  						url:'<%=application.getContextPath()%>/sTransaccional',
  						type:'GET',
  						dataType:'JSON',
  						data:{ 
  							flag:'1',
  							bandera:'A',
  							id:id,
  							codigo:codigo,
  							idAlmacen:idAlmacen,
  							nombre:nombre,
  							cantidadUnitaria:cantidadUnitaria,
  							cantidadGrupal:cantidadGrupal,
  							idBarra:idBarra
  							 },
  						 
  						success:function(response){	
  							
  							
  							var contexto="";
  			
  							var flag="";
  							
  							var nombretabla="";
  							var nombrecelda="";
  							var count=-1;
  							var countTotal=0;
  						
  							
  							
  							$('#dataTables-example-stockGeneralVacio .tmpidB').each(function() {
  						//	alert(response.idProducto + "==" + $(this).html());
  								if(response.idProducto==$(this).html()){
  									
  								flag='A';
  								count++;
  								}    
  			               		
  								countTotal=countTotal+1;
  							
  							});
  						//	alert(flag);
  							
  							
  							
  							for ( var a = 0; a < response.productoObj.length; a++) {
  			
  								if(flag!='A'){
  								
  								
  								contexto='<tr id="fila'+countTotal+'" class="filap" style="background:#fff;"> '+
  								 			 '<td class="tmpidB" style="border: 1px solid #101010;text-align: center;">'+response.productoObj[a].id+'</td>'+
  											 '<td class="tmpidAlmacen" style="border: 1px solid #101010;text-align: center;display: none;">'+response.idAlmacen+'</td>'+
  											 '<td class="tmpcodigoB" style="border: 1px solid #101010;text-align: center;">'+response.productoObj[a].codigo+'</td>'+
  											 '<td class="tmpnombreB" style="border: 1px solid #101010;text-align: center;">'+response.productoObj[a].nombre+'</td>'+
  											 '<td class="tmpcantidadUnitariaBAlmacen" style="border: 1px solid #101010;text-align: center;">'+response.productoObj[a].cantidades+'</td>'+
  											 '<td class="tmpcantidadGrupalBAlmacen" style="border: 1px solid #101010;text-align: center;">'+response.productoObj[a].cantidadGrupal+'</td>'+
  											 '<td class="tmpcantidadUnitariaBIngreso" style="border: 1px solid #101010;text-align: center;"><input class="form-control inpunitario" value="0"></td>'+
  											 '<td class="tmpcantidadGrupalBIngreso" style="border: 1px solid #101010;text-align: center;"><input class="form-control inpgrupal" value="0"></td>'+
  											 '<td style="border: 1px solid #101010;text-align: center;"><a onclick="fn_eliminar_fila(this)"><img src="/Billar/img/delete.png" height="50" width="50" ></a></td>'+
  										  '</tr>';
  								} 
  								
  							}
  							  
  							  
  							//.style.color="blue";
  						//	nombretabla.className;
  							
  							$("#dataTables-example-stockGeneralVacio").append(contexto);						
  							
  							// var n = $("#dataTables-example-stockGeneralVacio tr .filap").length;
  							
  							//alert("counttt"+count);
  							
  							//alert("countTotal "+countTotal);
  							
  							
  						/*	
  							
  							
  							if(flag=='A'){
  								
  								
  							$("#fila"+count).css("background","#e2b9b7");
  						
  							
  							}else{
  								
  								if(countTotal==-1){
  								
  								
  								$("#fila0").css("background","#e2b9b7");
  								
  								}else{
  									
  									
  									$("#fila"+(countTotal)).css("background","#e2b9b7");
  										
  									
  									
  								}
  								
  							} */
  							
  							
  							
  						}
  					});
  			
  			}
  		}
  	
  	function fn_adicionarCantidad(idAlmacen,idProducto,nombre,cantidadUnitario,cantidadGrupal,precioUnitario,precioGrupal,descCategoria){
  		
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sInterPagina',
  			type:'GET',
  			data:{ 
  				flag:'8',
  				idAlmacen:idAlmacen,
  				idProducto:idProducto,
  				nombre:nombre,
  				cantidadUnitaria:cantidadUnitario,
  				cantidadGrupal:cantidadGrupal,
  				precioCompraUnidad:precioUnitario,
  				precioCompraGrupal:precioGrupal,
  				descCategoria:descCategoria,
  				ruta:"/jsp/Tienda/MantenimientoProducto/adicionarProducto.jsp"
  							
  				 },
  				success:function(html){	
  						
  				 $(".modal-body-adicionarCantidad").html(html);
  					
  				}
  		});
  				
  			 
  		
  	}
  	
  	
  	
  function fn_actualizarPaginaPoppup(id,nombre,precioUnidad){
  	    
  		$.ajax({
  			url:'<%=application.getContextPath()%>/sProducto',
  			type:'GET',
  			data:{ 
  				flag:'5',
  				ruta:"/jsp/Tienda/PoliticaPrecios/lista.jsp",
  				id:id,
  				nombre:nombre,
  				precioUnidad:precioUnidad
  				 },
  			success:function(html){	
  						
  				 $(".modal-body-opcionesProducto").html(html);
  				
  				}
  			});
  		
  		
  	}
  	
     		 
      
      </script>
   </body>
</html>