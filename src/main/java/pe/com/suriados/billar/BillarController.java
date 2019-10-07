package pe.com.suriados.billar;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;


@Controller
@RequestMapping({ "/billar" })
public class BillarController {

	@RequestMapping(value = { "/billarmesaadd" }, method = {
			org.springframework.web.bind.annotation.RequestMethod.GET })
	public String getAddBillarMesa(ModelMap model) {
		return "frmBillarMesaAdd";
	}
	
	@RequestMapping(value = { "/list" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String list(ModelMap model, HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
	    if(session.getAttribute("usuario") == null){
	  		return "redirect:/";
	    }

		
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Billarmesa").addSort("numero", Query.SortDirection.ASCENDING);
		List<Entity> billarmesa = ds.prepare(query).asList(FetchOptions.Builder.withDefaults());
		String estado;
		Entity temporal;
		List<Entity> billarlist = new ArrayList<Entity>();
		try {
			for (Entity e : billarmesa) {
				estado = e.getProperty("estado").toString();
				temporal = new Entity("Temporal");
				if ("ocupado".equalsIgnoreCase(estado)) {
					Key key = KeyFactory.createKey("Billar", Long.parseLong(e.getProperty("codigo").toString()));
					Entity billar = ds.get(key);

					temporal.setProperty("id", e.getKey().getId());
					temporal.setProperty("estado", "ocupado");
					temporal.setProperty("numero", e.getProperty("numero"));
					temporal.setProperty("codigo", billar.getKey().getId());
					temporal.setProperty("inicio", billar.getProperty("inicio"));
					temporal.setProperty("tiempo", billar.getProperty("tiempo"));
					temporal.setProperty("precio", billar.getProperty("preciohoranormal"));
					temporal.setProperty("taco", billar.getProperty("taco"));
				} else {
					temporal.setProperty("id", e.getKey().getId());
					temporal.setProperty("estado", "libre");
					temporal.setProperty("numero", e.getProperty("numero"));
					temporal.setProperty("codigo", "");
					temporal.setProperty("inicio", "");
					temporal.setProperty("tiempo", "");
					temporal.setProperty("precio", "");
					temporal.setProperty("taco", "");
				}
				billarlist.add(temporal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("billarmesalist", billarlist);
		return "frmBillarList";
	}

	@RequestMapping(value = { "/billarmesalist" }, method = {
			org.springframework.web.bind.annotation.RequestMethod.GET })
	public String billarmesalist(ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Billarmesa").addSort("numero", Query.SortDirection.ASCENDING);
		List<Entity> billarmesalist = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());

		model.addAttribute("billarmesalist", billarmesalist);

		return "frmBillarMesaList";
	}

	@RequestMapping(value = { "/alquilar" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<String> alquilar(HttpServletRequest request, ModelMap model) {
		// String codigo = request.getParameter("codigo");
		String mesa = request.getParameter("mesa");
		String inicio = request.getParameter("inicio");
		String tiempo = request.getParameter("tiempo");
		String precio = request.getParameter("precio");
		String taco = request.getParameter("taco");
		String mesanumeroorden = request.getParameter("mesanumeroorden");
		String preciotaco = "10";
		String total = "0";
		String estado = request.getParameter("estado");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));
		
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Entity billar = new Entity("Billar");

		try {
			HttpSession sesion = request.getSession();
			Object usuario = (String) sesion.getAttribute("usuario");
			
			billar.setProperty("usuario", usuario);
			billar.setProperty("tiempo", tiempo);
			billar.setProperty("fin", "");
			billar.setProperty("inicio", inicio);
			billar.setProperty("minutosnormal", "");
			billar.setProperty("minutosincremento", "");
			billar.setProperty("minutostotal", "");
			billar.setProperty("montonormal", "");
			billar.setProperty("montoincremento", "");
			billar.setProperty("montotaco", preciotaco);
			billar.setProperty("descuento", "");
			billar.setProperty("montototal", 0);
			billar.setProperty("mesanumero", mesa);
			billar.setProperty("mesanumeroorden", mesanumeroorden);
			billar.setProperty("taco", taco);
			billar.setProperty("estado", estado);
			billar.setProperty("incremento", "");
			billar.setProperty("preciotaco", "");
			billar.setProperty("preciohoranormal", "");
			billar.setProperty("fecha", fechaActual.format(formatter));
			ds.put(billar);

			Key key = KeyFactory.createKey("Billarmesa", Long.parseLong(mesa));
			Entity billarmesa = ds.get(key);

			billarmesa.setProperty("estado", "ocupado");
			billarmesa.setProperty("codigo", billar.getKey().getId());
			ds.put(billarmesa);

		} catch (Exception e) {

		} finally {

		}

		model.addAttribute("billarList", billar);
		List<String> response = new ArrayList<String>();

		response.add(billar.getKey().getId() + "");
		// return new ModelAndView("redirect:list");
		return response;
	}
	
	
	@RequestMapping(value = { "/tacos" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<String> tacos(HttpServletRequest request, ModelMap model) {
		String codigo = request.getParameter("codigo");
		String taco = request.getParameter("taco");
		
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

		try {

			Key key = KeyFactory.createKey("Billar", Long.parseLong(codigo));
			Entity billar = ds.get(key);

			billar.setProperty("taco", taco);
			ds.put(billar);

		} catch (Exception e) {

		} finally {

		}

		List<String> response = new ArrayList<String>();

		response.add("exito");
		// return new ModelAndView("redirect:list");
		return response;
	}	
	

	@RequestMapping(value = { "/result" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public String result(HttpServletRequest request, ModelMap model) {
		DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
		simbolos.setDecimalSeparator('.');
		DecimalFormat decimalFormato = new DecimalFormat("####0.0",simbolos);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		Key key = KeyFactory.createKey("Billar", Long.parseLong(request.getParameter("codigo")));
		try {
			Entity billar = datastore.get(key);

			key = KeyFactory.createKey("Billarprecio", Long.parseLong(billar.getProperty("mesanumero").toString()));
			Entity billarprecio = datastore.get(key);
			// System.out.println("precio: " + billarprecio.getProperty("h1"));
			String tiempo1 = request.getParameter("tiempo");
			String horainicio = billar.getProperty("inicio").toString();
			String preciohoranormal = billarprecio.getProperty("precionormal").toString();
			int horaInicioNormalMesa = Integer.parseInt(billarprecio.getProperty("horainicionormal").toString());
			int horaFinalNormalMesa = Integer.parseInt(billarprecio.getProperty("horafinnormal").toString());
			String montoIncrementoMesa = billarprecio.getProperty("incremento").toString();
			String numeroHorasParaDescuento = billarprecio.getProperty("numerohorasdescuento").toString();
			String porcentajeDescuento = billarprecio.getProperty("porcentajedescuento").toString();
			String precioUnitarioTaco = billarprecio.getProperty("preciounitariotaco").toString();
			String taco = request.getParameter("taco");
			
			Date tiempocurso = new SimpleDateFormat("HH:mm:ss").parse(tiempo1);			
			Date fechaInicio = new SimpleDateFormat("MMMMM yyyy dd HH:mm:ss", new Locale("en")).parse(horainicio);

			
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima")); 
			
			
			List<String> res = calcularMontos(tiempocurso.getHours()+"", tiempocurso.getMinutes()+"", fechaInicio, taco, precioUnitarioTaco,
					preciohoranormal, porcentajeDescuento, numeroHorasParaDescuento, montoIncrementoMesa,
					horaInicioNormalMesa, horaFinalNormalMesa);
			
			billar.setProperty("tiempo", tiempo1);
			billar.setProperty("fin", fechaActual.format(formatter));
			//billar.setProperty("inicio", fechaInicio);
			billar.setProperty("minutosnormal", res.get(0));
			billar.setProperty("minutosincremento", res.get(1));
			billar.setProperty("minutostotal", res.get(4));
			billar.setProperty("montonormal", res.get(2));
			billar.setProperty("montoincremento", res.get(3));
			billar.setProperty("montotaco", decimalFormato.format(Double.parseDouble(res.get(5))));
			billar.setProperty("descuento", decimalFormato.format(Double.parseDouble(res.get(6))));
			//billar.setProperty("montototal", res.get(7));
			billar.setProperty("incremento", decimalFormato.format(Double.parseDouble(montoIncrementoMesa)));
			billar.setProperty("preciotaco", decimalFormato.format(Double.parseDouble(precioUnitarioTaco)));
			billar.setProperty("taco", taco);
			billar.setProperty("preciohoranormal", decimalFormato.format(Double.parseDouble(preciohoranormal)));
			
			datastore.put(billar);
			billar.setProperty("montototal", res.get(7));
			model.addAttribute("billar", billar);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "frmBillarResult";
	}

	@RequestMapping(value = { "/confirmar" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<String> confirmar(HttpServletRequest request, ModelMap model) {
		String codigo = request.getParameter("codigo");
		String mesanumero = request.getParameter("mesanumero");
		
		String tiempo = request.getParameter("tiempo");
		String inicio = request.getParameter("inicio");
		String fin = request.getParameter("precio");
		String minutosnormal = request.getParameter("taco");
		String minutosincremento = request.getParameter("preciotaco");
		String minutostotal = request.getParameter("total");
		String montonormal = request.getParameter("total");
		String montoincremento = request.getParameter("total");
		String montotaco = request.getParameter("total");
		String descuento = request.getParameter("total");
		String montototal = request.getParameter("montototal");
		String taco = request.getParameter("total");
		String incremento = request.getParameter("total");
		String preciotaco = request.getParameter("total");
		String preciohoranormal = request.getParameter("total");
		String estado = "libre";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		HttpSession sesion = request.getSession();
		Object usuario = (String) sesion.getAttribute("usuario");
		
		try {
			Key key = KeyFactory.createKey("Billar", Long.parseLong(codigo));
			Entity billar = ds.get(key);

			billar.setProperty("tiempo", tiempo);
			billar.setProperty("taco", taco);
			billar.setProperty("montototal", montototal);
			billar.setProperty("estado", "finalizado");
			billar.setProperty("fecha", fechaActual.format(formatter));
			billar.setProperty("usuario", usuario);
			
			ds.put(billar);
			System.out.println("mesa: ");
			key = KeyFactory.createKey("Billarmesa", Long.parseLong(mesanumero));
			Entity billarmesa = ds.get(key);
			billarmesa.setProperty("codigo", "");
			billarmesa.setProperty("estado", "libre");
			ds.put(billarmesa);

		} catch (Exception e) {
			e.printStackTrace();
		}

		List<String> response = new ArrayList<String>();

		response.add("exito");
		return response;
	}

	@RequestMapping(value = { "/add" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String numero = request.getParameter("numero");
		String descripcion = request.getParameter("descripcion");

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Entity mesa = new Entity("Billarmesa");

		mesa.setProperty("numero", numero);
		mesa.setProperty("descripcion", descripcion);
		mesa.setProperty("estado", "libre");
		mesa.setProperty("codigo", "");

		ds.put(mesa);

		return new ModelAndView("redirect:billarmesalist");
	}

	private List<String> calcularMontos(String hora, String min, Date horainicio, String taco,
			String precioUnitarioTaco, String precioUnitarioMesa, String porcentajeDescuento,
			String numeroHorasParaDescuento, String montoIncrementoMesa, int horaInicioNormalMesa,
			int horaFinalNormalMesa) {
//		java.util.Calendar fecha = java.util.Calendar.getInstance();
//		int horaActual = fecha.get(java.util.Calendar.HOUR_OF_DAY);

		ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima")); 
		int horaActual = fechaActual.getHour();
		
		int minutosTotal = 0;
		int minutosNormal = 0;
		int minutosIncremento = 0;
		double montoNormal = 0;
		double montoIncremento = 0;
		double montoTaco = 0;
		double descuento = 0;
		double montoTotal = 0;
		DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
		simbolos.setDecimalSeparator('.');
		DecimalFormat decimalFormato = new DecimalFormat("####0.0", simbolos);

		if (horaActual >= horaInicioNormalMesa && horaActual < horaFinalNormalMesa) {
			minutosNormal = (Integer.parseInt(hora) * 60) + Integer.parseInt(min);
		} else {

			if (Integer.parseInt(hora) > 0) {
				minutosTotal = (Integer.parseInt(hora) * 60) + Integer.parseInt(min);
				
			} else {
				minutosTotal = Integer.parseInt(min);
				
			}


			if (horainicio.getHours() < horaFinalNormalMesa && horainicio.getHours() >= horaInicioNormalMesa) {
				minutosNormal = ((horaFinalNormalMesa - horainicio.getHours()) * 60) - horainicio.getMinutes();
				
			}

			minutosIncremento = minutosTotal - minutosNormal;
			

			montoIncremento = ((Double.parseDouble(precioUnitarioMesa) + Double.parseDouble(montoIncrementoMesa)) / 60)
					* minutosIncremento;

		}

		montoNormal = (Double.parseDouble(precioUnitarioMesa) / 60) * minutosNormal;
		
		montoTaco = Double.parseDouble(precioUnitarioTaco) * Double.parseDouble(taco);
		
		if (Integer.parseInt(hora) >= Integer.parseInt(numeroHorasParaDescuento)) {
			descuento = ((montoNormal + montoIncremento) * Double.parseDouble(porcentajeDescuento)) / 100;
			
		}
		montoTotal = montoNormal + montoIncremento + montoTaco - descuento;
		
		List<String> montos = new ArrayList<String>();
		
		
		//redondeo de 1.2 a 1.0 o de 1.3 a 1.5
		double mt = Math.round(montoTotal * 2) / 2.0;
		double mi = Math.round(montoIncremento * 2) / 2.0;
		double mn = Math.round(montoNormal * 2) / 2.0;
		
		
		montos.add(minutosNormal + "");
		montos.add(minutosIncremento + "");
		montos.add(mn + "");
		montos.add(mi + "");
		montos.add(minutosTotal + "");
		montos.add(montoTaco + "");
		montos.add(descuento + "");
		montos.add(mt + "");
		return montos;
	}

}
