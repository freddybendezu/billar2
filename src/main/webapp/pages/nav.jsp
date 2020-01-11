<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">SURIA</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      
      <li class="nav-item active">
        <a class="nav-link" href="/billar/list">BILLAR</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          REPORTES
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        	<a class="dropdown-item" href="/billarreporte/list">REPORTE X USUARIO</a>
			<a class="dropdown-item" href="/billarreporte/frmBillarReporteGral">REPORTE BILLAR GENERAL</a>
			<a class="dropdown-item"  href="/ventasreporte/frmReporteVentas">REPORTE VENTAS GRAL</a>
        </div>
      </li>     
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          PRODUCTOS
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			<a class="dropdown-item" href="/caja/list">CAJA</a>
          	<div class="dropdown-divider"></div>
			<a class="dropdown-item" href="/producto/list">PRODUCTOS EN ALMACEN</a>
			<a class="dropdown-item" href="/productoBarra/list">PRODUCTOS EN TIENDA</a>
        </div>
      </li>
      
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          CONFIGURACION
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			<a class="dropdown-item" href="/persona/list">PERSONAS</a>
			<a class="dropdown-item" href="/barra/list">TIENDAS</a>
			<a class="dropdown-item" href="/billar/billarmesalist">MESAS</a>
			<a class="dropdown-item" href="/barraPersona/list">RESPONSABLES	(*)</a>
        </div>
      </li>
    </ul>
    
    <ul class="navbar-nav ml-auto">
    	<li>USUARIO:  <%= session.getAttribute("usuario") %> <a class="navbar-link" href="/logout">CERRAR SESSION</a></li>
    </ul>
         
    
  </div>
</nav>