package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/precioPolitica"})
public class PrecioPoliticaController
{
  @RequestMapping(value={"/update/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getUpdatePrecio(@PathVariable String id, HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key key = KeyFactory.createKey("PrecioPolitica", Long.parseLong(id));
    Entity precioPolitica;
    try
    {
      precioPolitica = datastore.get(key);
      model.addAttribute("precioPolitica", precioPolitica);
    } catch (EntityNotFoundException e) {
      precioPolitica = new Entity("PrecioPolitica", Long.parseLong(id));
      datastore.put(precioPolitica);
      model.addAttribute("precioPolitica", precioPolitica);
    }

    return "frmPrecioPoliticaUpdate";
  }

  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public ModelAndView update(HttpServletRequest request, ModelMap model)
  {
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    String id = request.getParameter("id");
    String lun = request.getParameter("lun");
    String mar = request.getParameter("mar");
    String mie = request.getParameter("mie");
    String jue = request.getParameter("jue");
    String vie = request.getParameter("vie");
    String sab = request.getParameter("sab");
    String dom = request.getParameter("dom");

    Date date = new Date();
    DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
    String fecha = hourdateFormat.format(date);

    Entity precioPolitica = new Entity("PrecioPolitica", Long.parseLong(id));

    precioPolitica.setProperty("lun", lun);
    precioPolitica.setProperty("mar", mar);
    precioPolitica.setProperty("mie", mie);
    precioPolitica.setProperty("jue", jue);
    precioPolitica.setProperty("vie", vie);
    precioPolitica.setProperty("sab", sab);
    precioPolitica.setProperty("dom", dom);
    precioPolitica.setProperty("fecha", fecha);

    datastore.put(precioPolitica);

    return new ModelAndView("redirect:/producto/list");
  }
}