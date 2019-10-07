package pe.com.suriados.billar;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;

@Controller
@RequestMapping({ "/billarreporte" })
public class BillarReportesController {

	@RequestMapping(value = { "/list" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String listaBarraProducto(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession(false);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima")); 
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Billar").addSort("fin", Query.SortDirection.ASCENDING);
	    query.addFilter("fecha", Query.FilterOperator.EQUAL, fechaActual.format(formatter));
	    query.addFilter("usuario", Query.FilterOperator.EQUAL, session.getAttribute("usuario"));
		
	    List<Entity> billarlist = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
		model.addAttribute("billarlist", billarlist);
		return "frmBillarReporteList";
	}

}
