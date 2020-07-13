package pe.com.suriados.productos;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/productoBarra"})
public class ProductoBarraController
{
  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView update(HttpServletRequest request, ModelMap model)
  {
    String barra = request.getParameter("barra");
    String persona = request.getParameter("persona");

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("BarraPersona");
    query.addFilter("barra", Query.FilterOperator.EQUAL, barra);
    PreparedQuery pq = datastore.prepare(query);
    Entity barraPersona = pq.asSingleEntity();

    if (barraPersona == null) {
      Key productoKey = KeyFactory.createKey("BarraPersona", barra);
      Entity barraPersona1 = new Entity("BarraPersona", productoKey);
      barraPersona1.setProperty("barra", barra);
      barraPersona1.setProperty("persona", persona);
      datastore.put(barraPersona1);
    } else {
      barraPersona.setProperty("barra", barra);
      barraPersona.setProperty("persona", persona);
      datastore.put(barraPersona);
    }

    return new ModelAndView("redirect:list");
  }

  @RequestMapping(value={"/listUpdate"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String listUpdateBarraPersona(ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
    List<Entity> barra = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

    Query query1 = new Query("Persona").addSort("nombres", Query.SortDirection.DESCENDING);
    List<Entity> persona = datastore.prepare(query1).asList(FetchOptions.Builder.withLimit(10));

    model.addAttribute("personaList", persona);
    model.addAttribute("barraList", barra);

    return "frmBarraPersonaUpdate";
  }

  @RequestMapping(value={"/list"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String listaBarraProducto(ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("ProductoBarra").addSort("codigoBarra", Query.SortDirection.DESCENDING);
    List<Entity> productoBarraList = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    model.addAttribute("productoBarraList", productoBarraList);

    
    Query query1 = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
    List<Entity> barra = datastore.prepare(query1).asList(FetchOptions.Builder.withLimit(10));
    model.addAttribute("barraList", barra);
    
    return "frmProductoBarraList";
  }
  
  @RequestMapping(value = { "/barra/producto" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public @ResponseBody ModelMap ProductoBarra(HttpServletRequest request, ModelMap model) {
		
	  String codigoBarra = request.getParameter("codigoBarra");
		
	   DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	   
	   
	   System.out.println(codigoBarra);
	    Query query = new Query("ProductoBarra").addSort("codigoBarra", Query.SortDirection.DESCENDING);
	    query.addFilter("codigoBarra", Query.FilterOperator.EQUAL, codigoBarra);
	    List<Entity> productoBarraList = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
	    
	    model.addAttribute("productoBarraList", productoBarraList);
		
	   
		
	   
		
	   
		return model;
	}	
  
}