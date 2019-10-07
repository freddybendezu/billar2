<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/css1/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css1/style_nav.css"
	rel="stylesheet">

<style>
.content {
	margin-top: 80px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<jsp:include page="nav.jsp" />
	</nav>
	<div class="container">
		<div class="content">
			<div class="row">
				<div class="col-md-6">
					<div class="row">
						<input type="text" class="form-control" id="inputNombre">
						<div id="divCargar"></div>
						<hr />
					</div>
					<div class="table-responsive">
						<table class="table table-striped table-hover table-bordered"
							id="listaProducto">
							<tr>
								<th>Codigo producto</th>
								<th>Nombre producto</th>
								<th>Precio Producto</th>
								<th>Accion</th>
							</tr>

							<%
								List<Entity> productoBarraList = (List<Entity>) request.getAttribute("productoBarraList");
								for (Entity e : productoBarraList) {
							%>

							<tr>
								<td id="codigoProducto"><%=e.getProperty("codigoProducto")%></td>
								<td id="nombreProducto"><%=e.getProperty("nombreProducto")%></td>
								<td id="precioProducto"><%=e.getProperty("precioProducto")%></td>
								<td><a href='#' title='unidades' class='btn btn-danger btn-sm' id='btnUnidades'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span></a></td>
								<td id="codigoProducto" style="display: none;"><%=e.getProperty("codigoProducto")%></td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
				</div>
				<div class="col-md-5">
					<div class="row">
						<div class="col-sm-12">
							<a href="#" class="btn btn-sm btn-primary"
								id="btnAgregarProductoBarra">Terminar venta</a> <a
								href="/producto/list" class="btn btn-sm btn-danger">Cancelar
								venta</a>
							<hr />
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12" id="moduloProducto">
							<div class="table-responsive">
								<form method="post" action="agregarProductoBarra"
									class="form-horizontal">
									<table class="table table-striped table-hover table-bordered"
										id="listaProductoBarra">
										<tr>
											<th>Cantidad</th>
											<th>Producto</th>
											<th>Precio</th>
											<th style="display: none;"></th>
										</tr>
									</table>

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>



		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>
</html>

<script>
	$(document)
			.ready(
					function() {
						$(document)
								.on(
										'click',
										'#btnCajas',
										function(event) {
											event.preventDefault();
											var producto = $(this)
													.parents("tr").find("td")[1].innerHTML;
											var cajas = 1;
											var unidades = 0;
											var codigo = $(this).parents("tr")
													.find("td")[8].innerHTML;
											var nuevaFila = "<tr><td id='tmpproducto' name='tmpproducto'>"
													+ producto
													+ "</td><td id='tmpcajas' name='tmpcajas'>"
													+ cajas
													+ "</td><td id='tmpunidades' name='tmpunidades'>"
													+ unidades
													+ "</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"
													+ "</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>"
													+ codigo + "</td></tr>";

											var saldoCaja = parseInt($(this)
													.parents("tr").find("td")[3].innerHTML) - 1;

											if (saldoCaja >= 0) {
												$(this).parents("tr")
														.find("td")[3].innerHTML = saldoCaja;
											} else {
												return false;
											}

											var x = 1;
											var encontrado = false;
											var cajas1 = 0;
											var repetido = "F";
											var numFila = 0;
											var cajasTotal = 0;
											var unidadesTotal = 0;
											var cont = 1;
											var i = 1;
											$('#listaProductoBarra #tmpcodigo')
													.each(
															function() {
																if (codigo == $(
																		this)
																		.html()) {
																	repetido = "T";
																	encontrado = true;
																	numFila = cont;
																}
																cont++;
															});

											if (repetido == "T") {
												$(
														'#listaProductoBarra #tmpcajas')
														.each(
																function() {
																	if (i == numFila) {
																		cajasTotal = $(
																				this)
																				.html();
																	}
																	i++;
																});
											}
											i = 1;
											if (repetido == "T") {
												$(
														'#listaProductoBarra #tmpunidades')
														.each(
																function() {
																	if (i == numFila) {
																		unidadesTotal = $(
																				this)
																				.html();
																	}
																	i++;
																});
											}

											cajas = parseInt(cajas)
													+ parseInt(cajasTotal);
											unidades = parseInt(unidades)
													+ parseInt(unidadesTotal);
											var nuevaFila1 = "<td id='tmpproducto' name='tmpproducto'>"
													+ producto
													+ "</td><td id='tmpcajas' name='tmpcajas'>"
													+ cajas
													+ "</td><td id='tmpunidades' name='tmpunidades'>"
													+ unidades
													+ "</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"
													+ "</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>"
													+ codigo + "</td>";

											if (encontrado == false) {
												$("#listaProductoBarra")
														.append(nuevaFila);
											} else {
												$("#listaProductoBarra").find(
														"tr:eq(" + numFila
																+ ")").html(
														nuevaFila1);
											}

										});

						$(document)
								.on(
										'click',
										'#btnUnidades',
										function(event) {
											event.preventDefault();
											var producto = $(this)
													.parents("tr").find("td")[1].innerHTML;
											var cajas = 0;
											var unidades = 1;
											var codigo = $(this).parents("tr")
													.find("td")[8].innerHTML;
											var nuevaFila = "<tr><td id='tmpproducto' name='tmpproducto'>"
													+ producto
													+ "</td><td id='tmpcajas' name='tmpcajas'>"
													+ cajas
													+ "</td><td id='tmpunidades' name='tmpunidades'>"
													+ unidades
													+ "</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"
													+ "</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>"
													+ codigo + "</td></tr>";

											var saldoUnidad = parseInt($(this)
													.parents("tr").find("td")[4].innerHTML) - 1;

											if (saldoUnidad >= 0) {
												$(this).parents("tr")
														.find("td")[4].innerHTML = saldoUnidad;
											} else {
												return false;
											}

											var x = 1;
											var encontrado = false;
											var cajas1 = 0;
											var repetido = "F";
											var numFila = 0;
											var cajasTotal = 0;
											var unidadesTotal = 0;
											var cont = 1;
											var i = 1;
											$('#listaProductoBarra #tmpcodigo')
													.each(
															function() {
																if (codigo == $(
																		this)
																		.html()) {
																	repetido = "T";
																	encontrado = true;
																	numFila = cont;
																}
																cont++;
															});

											if (repetido == "T") {
												$(
														'#listaProductoBarra #tmpcajas')
														.each(
																function() {
																	if (i == numFila) {
																		cajasTotal = $(
																				this)
																				.html();
																	}
																	i++;
																});
											}
											i = 1;
											if (repetido == "T") {
												$(
														'#listaProductoBarra #tmpunidades')
														.each(
																function() {
																	if (i == numFila) {
																		unidadesTotal = $(
																				this)
																				.html();
																	}
																	i++;
																});
											}

											cajas = parseInt(cajas)
													+ parseInt(cajasTotal);
											unidades = parseInt(unidades)
													+ parseInt(unidadesTotal);
											var nuevaFila1 = "<td id='tmpproducto' name='tmpproducto'>"
													+ producto
													+ "</td><td id='tmpcajas' name='tmpcajas'>"
													+ cajas
													+ "</td><td id='tmpunidades' name='tmpunidades'>"
													+ unidades
													+ "</td><td><a href='#' title='Eliminar' class='btn btn-danger btn-sm' id='btnQuitar'><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"
													+ "</td><td style='display:none;' id='tmpcodigo' name='tmpcodigo'>"
													+ codigo + "</td>";

											if (encontrado == false) {
												$("#listaProductoBarra")
														.append(nuevaFila);
											} else {
												$("#listaProductoBarra").find(
														"tr:eq(" + numFila
																+ ")").html(
														nuevaFila1);
											}

										});

						$(document)
								.on(
										'click',
										'#btnQuitar',
										function(event) {
											event.preventDefault();
											var producto = $(this)
													.parents("tr").find("td")[0].innerHTML;
											var cajas = $(this).parents("tr")
													.find("td")[1].innerHTML;
											var unidades = $(this)
													.parents("tr").find("td")[2].innerHTML;
											var codigo = $(this).parents("tr")
													.find("td")[4].innerHTML;
											var cont = 1
											var fila = 0;
											var i = 1;

											$('#listaProducto #codigoProducto')
													.each(
															function() {
																if (codigo == $(
																		this)
																		.html()) {
																	fila = cont;
																}
																cont++;
															});

											$(
													'#listaProducto #nroCajasCompradas')
													.each(
															function() {
																if (i == fila) {
																	console
																			.log(cajas);
																	cajasCompradas = parseInt($(
																			this)
																			.html())
																			+ parseInt(cajas);
																	$(this)
																			.parents(
																					"tr")
																			.find(
																					"td")[3].innerHTML = cajasCompradas;
																}
																i++;
															});

											i = 1;

											$(
													'#listaProducto #nroUnidadesCompradas')
													.each(
															function() {
																if (i == fila) {
																	unidadesCompradas = parseInt($(
																			this)
																			.html())
																			+ parseInt(unidades);
																	$(this)
																			.parents(
																					"tr")
																			.find(
																					"td")[4].innerHTML = unidadesCompradas;
																}
																i++;
															});

											$(this).closest('tr').remove();

										});

						$("#btnAgregarProductoBarra")
								.click(
										function() {

											var tmpCodigoProducto = "";
											var tmpNombreProducto = "";
											var tmpCajas = "";
											var tmpUnidades = "";

											$('#listaProductoBarra #tmpcodigo')
													.each(
															function() {
																tmpCodigoProducto += $(
																		this)
																		.html()
																		+ ",";
															});

											$(
													'#listaProductoBarra #tmpproducto')
													.each(
															function() {
																tmpNombreProducto += $(
																		this)
																		.html()
																		+ ",";
															});

											$('#listaProductoBarra #tmpcajas')
													.each(
															function() {
																tmpCajas += $(
																		this)
																		.html()
																		+ ",";
															});

											$(
													'#listaProductoBarra #tmpunidades')
													.each(
															function() {
																tmpUnidades += $(
																		this)
																		.html()
																		+ ",";
															});
											tmpCodigoBarra = $("#barra").val();
											tmpNombreBarra = $(
													"#barra option:selected")
													.text();
											tmpCodigoProducto = tmpCodigoProducto
													.substring(
															0,
															tmpCodigoProducto.length - 1);
											tmpNombreProducto = tmpNombreProducto
													.substring(
															0,
															tmpNombreProducto.length - 1);
											tmpCajas = tmpCajas.substring(0,
													tmpCajas.length - 1);
											tmpUnidades = tmpUnidades
													.substring(
															0,
															tmpUnidades.length - 1);

											$
													.ajax({
														url : 'agregarProductoBarra',
														type : 'POST',
														dataType : 'JSON',
														data : {
															flag : '1',
															tmpCodigoBarra : tmpCodigoBarra,
															tmpNombreBarra : tmpNombreBarra,
															tmpCodigoProducto : tmpCodigoProducto,
															tmpNombreProducto : tmpNombreProducto,
															tmpCajas : tmpCajas,
															tmpUnidades : tmpUnidades
														},

														success : function(
																response) {
															console
																	.log("Exito");
															location.reload();
														}

													});
										})

					})
</script>
