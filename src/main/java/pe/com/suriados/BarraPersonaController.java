package pe.com.suriados;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/barraPersona"})
public class BarraPersonaController
{
  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView update(HttpServletRequest request, ModelMap model)
  {
    String barra = request.getParameter("codigoBarra");
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
  public String listaBarraPersona(ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("BarraPersona").addSort("barra", Query.SortDirection.DESCENDING);
    List<Entity> barraPersona = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

    model.addAttribute("barraPersonaList", barraPersona);

    return "frmBarraPersonaList";
  }
}