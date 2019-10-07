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
	<h1>Barras / Persona</h1>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
			
				<tr>
					<th>#</th>
					<th>Barra</th>
					<th>Persona</th>
					<th>Accion</th>
					<th></th>
				</tr>	
			
			<%
				int i = 0;
				List<Entity> barra = (List<Entity>) request.getAttribute("barraList");
				for (Entity e : barra) {					
			%>
			<form method="post" action="./update" class="form-horizontal">
			 <tr>
			 	
				<td><%= i + 1 %></td>
				<td><input type="text" name="barra" id="barra" value="<%=e.getProperty("nombre")%>" class="form-control" readonly="readonly"></td>
				<td>
				<select name="persona" class="form-control">
					<option value="">- Selecciona persona -</option>
					<%
						List<Entity> persona = (List<Entity>) request.getAttribute("personaList");
						for (Entity p : persona) {					
					%>
                    <option value="<%=p.getKey().getId()%>"><%=p.getProperty("nombres")%></option>
                    <% } %>	
				</select> 			
				</td>							
				<td>
					<input type="submit" name="save" class="btn btn-sm btn-primary" value="Guardar cambios">
				</td>
				<td><input type="hidden" name="codigoBarra" id="codigoBarra" value="<%=e.getKey().getId()%>" class="form-control"></td>
			 </tr>
			</form>			
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