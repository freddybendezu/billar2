<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<html>
<head>
	<!-- Bootstrap -->
	<link href="<%=request.getContextPath() %>/css1/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css1/style_nav.css" rel="stylesheet">

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
	<h1>Barras / Personas</h1> Funcion : <a href="listUpdate">Modificar</a>
		<hr/>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>Barra</th>
					<th>Persona</th>
				</tr>	
			
			<%
				int i = 0;
				List<Entity> barraPersona = (List<Entity>) request.getAttribute("barraPersonaList");
				for (Entity e : barraPersona) {					
			%>
			
			<tr>
				<td><%= i + 1 %></td>
				<td><%=e.getProperty("barra")%></td>
				<td><%=e.getProperty("persona")%></td>
			</tr>			
			<%
				i++;}
			%>
		</table>
		</div>
	</div>
</div>
		
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/js1/bootstrap.min.js"></script>		
</body>
</html>