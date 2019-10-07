<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<meta charset="utf-8" /> 
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/css1/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css1/style_nav.css"
	rel="stylesheet">
<style>
body {
	font-size: 11px;
}

.content {
	margin-top: 80px;
}
h4, h5{
	margin: 5px;
	padding: 0px;
}
</style>

<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<div>
		<nav class="navbar navbar-dark bg-success navbar-expand-lg">
			<div class="container">
				<jsp:include page="nav.jsp" />
			</div>
		</nav>
	</div>
	<%
		Entity billar = (Entity) request.getAttribute("billar");
	%>
	<div class="container">
		<h1>Finalizar mesa</h1>

		<div class="col-sm-8" id="imprime">
			<table>
				<tbody>
					<tr>
						<td colspan="6" align="center"><span id="in_hi"
							style="color: blue; font-weight: bold; font-size: 18px;">BILLAR
								LA MEGA</span></td>
					</tr>
					<tr>
						<td colspan="6" align="center"><span id="in_hi"
							style="color: blue; font-weight: bold; font-size: 11px;">SALON DE JUEGOS
								</span></td>
					</tr>
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td align="right"><h5 style="font-weight: bold;">Inicio:</h5></td>
						<td align="right"><span id="in_hi"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("inicio")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Final:</h5></td>
						<td align="right"><span id="in_hf"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("fin")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Duracion:</h5></td>
						<td align="right"><span id="in_tt"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("tiempo")%></span></td>
					</tr>
					<tr>
						<td align="right"><h5 style="font-weight: bold;">Precio
								normal: S/.</h5></td>
						<td align="right"><span id="in_mh"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("preciohoranormal")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Duracion
								normal:</h5></td>
						<td align="right"><span id="in_duracion"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("minutosnormal")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Monto
								normal: S/.</h5></td>
						<td align="right"><span id="in_montoNormal"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("montonormal")%>0</span></td>

					</tr>
					<tr>
						<td align="right"><h5 style="font-weight: bold;">Precio
								recargo: S/.</h5></td>
						<td align="right"><span id="in_montoIncrementoMesa"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("incremento")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Duracion
								recargo:</h5></td>
						<td align="right"><span id="in_minutosIncremento"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("minutosincremento")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Monto
								recargo: S/.</h5></td>
						<td align="right"><span id="in_montoIncremento"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("montoincremento")%>0</span></td>
					</tr>
					<tr>
						<td align="right"><h5 style="font-weight: bold;">Precio
								taco: S/.</h5></td>
						<td align="right"><span id="in_pt"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("preciotaco")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Numero
								de tacos:</h5></td>
						<td align="right"><span id="in_nt"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("taco")%></span></td>
						<td align="right"><h5 style="font-weight: bold;">Monto
								taco: S/.</h5></td>
						<td align="right"><span id="in_montoTaco"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("montotaco")%>0</span></td>
					</tr>
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td align="right"><h5 style="font-weight: bold;">Descuento:
								S/.</h5></td>
						<td align="right"><span id="in_descuento"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("descuento")%>0</span></td>
					</tr>
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td align="right"><h5 style="font-weight: bold;">Total a pagar: S/.</h5></td>
						<td align="right"><span id="in_mt"
							style="color: blue; font-weight: bold; font-size: 14px;"><%=billar.getProperty("montototal")%>0</span></td>
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
