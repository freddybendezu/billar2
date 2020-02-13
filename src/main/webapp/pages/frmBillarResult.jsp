<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<meta charset="utf-8" /> 
<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="<%=request.getContextPath()%>/js1/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/timer.jquery.js"></script>
<style type="text/css">
	body{
		font-size: 12px;
	}
</style>

</head>
<body>

	<jsp:include page="nav.jsp" />
	<%
		Entity billar = (Entity) request.getAttribute("billar");
	%>
	<div class="container">
		<div class="col-sm-8" id="imprime">
			<table>
			
				<tbody>
				
					<tr>
						<td colspan="6" align="center"><span id="in_hi" style="color: blue; font-weight: bold; font-size: 18px;">BILLAR SURIA</span></td>
					</tr>
					<tr>
						<td colspan="6" align="center"><span id="in_hi" style="color: blue; font-weight: bold; font-size: 11px;">SALON DE JUEGOS</span></td>
					</tr>
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td>
							<span id="in_hi"  style="font-size: 11px;">HORA INICIO:</span>
						</td>
						<td colspan="2">
							<span id="in_hi" style="color: blue; font-size: 11px;"><%=billar.getProperty("inicio")%></span>
						</td>
						<td>
							<span id="in_hi"  style="font-size: 11px;">HORA FINAL:</span>
						</td>
						<td align="right" colspan="2">
							<span id="in_hi" style="color: blue; font-size: 11px;"><%=billar.getProperty("fin")%></span>
						</td>	
					</tr>

					
					<tr>
						<td><span id="in_hi"  style="font-size: 11px;">Duracion:</span></td>
						<td align="right"><span id="in_tt" style="color: blue; font-size: 11px;"><%=billar.getProperty("tiempo")%></span></td>
					</tr>
					<tr>
						<td><span id="in_hi"  style="font-size: 11px;">Precio primera hora:</span></td>
						<td><span id="in_mh" style="font-size: 11px;">S/.<%=billar.getProperty("preciohoraini")%></span></td>
						<td><span id="in_hi"  style="font-size: 11px;">Precio ultima hora:</span></td>
						<td><span id="in_mh" style="font-size: 11px;">S/.<%=billar.getProperty("preciohorafin")%></span></td>

				
						<td><span id="in_hi"  style="font-size: 11px;">Precio Horas:</span></td>
						<td><span id="in_mh" style="font-size: 11px;">S/.<%=billar.getProperty("montonormal")%></span></td>
						
<!-- 						<td><span id="in_hi"  style="font-size: 11px;">D. Normal:</span></td> -->
<%-- 						<td><span id="in_duracion"style="font-size: 11px;"><%=billar.getProperty("minutosnormal")%></span></td> --%>
<!-- 						<td><span id="in_hi" style="font-size: 11px;">M. Normal:</span></td> -->
<%-- 						<td><span id="in_montoNormal" style="font-size: 11px;">S/.<%=billar.getProperty("montonormal")%>0</span></td> --%>

					</tr>
					
<!-- 					<tr> -->
<!-- 						<td><span id="in_hi"  style="font-size: 11px;">P. Recargo:</span></td> -->
<%-- 						<td><span id="in_montoIncrementoMesa" style="font-size: 11px;">S/.<%=billar.getProperty("incremento")%></span></td> --%>
<!-- 						<td><span id="in_hi"  style="font-size: 11px;">D. Recargo:</span></td> -->
<%-- 						<td><span id="in_minutosIncremento" style="font-size: 11px;"><%=billar.getProperty("minutosincremento")%></span></td> --%>
<!-- 						<td><span id="in_hi"  style="font-size: 11px;">M. Recargo:</span></td> -->
<%-- 						<td><span id="in_montoIncremento" style="font-size: 11px;">S/.<%=billar.getProperty("montoincremento")%>0</span></td> --%>
<!-- 					</tr> -->
					
					<tr>
						<td><span id="in_hi"  style="font-size: 11px;">P. Taco:</span></td>
						<td><span id="in_pt" style="font-size: 11px;">S/.<%=billar.getProperty("preciotaco")%></span></td>
						<td><span id="in_hi"  style="font-size: 11px;">Nro. tacos:</span></td>
						<td><span id="in_nt" style="font-size: 11px;"><%=billar.getProperty("taco")%></span></td>
						<td><span id="in_hi"  style="font-size: 11px;">M. Taco:</span></td>
						<td><span id="in_montoTaco" style="font-size: 11px;">S/.<%=billar.getProperty("montotaco")%>0</span></td>
					</tr>
					
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						
						<td></td>
						<td></td>
						<td></td>
						<td><span id="in_hi"  style="font-size: 11px;">Dscto S/.</span></td>
						<td><span id="in_descuento" style="font-size: 11px;"><%=billar.getProperty("descuento")%>0</span></td>
					</tr>
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						
						<td></td>
						<td></td>
						<td></td>
						<td><span id="in_hi"  style="font-size: 11px;">T. Pagar S/.</span></td>
						<td><span id="in_mt" style="font-size: 11px;"><%=billar.getProperty("montototal")%>0</span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clearfix"></div>
		<div class="col-sm-4">
			<button type="button" class="btn btn-primary" class="btn" onclick="fn_aceptar_final('<%=billar.getKey().getId()%>','<%=billar.getProperty("mesanumero")%>')">Confirmar</button>
			<a href="/billar/list" class="btn btn-sm btn-danger">Cancelar</a>
		</div>

	</div>



	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>
<script>
	function fn_aceptar_final(codigo, mesanumero) {

		var tiempoTranscurrido = $("#in_tt").text();
		var cantidadTaco = $("#in_nt").text();
		var montoTotal = $("#in_mt").text();

		$.ajax({
			url : '/billar/confirmar',	
			type : 'POST',
			dataType : 'JSON',
			data : {
				codigo : codigo,
				mesanumero : mesanumero,
				tiempo : tiempoTranscurrido,
				montototal : montoTotal,
				taco : cantidadTaco
			},

			success : function(response) {
				console.log(response[0])
				printDiv('imprime');
				window.location.href = '/billar/list';
			}
		});
	}

	function printDiv(divName) {
		var printContents = document.getElementById(divName).innerHTML;
		var originalContents = document.body.innerHTML;
		document.body.innerHTML = printContents;
		window.print();
		window.opener = window.parent.self;
		window.close();
	}
</script>
