package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.FetchOptions.Builder;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/barra"})
public class BarraController
{
  @RequestMapping(value={"/frmBarra"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getAddCustomerPage(ModelMap model)
  {
    return "frmBarraAdd";
  }

  @RequestMapping(value={"/add"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView add(HttpServletRequest request, ModelMap model)
  {
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");

    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
    Entity barra = new Entity("Barra");
    barra.setProperty("nombre", nombre);
    barra.setProperty("descripcion", descripcion);

    ds.put(barra);

    return new ModelAndView("redirect:list");
  }

  @RequestMapping(value={"/update/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getUpdateCustomerPage(@PathVariable String id, HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key key = KeyFactory.createKey("Barra", Long.parseLong(id));
    try {
      Entity barra = datastore.get(key);
      model.addAttribute("barra", barra);
    } catch (EntityNotFoundException e) {
      e.printStackTrace();
    }

    return "frmBarraUpdate";
  }

  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView update(HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");

    Entity barra = new Entity("Barra", Long.parseLong(id));
    barra.setProperty("nombre", nombre);
    barra.setProperty("descripcion", descripcion);

    datastore.put(barra);
    return new ModelAndView("redirect:list");
  }

  @RequestMapping(value={"/delete/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public ModelAndView delete(@PathVariable String id, HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key key = KeyFactory.createKey("Barra", Long.parseLong(id));
    datastore.delete(new Key[] { key });

    return new ModelAndView("redirect:../list");
  }

  @RequestMapping(value={"/list"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String listBarra(ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
    List<Entity> barra = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

    model.addAttribute("barraList", barra);

    return "frmBarraList";
  }
}