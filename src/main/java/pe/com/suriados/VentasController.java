package pe.com.suriados;

import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

@Controller
@RequestMapping({"/ventasreporte"})
public class VentasController {

	
	@RequestMapping(value={"/frmReporteVentas"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	public String frmReporteVentas(ModelMap model){
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		   
		Query query = new Query("Persona").addSort("fecha", Query.SortDirection.DESCENDING);
	    List<Entity> persona = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
	    model.addAttribute("personaList", persona);
	    
	    Query query1 = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
	    List<Entity> barra = datastore.prepare(query1).asList(FetchOptions.Builder.withLimit(10));
	    model.addAttribute("barraList", barra);
	    
	    return "frmReporteVentas";
	}	
	
	@RequestMapping(value = { "/reporte/ventas" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public @ResponseBody ModelMap reporteGeneral(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession(false);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		//ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima")); 
		
		String fecha = request.getParameter("fecha");
		String barra = request.getParameter("barra");
		String usuario = request.getParameter("usuario");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("ProductoVenta").addSort("codigoBarra", Query.SortDirection.ASCENDING);
		query.addFilter("fechaventa", Query.FilterOperator.EQUAL, fecha);
		if(!"".equalsIgnoreCase(barra)) {
			query.addFilter("codigoBarra", Query.FilterOperator.EQUAL, barra);
		}
		if(!"".equalsIgnoreCase(usuario)) {
		   query.addFilter("usuarioventa", Query.FilterOperator.EQUAL, usuario);   
		}
	    List<Entity> productoVenta = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
		model.addAttribute("productoVentaList", productoVenta);
		return model;
	}	
}