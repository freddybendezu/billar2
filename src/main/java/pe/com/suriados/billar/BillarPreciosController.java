package pe.com.suriados.billar;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@Controller
@RequestMapping({"/billarprecio"})
public class BillarPreciosController {
	  @RequestMapping(value={"/update/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	  public String getUpdatePrecio(@PathVariable String id, HttpServletRequest request, ModelMap model)
	  {
	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

	    Key key = KeyFactory.createKey("Billarprecio", Long.parseLong(id));
	    Entity billarprecio;
	    try
	    {
	    	billarprecio = datastore.get(key);
	    	model.addAttribute("billarprecio", billarprecio);
	    } catch (EntityNotFoundException e) {
	    	billarprecio = new Entity("Billarprecio", Long.parseLong(id));
	    	datastore.put(billarprecio);
	    	model.addAttribute("billarprecio", billarprecio);
	    }

	    return "frmBillarPrecioUpdate";
	  }

	  @RequestMapping(value={"/update"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	  public ModelAndView update(HttpServletRequest request, ModelMap model)
	  {
	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    String id = request.getParameter("id");
	    String horainicionormal = request.getParameter("horainicionormal");
	    String horafinnormal = request.getParameter("horafinnormal");
	    String precionormal = request.getParameter("precionormal");
	    String incremento = request.getParameter("incremento");
	    String numerohorasdescuento = request.getParameter("numerohorasdescuento");
	    String porcentajedescuento = request.getParameter("porcentajedescuento");
	    String preciounitariotaco = request.getParameter("preciounitariotaco");
	    
	    	    
	    Date date = new Date();
	    DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
	    String fecha = hourdateFormat.format(date);

	    Entity billarprecio = new Entity("Billarprecio", Long.parseLong(id));

	    billarprecio.setProperty("horainicionormal", horainicionormal);
	    billarprecio.setProperty("horafinnormal", horafinnormal);
	    billarprecio.setProperty("precionormal", precionormal);
	    billarprecio.setProperty("incremento", incremento);
	    billarprecio.setProperty("numerohorasdescuento", numerohorasdescuento);
	    billarprecio.setProperty("porcentajedescuento", porcentajedescuento);
	    billarprecio.setProperty("preciounitariotaco", preciounitariotaco);    
	    billarprecio.setProperty("fecha", fecha);

	    datastore.put(billarprecio);

	    return new ModelAndView("redirect:../billar/billarmesalist");
	  }
}
