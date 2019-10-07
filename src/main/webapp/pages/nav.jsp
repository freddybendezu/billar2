	<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand visible-xs-block visible-sm-block" href="">Inicio</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav ">
					
					<li class="dropdown">
          			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tienda<span class="caret"></span></a>
			          <ul class="dropdown-menu">
			            <li><a href="/caja/list">Caja</a></li>
			            <li><a href="/productoBarra/list">Productos en barra</a></li>
			            <li><a href="/barraPersona/list">Personas en barra</a></li>
			            <li><a href="/producto/list">Almacen</a></li>
						<li><a href="/persona/list">Personas</a></li>
						<li><a href="/barra/list">Barras</a></li>			            
			          </ul>
        			</li>
					
					<li><a href="/billar/list">Billar</a></li>
					<li><a href="/billar/billarmesalist">Billar mesas</a></li>
					<li><a href="/billarreporte/list">Billar reporte</a></li>
					
				</ul>
				<p class="navbar-text navbar-right">Usuario:  <%= session.getAttribute("usuario") %> <a class="navbar-link" href="/logout">Cerrar sesion</a></p>
				
			</div><!--/.nav-collapse -->
	</div>