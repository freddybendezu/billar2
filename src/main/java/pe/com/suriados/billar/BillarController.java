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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
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
		if (session.getAttribute("usuario") == null) {
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

					SimpleDateFormat formatoEntrada = new SimpleDateFormat("MMMM yyyy d HH:mm:ss", Locale.ENGLISH);
					SimpleDateFormat formatoSalida = new SimpleDateFormat("HH:mm:ss");
					Date date = formatoEntrada.parse(billar.getProperty("inicio").toString());
					String horainicio = formatoSalida.format(date);
					temporal.setProperty("horainicio", horainicio);
					temporal.setProperty("tiempo", billar.getProperty("tiempo"));
					temporal.setProperty("precio", billar.getProperty("preciohoranormal"));
					temporal.setProperty("taco", billar.getProperty("taco"));
				} else {
					temporal.setProperty("id", e.getKey().getId());
					temporal.setProperty("estado", "libre");
					temporal.setProperty("numero", e.getProperty("numero"));
					temporal.setProperty("codigo", "");
					temporal.setProperty("inicio", "");
					temporal.setProperty("horainicio", "");
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

	/*
	 * Controlador de reporte de ventas
	 * 
	 * @RequestMapping (value= {"/reporteventas"}, method=
	 * {org.springframework.web.bind.annotation.RequestMethod.POST})
	 * 
	 * @ResponseBody public List<String> reporteventas(HttpServletRequest request,
	 * ModelMap model){ Entity ventas = new Entity ("Ventas") }
	 */

	@RequestMapping(value = { "/alquilar" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<String> alquilar(HttpServletRequest request, ModelMap model) {
		// String codigo = request.getParameter("codigo");

		Entity billar = new Entity("Billar");
		try {
			HttpSession sesion = request.getSession();
			Object usuario = (String) sesion.getAttribute("usuario");

			String mesa = request.getParameter("mesa");

			String inicio = request.getParameter("inicio");

			String tiempo = request.getParameter("tiempo");

			String precio = request.getParameter("precio");

			String taco = request.getParameter("taco");
			String mesanumeroorden = request.getParameter("mesanumeroorden");
			String preciotaco = "0";
			String total = "0";
			String estado = request.getParameter("estado");
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));

			DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

			billar.setProperty("usuario", usuario);
			billar.setProperty("tiempo", tiempo);
			billar.setProperty("fin", "");
			billar.setProperty("inicio", inicio);

			SimpleDateFormat formatoEntrada = new SimpleDateFormat("MMMM yyyy d HH:mm:ss", Locale.ENGLISH);
			SimpleDateFormat formatoSalida = new SimpleDateFormat("HH:mm:ss");
			Date date = formatoEntrada.parse(inicio);
			String horainicio = formatoSalida.format(date);
			billar.setProperty("horainicio", horainicio);

			billar.setProperty("minutosnormal", 0);
			billar.setProperty("minutosincremento", 0);
			billar.setProperty("minutostotal", 0);
			billar.setProperty("montonormal", 0);
			billar.setProperty("montoincremento", 0);
			billar.setProperty("montotaco", preciotaco);
			billar.setProperty("descuento", 0);
			billar.setProperty("montototal", 0);
			billar.setProperty("mesanumero", mesa);
			billar.setProperty("mesanumeroorden", mesanumeroorden);
			billar.setProperty("taco", taco);
			billar.setProperty("estado", estado);
			billar.setProperty("incremento", 0);
			billar.setProperty("preciotaco", 0);
			billar.setProperty("preciohoranormal", 0);
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



	@RequestMapping(value = { "/total" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public String total(HttpServletRequest request, ModelMap model) {
		DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
		simbolos.setDecimalSeparator('.');
		DecimalFormat decimalFormato = new DecimalFormat("####0.0", simbolos);

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String response = null;
		Key key = KeyFactory.createKey("Billar", Long.parseLong(request.getParameter("codigo")));
		try {
			Entity billar = datastore.get(key);

			key = KeyFactory.createKey("Billarprecio", Long.parseLong(billar.getProperty("mesanumero").toString()));
			Entity billarprecio = datastore.get(key);
			// System.out.println("precio: " + billarprecio.getProperty("h1"));
			String tiempo1 = request.getParameter("tiempo");
			String horainicio = billar.getProperty("inicio").toString();
			// String preciohora = billarprecio.getProperty("precionormal").toString();
			// int horaInicioNormalMesa =
			// Integer.parseInt(billarprecio.getProperty("horainicionormal").toString());
			// int horaFinalNormalMesa =
			// Integer.parseInt(billarprecio.getProperty("horafinnormal").toString());
//			String montoIncrementoMesa = billarprecio.getProperty("incremento").toString();
			String numeroHorasParaDescuento = billarprecio.getProperty("numerohorasdescuento").toString();
			String porcentajeDescuento = billarprecio.getProperty("porcentajedescuento").toString();
			String precioUnitarioTaco = billarprecio.getProperty("preciounitariotaco").toString();
			String cantidadTacos = request.getParameter("taco");

			Date tiempocurso = new SimpleDateFormat("HH:mm:ss").parse(tiempo1);
			Date fechaInicio = new SimpleDateFormat("MMMMM yyyy dd HH:mm:ss", new Locale("en")).parse(horainicio);

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));

//			List<String> res = calcularMontos(tiempocurso.getHours() + "", tiempocurso.getMinutes() + "", fechaInicio,
//					taco, precioUnitarioTaco, preciohora, porcentajeDescuento, numeroHorasParaDescuento,
//					montoIncrementoMesa, horaInicioNormalMesa, horaFinalNormalMesa);

			List<String> res = calcularTotal(fechaInicio, fechaActual, request.getParameter("codigo").toString(),
					Integer.parseInt(request.getParameter("taco")), tiempocurso);

			billar.setProperty("tiempo", tiempo1);
			billar.setProperty("fin", fechaActual.format(formatter));
			// billar.setProperty("inicio", fechaInicio);
			// billar.setProperty("minutosnormal", res.get(0));
			// billar.setProperty("minutosincremento", res.get(1));
			// billar.setProperty("minutostotal", res.get(4));
			// billar.setProperty("montonormal", res.get(2));
			// billar.setProperty("montoincremento", res.get(3));
			billar.setProperty("montotaco", decimalFormato.format(Double.parseDouble(res.get(1))));
			billar.setProperty("descuento", decimalFormato.format(Double.parseDouble(res.get(2))));
			// billar.setProperty("montototal", res.get(7));
			// billar.setProperty("incremento",
			// decimalFormato.format(Double.parseDouble(montoIncrementoMesa)));
			billar.setProperty("preciotaco", decimalFormato.format(Double.parseDouble(precioUnitarioTaco)));
			billar.setProperty("taco", cantidadTacos);
			// billar.setProperty("preciohora",
			// decimalFormato.format(Double.parseDouble(preciohora)));

			datastore.put(billar);
			billar.setProperty("montototal", res.get(0));
			model.addAttribute("billar", billar);
			response = res.get(0);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return response;
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
		String taco = request.getParameter("taco");
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

	@RequestMapping(value = { "/delete/{id}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public ModelAndView delete(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		Key key = KeyFactory.createKey("Billarmesa", Long.parseLong(id));
		datastore.delete(new Key[] { key });
		return new ModelAndView("redirect:../billarmesalist");
	}


	@RequestMapping(value = { "/result" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public String result(HttpServletRequest request, ModelMap model) {
		DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
		simbolos.setDecimalSeparator('.');
		DecimalFormat decimalFormato = new DecimalFormat("####0.0", simbolos);

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String response = null;
		Key key = KeyFactory.createKey("Billar", Long.parseLong(request.getParameter("codigo")));
		try {
			Entity billar = datastore.get(key);

			key = KeyFactory.createKey("Billarprecio", Long.parseLong(billar.getProperty("mesanumero").toString()));
			Entity billarprecio = datastore.get(key);
			// System.out.println("precio: " + billarprecio.getProperty("h1"));

			String tiempo1 = request.getParameter("tiempo");
			String horainicio = billar.getProperty("inicio").toString();

			// String preciohora = billarprecio.getProperty("precionormal").toString();
			// int horaInicioNormalMesa =
			// Integer.parseInt(billarprecio.getProperty("horainicionormal").toString());
			// int horaFinalNormalMesa =
			// Integer.parseInt(billarprecio.getProperty("horafinnormal").toString());
			// String montoIncrementoMesa =
			// billarprecio.getProperty("incremento").toString();
			String numeroHorasParaDescuento = billarprecio.getProperty("numerohorasdescuento").toString();
			String porcentajeDescuento = billarprecio.getProperty("porcentajedescuento").toString();
			String precioUnitarioTaco = billarprecio.getProperty("preciounitariotaco").toString();
			String cantidadTacos = request.getParameter("taco");

			Date tiempocurso = new SimpleDateFormat("HH:mm:ss").parse(tiempo1);
			Date fechaInicio = new SimpleDateFormat("MMMMM yyyy dd HH:mm:ss", new Locale("en")).parse(horainicio);

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));

//			List<String> res = calcularMontos(tiempocurso.getHours() + "", tiempocurso.getMinutes() + "", fechaInicio,
//					taco, precioUnitarioTaco, preciohora, porcentajeDescuento, numeroHorasParaDescuento,
//					montoIncrementoMesa, horaInicioNormalMesa, horaFinalNormalMesa);

			List<String> res = calcularTotal(fechaInicio, fechaActual, request.getParameter("codigo").toString(),
					Integer.parseInt(request.getParameter("taco")), tiempocurso);
			int horaini = fechaInicio.getHours();
			int horafin = fechaActual.getHour();
			billar.setProperty("tiempo", tiempo1);
			billar.setProperty("fin", fechaActual.format(formatter));
			// billar.setProperty("inicio", fechaInicio);
			// billar.setProperty("minutosnormal", res.get(0));
			// billar.setProperty("minutosincremento", res.get(1));
			// billar.setProperty("minutostotal", res.get(4));
			billar.setProperty("montonormal", decimalFormato.format(Double.parseDouble(res.get(3))));
			// billar.setProperty("montoincremento", res.get(3));
			billar.setProperty("montotaco", decimalFormato.format(Double.parseDouble(res.get(1))));
			billar.setProperty("descuento", decimalFormato.format(Double.parseDouble(res.get(2))));
			// billar.setProperty("montototal", res.get(7));
			// billar.setProperty("incremento",
			// decimalFormato.format(Double.parseDouble(montoIncrementoMesa)));
			billar.setProperty("preciotaco", decimalFormato.format(Double.parseDouble(precioUnitarioTaco)));
			billar.setProperty("taco", cantidadTacos);
			billar.setProperty("preciohorafin", billarprecio.getProperty("precio" + horafin).toString());
			billar.setProperty("preciohoraini", billarprecio.getProperty("precio" + horaini).toString());

			// decimalFormato.format(Double.parseDouble(preciohora)));

			datastore.put(billar);
			billar.setProperty("montototal", decimalFormato.format(Double.parseDouble(res.get(0))));
			model.addAttribute("billar", billar);
			response = res.get(0);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "frmBillarResult";
	}

	private List<String> calcularTotal(Date fechaInicio, ZonedDateTime fechaActual, String codigoMesa,
			int cantidadTacos, Date duracion) {

		List<String> montos = new ArrayList<String>();

		try {
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Key key = KeyFactory.createKey("Billar", Long.parseLong(codigoMesa));
			Entity billar;
			billar = datastore.get(key);

			key = KeyFactory.createKey("Billarprecio", Long.parseLong(billar.getProperty("mesanumero").toString()));
			Entity billarprecio = datastore.get(key);

			double precioUnitarioTaco = Double.parseDouble(billarprecio.getProperty("preciounitariotaco").toString());
			int numeroHorasParaDescuento = Integer
					.parseInt(billarprecio.getProperty("numerohorasdescuento").toString());
			double porcentajeDescuento = Integer.parseInt(billarprecio.getProperty("porcentajedescuento").toString());

			int horaInicio = fechaInicio.getHours();
			int diaInicio = fechaInicio.getDate();
			int diaFin = fechaActual.getDayOfMonth();
			int minutoInicio = fechaInicio.getMinutes();
			int horaFin = fechaActual.getHour();
			int minutoFin = fechaActual.getMinute();

			double totalPagarBillar = 0;
			if (horaInicio == horaFin) {
				totalPagarBillar = (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio).toString()) * (minutoFin - minutoInicio)) / 60;
			}else {
				totalPagarBillar = (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio).toString()) * (60 - minutoInicio)) / 60;
				System.out.println("totalPagar1: " + totalPagarBillar);
				
			}

			int horaInicio1 = horaInicio + 1;
			if (diaInicio == diaFin) {
				while (horaInicio1 < horaFin) {
					totalPagarBillar = totalPagarBillar	+ (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio1).toString()) * 60) / 60;
					horaInicio1++;
				}
				if (horaInicio < horaFin) {
					totalPagarBillar = totalPagarBillar	+ (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio).toString()) * minutoFin) / 60;
				}
			}else {
				int horadespues = 0;

				while (horaInicio1 <= 23) {
					totalPagarBillar = totalPagarBillar	+ (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio1).toString()) * 60) / 60;
					horaInicio1++;

					System.out.println("totalPagar3: " + totalPagarBillar);
				}
			
				System.out.println("horasdepues: " + horadespues);
				System.out.println("horafin: " + horaFin);
				if (horaInicio > horaFin) {
					totalPagarBillar = totalPagarBillar + (Double.parseDouble(billarprecio.getProperty("precio" + horaInicio).toString()) * minutoFin) / 60;
					System.out.println("totalPagar4: " + totalPagarBillar);
				

				}
				while (horadespues < horaFin) {
					totalPagarBillar = totalPagarBillar + (Double.parseDouble(billarprecio.getProperty("precio" + horadespues).toString()) * 60)/ 60;
					horadespues++;
					System.out.println("totalPagar5: " + totalPagarBillar);
					
				}
			
			
			}
			double totalPagarTaco = precioUnitarioTaco * cantidadTacos;

			double descuento = 0;
 
			if (duracion.getHours() >= numeroHorasParaDescuento) {
				descuento = (totalPagarBillar * porcentajeDescuento) / 100;
			}
			double totalPagar = 0;

			totalPagar = totalPagarBillar + totalPagarTaco - descuento;
			double totalPagarRedondeo = Math.round(totalPagar * 2) / 2.0;

			montos.add(totalPagarRedondeo + "");
			montos.add(totalPagarTaco + "");
			montos.add(descuento + "");
			montos.add(totalPagarBillar + "");

		} catch (EntityNotFoundException e) {
			e.printStackTrace();
		}

		return montos;

	}

}
