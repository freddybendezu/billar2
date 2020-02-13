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
@RequestMapping({ "/billarprecio" })
public class BillarPreciosController {
	@RequestMapping(value = { "/update/{id}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String getUpdatePrecio(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		Key key = KeyFactory.createKey("Billarprecio", Long.parseLong(id));
		Entity billarprecio;
		try {
			billarprecio = datastore.get(key);
			model.addAttribute("billarprecio", billarprecio);
		} catch (EntityNotFoundException e) {
			billarprecio = new Entity("Billarprecio", Long.parseLong(id));
			datastore.put(billarprecio);
			model.addAttribute("billarprecio", billarprecio);
		}

		return "frmBillarPrecioUpdate";
	}

	@RequestMapping(value = { "/update" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String id = request.getParameter("id");
		
		String precio0 = request.getParameter("precio0");
		String precio1 = request.getParameter("precio1");
		String precio2 = request.getParameter("precio2");
		String precio3 = request.getParameter("precio3");
		String precio4 = request.getParameter("precio4");
		String precio5 = request.getParameter("precio5");
		String precio6 = request.getParameter("precio6");
		String precio7 = request.getParameter("precio7");
		String precio8 = request.getParameter("precio8");
		String precio9 = request.getParameter("precio9");
		String precio10 = request.getParameter("precio10");
		String precio11 = request.getParameter("precio11");
		String precio12 = request.getParameter("precio12");
		String precio13 = request.getParameter("precio13");
		String precio14 = request.getParameter("precio14");
		String precio15 = request.getParameter("precio15");
		String precio16 = request.getParameter("precio16");
		String precio17 = request.getParameter("precio17");
		String precio18 = request.getParameter("precio18");
		String precio19 = request.getParameter("precio19");
		String precio20 = request.getParameter("precio20");
		String precio21 = request.getParameter("precio21");
		String precio22 = request.getParameter("precio22");
		String precio23 = request.getParameter("precio23");

	
		String numerohorasdescuento = request.getParameter("numerohorasdescuento");
		String porcentajedescuento = request.getParameter("porcentajedescuento");
		String preciounitariotaco = request.getParameter("preciounitariotaco");

		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
		String fecha = hourdateFormat.format(date);

		Entity billarprecio = new Entity("Billarprecio", Long.parseLong(id));
		
		
		billarprecio.setProperty("precio0", precio0);
		billarprecio.setProperty("precio1", precio1);
		billarprecio.setProperty("precio2", precio2);
		billarprecio.setProperty("precio3", precio3);
		billarprecio.setProperty("precio4", precio4);
		billarprecio.setProperty("precio5", precio5);
		billarprecio.setProperty("precio6", precio6);
		billarprecio.setProperty("precio7", precio7);
		billarprecio.setProperty("precio8", precio8);
		billarprecio.setProperty("precio9", precio9);
		billarprecio.setProperty("precio10", precio10);
		billarprecio.setProperty("precio11", precio11);
		billarprecio.setProperty("precio12", precio12);
		billarprecio.setProperty("precio13", precio13);
		billarprecio.setProperty("precio14", precio14);
		billarprecio.setProperty("precio15", precio15);
		billarprecio.setProperty("precio16", precio16);
		billarprecio.setProperty("precio17", precio17);
		billarprecio.setProperty("precio18", precio18);
		billarprecio.setProperty("precio19", precio19);
		billarprecio.setProperty("precio20", precio20);
		billarprecio.setProperty("precio21", precio21);
		billarprecio.setProperty("precio22", precio22);
		billarprecio.setProperty("precio23", precio23);


		billarprecio.setProperty("numerohorasdescuento", numerohorasdescuento);
		billarprecio.setProperty("porcentajedescuento", porcentajedescuento);
		billarprecio.setProperty("preciounitariotaco", preciounitariotaco);
		billarprecio.setProperty("fecha", fecha);

		datastore.put(billarprecio);

		return new ModelAndView("redirect:../billar/billarmesalist");
	}
}
