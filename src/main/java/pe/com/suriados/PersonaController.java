package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/persona"})
public class PersonaController
{
  @RequestMapping(value={"/frmPersona"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getAddCustomerPage(ModelMap model)
  { 	
	  DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	  
	  Query query = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
	  List<Entity> barra = ds.prepare(query).asList(FetchOptions.Builder.withDefaults());
	    
	  model.addAttribute("barraList",  barra);
    return "frmPersonaAdd";
  }

  @RequestMapping(value={"/add"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView add(HttpServletRequest request, ModelMap model)
  {

	
    String dni = request.getParameter("dni");
    String contrasena = request.getParameter("contrasena");
    String nombres = request.getParameter("nombres");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String responsabilidad = request.getParameter("responsabilidad");
    String tienda = request.getParameter("tienda");

    Date date = new Date();
    DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
    String fecha = hourdateFormat.format(date);

    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
    Entity persona = new Entity("Persona", Long.parseLong(dni));

    persona.setProperty("contrasena", contrasena);
    persona.setProperty("nombres", nombres);
    persona.setProperty("direccion", direccion);
    persona.setProperty("telefono", telefono);
    persona.setProperty("fecha", fecha);
    persona.setProperty("responsabilidad", responsabilidad);
    persona.setProperty("tienda", tienda);

    ds.put(persona);

    return new ModelAndView("redirect:list");
  }

  @RequestMapping(value={"/update/{dni}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getUpdateCustomerPage(@PathVariable String dni, HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
  
	  Query query = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
	  List<Entity> barra = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
	 
    Key key = KeyFactory.createKey("Persona", Long.parseLong(dni));
    try
    {
      Entity persona = datastore.get(key);
      model.addAttribute("persona", persona);
    } catch (EntityNotFoundException e) {
      e.printStackTrace();
    }
    
    model.addAttribute("barraList",  barra);
    return "frmPersonaUpdate";
  }

  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView update(HttpServletRequest request, ModelMap model)
  {
	  DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	  
    String dni = request.getParameter("dni");
    String contrasena = request.getParameter("contrasena");
    String nombres = request.getParameter("nombres");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String responsabilidad = request.getParameter("responsabilidad");
    String tienda = request.getParameter("tienda");
    
    Date date = new Date();
    DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
    String fecha = hourdateFormat.format(date);

    Entity persona = new Entity("Persona", Long.parseLong(dni));

    persona.setProperty("contrasena", contrasena);
    persona.setProperty("nombres", nombres);
    persona.setProperty("direccion", direccion);
    persona.setProperty("telefono", telefono);
    persona.setProperty("fecha", fecha);
    persona.setProperty("responsabilidad", responsabilidad);
    persona.setProperty("tienda", tienda);

    datastore.put(persona);

    return new ModelAndView("redirect:list");
  }

  @RequestMapping(value={"/delete/{dni}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public ModelAndView delete(@PathVariable String dni, HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key key = KeyFactory.createKey("Persona", Long.parseLong(dni));
    datastore.delete(new Key[] { key });

    return new ModelAndView("redirect:../list");
  }

  @RequestMapping(value={"/list"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String listCustomer(ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Persona").addSort("fecha", Query.SortDirection.DESCENDING);
    List<Entity> persona = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
    
 
    model.addAttribute("personaList", persona);
   
    return "frmPersonaList";
  }
}