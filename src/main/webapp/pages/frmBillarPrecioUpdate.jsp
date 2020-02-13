<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
<!-- Bootstrap -->
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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<style>
body {
	font-size: 12px;
}
</style>

<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="content">
			<h4>MESA DE BILLAR - PRECIO</h4>

			<%
				Entity billarPrecio = (Entity) request.getAttribute("billarprecio");
			%>


			<form method="post" action="../update" class="form-horizontal">
				<input type="hidden" name="id" id="id"
					value="<%=billarPrecio.getKey().getId()%>" />

				<!-- comentado el 06/02/2020 
				<div class="form-group">
					<label class="col-sm-3 control-label">Hora inicio normal:</label>
					<div class="col-sm-4">
						<input type="text" name="horainicionormal" id="h0"
							value="<%=billarPrecio.getProperty("horainicionormal")%>"
							class="form-control" placeholder="horainicionormal" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Hora fin normal:</label>
					<div class="col-sm-4">
						<input type="text" name="horafinnormal" id="horafinnormal"
							value="<%=billarPrecio.getProperty("horafinnormal")%>"
							class="form-control" placeholder="horafinnormal" required>
					</div>
				</div>	-->


				<div class="box" method="post" action="../update"">
					<div class="box-header ">
						<h3 class="box-tittle">AM</h3>
					</div>
					<div class="box-body no-padding">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>12:00am</th>
									<th>01:00am</th>
									<th>02:00am</th>
									<th>03:00am</th>
									<th>04:00am</th>
									<th>05:00am</th>
									<th>06:00am</th>
									<th>07:00am</th>
									<th>08:00am</th>
									<th>09:00am</th>
									<th>10:00am</th>
									<th>11:00am</th>
								<tr align="center">

									<td><div class="form-group">
											<div>
												<input type="text" name="precio0" id="precionormal"
													value="<%=billarPrecio.getProperty("precio0")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio1" id="precionormal"
													value="<%=billarPrecio.getProperty("precio1")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>



									<td><div>
											<div>
												<input type="text" name="precio2" id="precionormal"
													value="<%=billarPrecio.getProperty("precio2")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>

									<td><div>


											<div>
												<input type="text" name="precio3" id="precionormal"
													value="<%=billarPrecio.getProperty("precio3")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>

									<td><div>
											<div>
												<input type="text" name="precio4" id="precionormal"
													value="<%=billarPrecio.getProperty("precio4")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio5" id="precionormal"
													value="<%=billarPrecio.getProperty("precio5")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio6" id="precionormal"
													value="<%=billarPrecio.getProperty("precio6")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio7" id="precionormal"
													value="<%=billarPrecio.getProperty("precio7")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio8" id="precionormal"
													value="<%=billarPrecio.getProperty("precio8")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio9" id="precionormal"
													value="<%=billarPrecio.getProperty("precio9")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio10" id="precionormal"
													value="<%=billarPrecio.getProperty("precio10")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio11" id="precionormal"
													value="<%=billarPrecio.getProperty("precio11")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>



								
								</tr>
								</tr>
						</table>
					</div>
				</div>
				<div class="box" method="post" action="../update"
					class="form-horizontal">
					<div class="box-header ">
						<h3 class="box-tittle">PM</h3>
					</div>
					<div class="box-body no-padding">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>12:00pm</th>
									<th>01:00pm</th>
									<th>02:00pm</th>
									<th>03:00pm</th>
									<th>04:00pm</th>
									<th>05:00pm</th>
									<th>06:00pm</th>
									<th>07:00pm</th>
									<th>08:00pm</th>
									<th>09:00pm</th>
									<th>10:00pm</th>
									<th>11:00pm</th>
								<tr align="center">
										<td><div class="form-group">
											<div>	
												<input type="text" name="precio12" id="precionormal"
													value="<%=billarPrecio.getProperty("precio12")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio13" id="precionormal"
													value="<%=billarPrecio.getProperty("precio13")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>



									<td><div>
											<div>
												<input type="text" name="precio14" id="precionormal"
													value="<%=billarPrecio.getProperty("precio14")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>

									<td><div>


											<div>
												<input type="text" name="precio15" id="precionormal"
													value="<%=billarPrecio.getProperty("precio15")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>

									<td><div>
											<div>
												<input type="text" name="precio16" id="precionormal"
													value="<%=billarPrecio.getProperty("precio16")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio17" id="precionormal"
													value="<%=billarPrecio.getProperty("precio17")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio18" id="precionormal"
													value="<%=billarPrecio.getProperty("precio18")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio19" id="precionormal"
													value="<%=billarPrecio.getProperty("precio19")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio20" id="precionormal"
													value="<%=billarPrecio.getProperty("precio20")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio21" id="precionormal"
													value="<%=billarPrecio.getProperty("precio21")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio22" id="precionormal"
													value="<%=billarPrecio.getProperty("precio22")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>
									<td><div>
											<div>
												<input type="text" name="precio23" id="precionormal"
													value="<%=billarPrecio.getProperty("precio23")%>"
													class="form-control" placeholder="precionormal" required>
											</div></td>

								</tr>

								</tr>
						</table>
					</div>
				</div>
		</div>


	<!-- comentado el 06/02/2020 
		<div class="form-group">
			<label class="col-sm-3 control-label">Precio hora normal:</label>
			<div class="col-sm-4">
				<input type="text" name="precionormal" id="precionormal"
					value="<%=billarPrecio.getProperty("precionormal")%>"
					class="form-control" placeholder="precionormal" required>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">Precio hora normal1:</label>
			<div class="col-sm-4">
				<input type="text" name="precionormal1" id="precionormal"
					value="<%=billarPrecio.getProperty("precionormal1")%>"
					class="form-control" placeholder="precionormal" required>
			</div>
		</div>-->

		<div class="col-sm-6">
		<!-- comentado el 06/02/2020 
			<div class="form-group">
				<label class="col-sm-3 control-label">Incremento:</label>
				<div class="col-sm-4">
					<input type="text" name="incremento" id="incremento"
						value="<%=billarPrecio.getProperty("incremento")%>"
						class="form-control" placeholder="incremento" required>
				</div>
			</div>-->
			<div class="form-group">
				<label class="col-sm-3 control-label">Numero horas
					descuento:</label>
				<div class="col-sm-4">
					<input type="text" name="numerohorasdescuento"
						id="numerohorasdescuento"
						value="<%=billarPrecio.getProperty("numerohorasdescuento")%>"
						class="form-control" placeholder="numerohorasdescuento" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Porcentaje descuento:</label>
				<div class="col-sm-4">
					<input type="text" name="porcentajedescuento"
						id="porcentajedescuento"
						value="<%=billarPrecio.getProperty("porcentajedescuento")%>"
						class="form-control" placeholder="porcentajedescuento" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Precio unitario taco:</label>
				<div class="col-sm-4">
					<input type="text" name="preciounitariotaco"
						id="preciounitariotaco"
						value="<%=billarPrecio.getProperty("preciounitariotaco")%>"
						class="form-control" placeholder="preciounitariotaco" required>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">&nbsp;</label>
			<div class="col-sm-6">
				<input type="submit" name="save" class="btn btn-sm btn-primary"
					value="Guardar datos"> <a href="/billar/billarmesalist"
					class="btn btn-sm btn-danger">Cancelar</a>
			</div>
		</div>

		</form>
	</div>
	</div>






</body>
</html>