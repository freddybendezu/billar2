	<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>

<html>
<head>
<!-- Bootstrap -->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">



<style type="text/css">
body {
	font-size: 12px;
}
</style>
</head>
<body>

	<jsp:include page="nav.jsp" />
	
		<div class="btn-group btn-group-sm " style="margin-bottom:3px;" role="group" aria-label="Basic example">
		  <button type="button" class="btn btn-danger" id="fechaactual">Left</button>
		  <a class="btn btn-danger" href="/billarreporte/frmBillarReporteGral" id="totalcaja">Right</a>
		</div>
	
	

	<div class="container">

		<div class="row">

			<%
				List<Entity> billarMesaList = (List<Entity>) request.getAttribute("billarmesalist");
				for (Entity e : billarMesaList) {
			%>
			<div class="col-md-2" style="margin-bottom:3px;" >
				<div class="card text-white bg-success xs-3"
					style="max-width: 18rem;" id="<%=e.getProperty("id")%>">
					<div class="card-header">
						<h5>
							<span class="badge badge-warning"
								id="mesanumeroorden<%=e.getProperty("id")%>"><%=e.getProperty("numero")%></span>
							<span id="hora<%=e.getProperty("id")%>">00</span><span
								id="minuto<%=e.getProperty("id")%>">:00:</span><span
								id="segundo<%=e.getProperty("id")%>">00</span>
						</h5>

					</div>
					<div class="card-body" style="padding: 2px;">
						<form class="form-inline" method="post" action="./result">
							<div class="input-group card-title">
								<div class="input-group-btn">
									<button type="button"
										class="btn btn-primary start-timer-btn btn-sm"
										id="<%=e.getProperty("id")%>">Inicio &nbsp;</button>
								</div>
								<input type="text" name="horainicio" required
									id="horainicio<%=e.getProperty("id")%>"
									value="<%=e.getProperty("horainicio")%>"
									class="form-control form-control-sm" readonly />
							</div>
							<div class="input-group card-title">
								<div class="input-group-btn">
									<button type="button"
										class="btn btn-warning btn-sm start-horaactual-btn"
										value="<%=e.getProperty("horaactual")%>"
										id="<%=e.getProperty("id")%>">Final &nbsp; &nbsp;</button>
								</div>
								<input type="text" id="horaactual<%=e.getProperty("id")%>"
									class="form-control form-control-sm" readonly />
							</div>
							
							
							<div class="input-group card-title">
								<div class="input-group-btn">
									<button type="submit" name="save" id="btn-guardar" class="btn btn-danger btn-sm btn-guardar">Guardar</button>
								</div>
								<input type="text" id="total<%=e.getProperty("id")%>"
									class="form-control form-control-sm" readonly />
							</div>
							<div class="input-group card-title">
								<input type="text" name="taco" id="taco<%=e.getProperty("id")%>"
									value="<%=e.getProperty("taco")%>"
									class="form-control form-control-sm" readonly> <span
									class="input-group-btn">
									<button type="button" class="btn btn-danger btn-sm start-tacos"
										id="<%=e.getProperty("id")%>">&nbsp;-&nbsp;</button>
									<button type="button"
										class="btn btn-warning btn-sm start-tacos"
										id="<%=e.getProperty("id")%>">+</button>
								</span>
							</div>

							<p style="display: none">
								Mesa: <input type="text" name="mesa"
									id="mesa<%=e.getProperty("id")%>"
									value="<%=e.getProperty("id")%>" class="form-control "
									readonly="readonly">
							</p>
							<!---->
							<p style="display: none">
								Estado: <input type="text" name="estado"
									id="estado<%=e.getProperty("id")%>"
									value="<%=e.getProperty("estado")%>" class="form-control"
									readonly="readonly">
							</p>
							<p style="display: none">
								Codigo: <input type="text" name="codigo"
									id="codigo<%=e.getProperty("id")%>"
									value="<%=e.getProperty("codigo")%>" class="form-control"
									readonly="readonly">
							</p>
							<p style="display: none">
								inicio:<input type="text" name="inicio"
									id="inicio<%=e.getProperty("id")%>"
									value="<%=e.getProperty("inicio")%>"
									class="form-control form-control-sm" readonly>
							</p>
							<p style="display: none">
								Tiempo: <input type="text" name="tiempo"
									id="tiempo<%=e.getProperty("id")%>" value="0 sec"
									class="form-control" readonly="readonly">
							</p>
							<p style="display: none">
								Precio S/.<input type="text" name="precio"
									id="precio<%=e.getProperty("id")%>"
									value="<%=e.getProperty("precio")%>" class="form-control"
									readonly="readonly">
							</p>

						</form>
					</div>
				</div>
			</div>
			<%
				}
			%>
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
<script src="<%=request.getContextPath()%>/js1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js1/timer.jquery.js"></script>	
	
<script>

