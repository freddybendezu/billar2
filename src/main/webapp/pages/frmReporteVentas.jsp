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
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<jsp:include page="nav.jsp" />
	</nav>
	<div class="container">


		<div class="form-group col-md-3">
			<label>Ventas:</label> <select name="cboventas" class="form-control"
				id="cboventas">
				<option value=""></option>
				<%
					List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
					for (Entity e : barra) {
				%>
				<option value="<%=e.getKey().getId()%>"><%=e.getProperty("nombre")%></option>
				<%
					}
				%>
			</select>
		</div>

		<div class="content" id="imprimir">
			<h4>REPORTE DE VENTAS</h4>
			<div class="col-sm-12">

				<table id="billareporte"
					class="table table-bordered table-hover dataTable"
					style="width: 100%">
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
						</tr>
						<%
							}
						%>

					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
</body>

</html>