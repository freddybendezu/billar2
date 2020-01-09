package pe.com.suriados;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;

@Controller
@RequestMapping({"/ventas"})
public class VentasController {

	
	@RequestMapping(value={"/list"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	  public String listaVentas(ModelMap model)
	  {
	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Query query = new Query("Ventas").addSort("ventas", Query.SortDirection.ASCENDING);
	    List<Entity> reporteVentas = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

	    model.addAttribute("reporteVentas", reporteVentas);

	    return "frmReporteVentas";
	  }
}