function initializeClock(id) {
	 var fecha= new Date();
	 var mes=fecha.getMonth()+1;
	 var day = fecha.getDate();
	 var year = fecha.getFullYear();
	 var horas= fecha.getHours();
	 var minutos = fecha.getMinutes();
	 var segundos = fecha.getSeconds();
	 if (horas<10) { horas="0"+horas; }
	 if (minutos<10) {minutos="0"+minutos; }
	 if (segundos<10) {segundos="0"+segundos; }
	 
	 //$("#inicio"+id).val(horas+":"+minutos+":"+segundos);
	 //$("#inicio"+id).val(fecha);
	 var meses = new Array ("January","February","March","April","May","June","July","August","September","October","November","December");
	 var tiempoF = meses[fecha.getMonth()] +" "+ year +" "+ day +" " + horas + ":" + minutos + ":" + segundos;	 
	 
	 
	function updateClock() {
		var estado = $("#estado"+id).val();
		if (estado == "libre") {
			$("#inicio"+id).val(tiempoF);
			$("#horainicio"+id).val(horas+':'+minutos+':'+segundos);
			var t = getTimeRemaining(tiempoF);
		}else{
			var inicio = $("#inicio"+id).val();
			var t = getTimeRemaining(inicio);
		}
		
		//$("#"+vardinero).text(((t.segundosTodos*precioUnitario)/3600).toFixed(2)+"");		
		$("#hora"+id).text( ('0' + t.hours).slice(-2) + ":");
		$("#minuto"+id).text( ('0' + t.minutes).slice(-2) + ":");
		$("#segundo"+id).text(('0' + t.seconds).slice(-2));
		$("#tiempo"+id).val($("#hora"+id).text() + $("#minuto"+id).text() + $("#segundo"+id).text());
	}
	
	updateClock();
	var timeinterval = setInterval(updateClock, 1000);
	
}
function getTimeRemaining(endtime) {
		var t =  Date.parse(new Date()) - Date.parse(endtime);
		var seconds = Math.floor((t / 1000) % 60);
		var minutes = Math.floor((t / 1000 / 60) % 60);
		var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
		var days = Math.floor(t / (1000 * 60 * 60 * 24));
		var segundosTodos=Math.abs(seconds)+Math.abs(minutes*60)+Math.abs(hours*3600);
				
	return {
		'total': t,
		'days':days,
		'hours': hours,
		'minutes': minutes,
		'seconds': seconds,
		'segundosTodos':segundosTodos
	};
}

function registrar(id) {
	//var id = $(this).attr("id");
	$.ajax({
		url:'/billar/alquilar',
		type:'POST',
		dataType:'JSON',
		data:{ 
			mesa:$("#mesa"+id).val(),
			inicio:$("#inicio"+id).val(),
			tiempo:$("#tiempo"+id).val(),
			precio:$("#precio"+id).val(),
			//taco:$("#taco"+id).val(),
			mesanumeroorden:$("#mesanumeroorden"+id).text(),
			estado:"ocupado"
		},
		 
		success:function(response){
			var codigo = document.getElementById('codigo' + id);
			$('#codigo'+id).val(response[0]);
			$('#estado'+id).val("ocupado");
		}
	})
}

function tacos(id, operacion) {
	//var id = $(this).attr("id");
	var x = $("#taco"+id).val();
	
		if (operacion == "+"){
			x = parseInt(x) + 1;	
		}else{
			x = x - 1;	
		}
	
	if (x >= 0){
		$("#taco"+id).val(x);
	}
	
	$.ajax({
		url:'/billar/tacos',
		type:'POST',
		dataType:'JSON',
		data:{ 
			codigo:$("#codigo"+id).val(),
			mesa:$("#mesa"+id).val(),
			inicio:$("#inicio"+id).val(),
			tiempo:$("#tiempo"+id).val(),
			precio:$("#precio"+id).val(),
			taco:$("#taco"+id).val(),
			mesanumeroorden:$("#mesanumeroorden"+id).text(),
			estado:"ocupado"
		},
		 
		success:function(response){
			console.log("Exito");
		}
		})
}




function fn_totalCaja() {
	$.ajax({
		url:'/billar/totalcaja',
		type:'GET',
		dataType:'JSON',
		success:function(response){
			$('#totalcaja').text('TOTAL CAJA S/.'+response[0]);
			$('#fechaactual').text(response[1]);
		}
	})
}


$(document).ready(function() {
				
				fn_totalCaja();
	
				$(".card").each(function(){
					var id = $(this).attr('id');
					var estado = $("#estado"+id).val(); 
					if (estado == "ocupado") {
						initializeClock(id);
					}
					
				});
				
				$(".start-timer-btn").on('click', function() {
					var id = $(this).attr("id");
					var estado = $("#estado"+id).val();
					if (estado == "libre") {
						$("#taco"+id).val(0);
						initializeClock(id);
						registrar(id);
					}
				});
				
				
				$(".start-tacos").on('click', function() {
					var id = $(this).attr("id");
					var signo = $(this).text();
					tacos(id,signo)
				});
				
				$(".start-horaactual-btn").on('click', function() {
					var id = $(this).attr("id");
					var fecha= new Date();
					var horas= fecha.getHours();
					var minutos = fecha.getMinutes();
					var segundos = fecha.getSeconds();
					$("#horaactual"+id).val(horas+':'+minutos+':'+segundos);
					
					$.ajax({
						url:'/billar/total',
						type:'POST',
						dataType:'JSON',
						data:{ 
							codigo:$("#codigo"+id).val(),
							tiempo:$("#tiempo"+id).val(),
							taco:$("#taco"+id).val(),
						},
						 
						success:function(response){
							var total = parseFloat(response).toFixed(2);
							$('#total'+id).val('S/.'+total);
						}
					})
					
				});
				
});
	
</script>
