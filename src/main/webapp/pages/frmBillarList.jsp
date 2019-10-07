<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>

<html>
<head>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/css1/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css1/dataTables.bootstrap.css"
	rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js1/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js1/dataTables.bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/js1/timer.jquery.js"></script>

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

#listaProductoBarra {
	font-size: 11px;
}

.content {
	margin-top: 80px;
}

.card {
	padding: 5px;
	position: relative;
	display: -ms-flexbox;
	display: -webkit-box;
	display: flex;
	-ms-flex-direction: column;
	-webkit-box-orient: vertical;
	-webkit-box-direction: normal;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 1px solid rgba(0, 0, 0, 0.125);
	border-radius: 0.25rem;
}

.mb-2, .my-2 {
	margin-bottom: 0.5rem !important;
}

.card-title {
	background-color: orange;
	background-image:url("https://cdn.pixabay.com/photo/2015/11/26/19/19/ball-1064402_960_720.png");
	padding: 10px;
	margin: 0px;
	border-radius: 4px;
	float: right;
	font-size: 20px;
	font-weight: bold;
	background-size: 50px 50px;
	background-repeat: no-repeat;
	text-align: left;
	
}


</style>
</head>
<body>
	<!-- 	<nav class="navbar navbar-default navbar-fixed-top"> -->
	<%-- 		<jsp:include page="nav.jsp" /> --%>
	<!-- 	</nav> -->

	<div>
		<nav class="navbar navbar-default bg-success navbar-expand-lg">
			<div class="container">
				<jsp:include page="nav.jsp" />
			</div>
		</nav>
	</div>
	<div class="container">
	
		<div class="row">
			<%
				List<Entity> billarMesaList = (List<Entity>) request.getAttribute("billarmesalist");
				for (Entity e : billarMesaList) {
					
			%>
			
			<div class="col-md-2" >
			<form method="post" action="./result" class="form-horizontal">
			
				<article class="card mb-2" style="max-width: 20rem;" >
					<p class="card-title"><span id="mesanumeroorden<%=e.getProperty("id")%>" style="background-color: #ffffff; border-radius: 20px; padding: 2px 5px 0px 5px; margin-right: 20px;" ><%=e.getProperty("numero")%></span>
					<span id="hora<%=e.getProperty("id")%>" >00</span><span id="minuto<%=e.getProperty("id")%>">:00:</span><span id="segundo<%=e.getProperty("id")%>">00</span></p>
					
					<!---->
					<div class="card-body" id="<%=e.getProperty("id")%>">
						<p style="display:none">
							Mesa: <input type="text" name="mesa" id="mesa<%=e.getProperty("id")%>" value="<%=e.getProperty("id")%>" class="form-control" readonly="readonly">
						</p>
						<!---->
						<p>
							Estado: <input type="text" name="estado" id="estado<%=e.getProperty("id")%>" value="<%=e.getProperty("estado")%>" class="form-control" readonly="readonly">
						</p>
						<p style="display:none">
							Codigo: <input type="text" name="codigo" id="codigo<%=e.getProperty("id")%>" value="<%=e.getProperty("codigo")%>" class="form-control" readonly="readonly">
						</p>
						
						<p style="display:none">
							Inicio: <input type="text" name="inicio" id="inicio<%=e.getProperty("id")%>" value="<%=e.getProperty("inicio")%>" class="form-control" readonly="readonly">
						</p>
						<p style="display:none">
							Tiempo: <input type="text" name="tiempo" id="tiempo<%=e.getProperty("id")%>" value="0 sec" class="form-control" readonly="readonly">
						</p>
						<p style="display:none">
							Precio S/.<input type="text" name="precio" id="precio<%=e.getProperty("id")%>" value="<%=e.getProperty("precio")%>" class="form-control" readonly="readonly">
						</p>
						<p >
							Taco: <input type="text" name="taco" id="taco<%=e.getProperty("id")%>" value="<%=e.getProperty("taco")%>" class="form-control" readonly="readonly">
										<button type="button" class="btn btn-primary start-tacos" id="<%=e.getProperty("id")%>" >+</button>
										<button type="button" class="btn btn-danger start-tacos" id="<%=e.getProperty("id")%>">-</button>
						</p>
						<a  class="btn btn-primary start-timer-btn"	id="<%=e.getProperty("id")%>" >Iniciar</a>
						<input type="submit" name="save" class="btn btn-sm btn-danger" value="Terminar">

					</div>
				</article>
							</form>
				
			</div>
			<%
				}
			%>

		</div>
		
	</div>

	<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
	<%-- 	<script src="<%=request.getContextPath()%>/js1/bootstrap.min.js"></script> --%>

</body>
</html>

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
			taco:$("#taco"+id).val(),
			mesanumeroorden:$("#mesanumeroorden"+id).text(),
			estado:"ocupado"
		},
		 
		success:function(response){
			console.log("Exito");
			var codigo = document.getElementById('codigo' + id);
			$('#codigo' + id).val(response[0]);
			$('#estado' + id).val("ocupado");
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






	$(document).ready(
			function() {
				//var id = $(".card-body").attr("id");
				$(".card-body").each(function(){
					var id = $(this).attr('id');
					var estado = $("#estado"+id).val(); 
					if (estado == "ocupado") {
						console.log(id);
						initializeClock(id);
					}
					
				});
 				//var id = $("#5915372557434880").attr("id");
 				//initializeClock(id);
				//console.log(id);
				
				$(".start-timer-btn").on('click', function() {
					var id = $(this).attr("id");
					var estado = $("#estado"+id).val();
					$("#taco"+id).val(0);
					if (estado == "libre") {
						initializeClock(id);
						registrar(id)
					}
				

				});
				
				
				
				
				
				
				$(".start-tacos").on('click', function() {
					var id = $(this).attr("id");
					var signo = $(this).text();
					console.log("Hola " + $(this).text());
					tacos(id,signo)
				});
				
				
				
				
				
					
			});
				
				
				
				
				
// 				 $(".start-timer-btn").on('click', function() {
// 					 var id = $(this).attr("id");

// 						$.ajax({
// 							url:'/billar/alquilar',
// 							type:'POST',
// 							dataType:'JSON',
// 							data:{ 
// 								mesa:$("#mesa"+id).val(),
// 								inicio:$("#inicio"+id).val(),
// 								tiempo:$("#tiempo"+id).val(),
// 								precio:$("#precio"+id).val(),
// 								taco:$("#taco"+id).val(),
// 								estado:"ocupado"
// 							},
							 
// 							success:function(response){
// 								console.log("Exito");
// 								var codigo = document.getElementById('codigo' + id);
// 								$('#codigo' + id).val(response[0]);
// 							}
							
// 						});	     
// 			     });
			     

//			})
</script>
