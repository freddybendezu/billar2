package pe.com.suriados.productos;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.datastore.TransactionOptions;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({ "/producto" })
public class ProductoController {

	@RequestMapping(value = { "/frmProducto" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String getAddCustomerPage(ModelMap model) {
		return "frmProductoAdd";
	}

	@RequestMapping(value = { "/add" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		// AGREGAR CODIGO PRODUCTO
		String codigoCategoria = request.getParameter("codigoCategoria");
		String nombreProducto = request.getParameter("nombreProducto");
		String barCode = request.getParameter("barCode");
		String unidadesXCaja = request.getParameter("unidadesXCaja");
		String nroCajasCompradas = request.getParameter("nroCajasCompradas");
		String nroUnidadesCompradas = request.getParameter("nroUnidadesCompradas");
		String precioXCaja = request.getParameter("precioXCaja");

		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
		String fecha = hourdateFormat.format(date);

		double precioXUnidad = Double.parseDouble(precioXCaja) / Integer.parseInt(unidadesXCaja);
		int totalUnidades = Integer.parseInt(nroCajasCompradas) * Integer.parseInt(unidadesXCaja)
				+ Integer.parseInt(nroUnidadesCompradas);

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Entity producto = new Entity("Producto");

		Transaction tx = ds.beginTransaction();
		try {
			producto.setProperty("codigoCategoria", codigoCategoria);
			producto.setProperty("nombreProducto", nombreProducto);
			producto.setProperty("barCode", barCode);
			producto.setProperty("unidadesXCaja", unidadesXCaja);
			producto.setProperty("nroCajasCompradas", nroCajasCompradas);
			producto.setProperty("nroUnidadesCompradas", nroUnidadesCompradas);
			producto.setProperty("precioXCaja", precioXCaja);
			producto.setProperty("precioXUnidad", Double.valueOf(precioXUnidad));
			producto.setProperty("totalUnidades", Integer.valueOf(totalUnidades));

			ds.put(producto);

			Entity productoHistorial = new Entity("ProductoHistorial", producto.getKey());

			productoHistorial.setProperty("codigoCategoria", codigoCategoria);
			productoHistorial.setProperty("nombreProducto", nombreProducto);
			productoHistorial.setProperty("barCode", barCode);
			productoHistorial.setProperty("unidadesXCaja", unidadesXCaja);
			productoHistorial.setProperty("nroCajasCompradas", nroCajasCompradas);
			productoHistorial.setProperty("nroUnidadesCompradas", nroUnidadesCompradas);
			productoHistorial.setProperty("precioXCaja", precioXCaja);
			productoHistorial.setProperty("precioXUnidad", Double.valueOf(precioXUnidad));
			productoHistorial.setProperty("totalUnidades", Integer.valueOf(totalUnidades));
			productoHistorial.setProperty("fecha", fecha);
			ds.put(productoHistorial);

			tx.commit();
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
		}
		return new ModelAndView("redirect:list");
	}

	@RequestMapping(value = { "/update/{id}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String getUpdateCustomerPage(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key key = KeyFactory.createKey("Producto", Long.parseLong(id));
		try {
			Entity producto = datastore.get(key);
			model.addAttribute("producto", producto);
		} catch (EntityNotFoundException e) {
			e.printStackTrace();
		}

		return "frmProductoUpdate";
	}

	@RequestMapping(value = { "/update" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String id = request.getParameter("id");
		String codigoCategoria = request.getParameter("codigoCategoria");
		String nombreProducto = request.getParameter("nombreProducto");
		String barCode = request.getParameter("barCode");
		String unidadesXCaja = request.getParameter("unidadesXCaja");
		String nroCajasCompradas1 = request.getParameter("nroCajasCompradas1");
		String nroUnidadesCompradas1 = request.getParameter("nroUnidadesCompradas1");
		int totalCajas = Integer.parseInt(request.getParameter("nroCajasCompradas1"))
				+ Integer.parseInt(request.getParameter("nroCajasCompradas"));
		int totalUnidades = Integer.parseInt(request.getParameter("nroUnidadesCompradas1"))
				+ Integer.parseInt(request.getParameter("nroUnidadesCompradas"));
		String precioXCaja = request.getParameter("precioXCaja");
		String precioVentaUnitarioxMenor = request.getParameter("precioVentaUnitarioxMenor");
		String precioVentaUnitarioxMayor = request.getParameter("precioVentaUnitarioxMayor");
		String cantidadParaPrecioUnitarioxMayor = request.getParameter("cantidadParaPrecioUnitarioxMayor");
		
		
		
		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
		String fecha = hourdateFormat.format(date);

		double precioXUnidad = Double.parseDouble(precioXCaja) / Integer.parseInt(unidadesXCaja);
		int totalUnidades1 = totalCajas * Integer.parseInt(unidadesXCaja) + totalUnidades;

		Entity producto = new Entity("Producto", Long.parseLong(id));
		TransactionOptions txn = TransactionOptions.Builder.withXG(true);
		Transaction tx = datastore.beginTransaction(txn);
		try {
			producto.setProperty("codigoCategoria", codigoCategoria);
			producto.setProperty("nombreProducto", nombreProducto);
			producto.setProperty("barCode", barCode);
			producto.setProperty("unidadesXCaja", unidadesXCaja);
			producto.setProperty("nroCajasCompradas", Integer.valueOf(totalCajas));
			producto.setProperty("nroUnidadesCompradas", Integer.valueOf(totalUnidades));
			producto.setProperty("precioXCaja", precioXCaja);
			producto.setProperty("precioXUnidad", Double.valueOf(precioXUnidad));
			producto.setProperty("totalUnidades", Integer.valueOf(totalUnidades1));
			producto.setProperty("PrecioVentaUnitarioxMenor", precioVentaUnitarioxMenor);
			producto.setProperty("PrecioVentaUnitarioxMayor", precioVentaUnitarioxMayor);
			producto.setProperty("cantidadParaPrecioUnitarioxMayor", cantidadParaPrecioUnitarioxMayor);
			datastore.put(producto);

			Entity productoHistorial = new Entity("ProductoHistorial");

			productoHistorial.setProperty("codigoCategoria", codigoCategoria);
			productoHistorial.setProperty("nombreProducto", nombreProducto);
			productoHistorial.setProperty("barCode", barCode);
			productoHistorial.setProperty("unidadesXCaja", unidadesXCaja);
			productoHistorial.setProperty("nroCajasCompradas", nroCajasCompradas1);
			productoHistorial.setProperty("nroUnidadesCompradas", nroUnidadesCompradas1);
			productoHistorial.setProperty("precioXCaja", precioXCaja);
			productoHistorial.setProperty("precioXUnidad", Double.valueOf(precioXUnidad));
			productoHistorial.setProperty("totalUnidades", Integer.valueOf(totalUnidades1));
			productoHistorial.setProperty("PrecioVentaUnitarioxMenor", precioVentaUnitarioxMenor);
			productoHistorial.setProperty("PrecioVentaUnitarioxMayor", precioVentaUnitarioxMayor);
			productoHistorial.setProperty("cantidadParaPrecioUnitarioxMayor", cantidadParaPrecioUnitarioxMayor);
			
			productoHistorial.setProperty("fecha", fecha);
			datastore.put(productoHistorial);

			tx.commit();
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
		}
		return new ModelAndView("redirect:list");
	}

	@RequestMapping(value = { "/delete/{id}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public ModelAndView delete(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		Key key = KeyFactory.createKey("Producto", Long.parseLong(id));
		datastore.delete(new Key[] { key });
		return new ModelAndView("redirect:../list");
	}

	@RequestMapping(value = { "/list" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String listProductos(ModelMap model) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Producto").addSort("nombreProducto", Query.SortDirection.DESCENDING);
		List<Entity> producto = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());

		model.addAttribute("productoList", producto);

		Query query1 = new Query("Barra").addSort("nombre", Query.SortDirection.DESCENDING);
		List<Entity> barra = datastore.prepare(query1).asList(FetchOptions.Builder.withDefaults());

		model.addAttribute("barraList", barra);

		return "frmProductoList";
	}

	@RequestMapping(value = { "/importar" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public String process(HttpServletRequest request, ModelMap model) {
		String resultado="";
		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
		String fecha = hourdateFormat.format(date);
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		DatastoreService ds1 = DatastoreServiceFactory.getDatastoreService();
		long productoId=0;
		try {
			BufferedReader fileReader = new BufferedReader(
					new InputStreamReader(request.getPart("file").getInputStream(), "UTF-8"));
			CSVParser csvParser = new CSVParser(fileReader, CSVFormat.DEFAULT.withAllowMissingColumnNames()
					.withDelimiter(';').withFirstRecordAsHeader().withIgnoreHeaderCase().withTrim());
			Iterable<CSVRecord> csvRecords = csvParser.getRecords();
			for (CSVRecord csvRecord : csvRecords) {
				Transaction tx = ds.beginTransaction();
				try {
					Entity producto = new Entity("Producto");
					producto.setProperty("codigoCategoria", csvRecord.get("categoria"));
					producto.setProperty("nombreProducto", csvRecord.get("producto"));
					producto.setProperty("barCode", csvRecord.get("barcode"));
					producto.setProperty("unidadesXCaja", csvRecord.get("Unidadesxcaja"));
					producto.setProperty("nroCajasCompradas", csvRecord.get("CajasCompradas"));
					producto.setProperty("nroUnidadesCompradas", csvRecord.get("UnidadesCompradas"));
					producto.setProperty("precioXCaja", csvRecord.get("PrecioCompraxcaja"));
					producto.setProperty("precioXUnidad", csvRecord.get("PrecioCompraxunidad"));
					producto.setProperty("PrecioVentaUnitarioxMenor", csvRecord.get("PrecioVentaUnitarioxMenor"));
					producto.setProperty("PrecioVentaUnitarioxMayor", csvRecord.get("PrecioVentaUnitarioxMayor"));
					producto.setProperty("cantidadParaPrecioUnitarioxMayor", csvRecord.get("cantidadParaPrecioUnitarioxMayor"));
					ds.put(producto);
	
					Entity productoHistorial = new Entity("ProductoHistorial", producto.getKey());
					productoHistorial.setProperty("codigoCategoria", csvRecord.get("categoria"));
					productoHistorial.setProperty("nombreProducto", csvRecord.get("producto"));
					productoHistorial.setProperty("barCode", csvRecord.get("barcode"));
					productoHistorial.setProperty("unidadesXCaja", csvRecord.get("Unidadesxcaja"));
					productoHistorial.setProperty("nroCajasCompradas", csvRecord.get("CajasCompradas"));
					productoHistorial.setProperty("nroUnidadesCompradas", csvRecord.get("UnidadesCompradas"));
					productoHistorial.setProperty("precioXCaja", csvRecord.get("PrecioCompraxcaja"));
					productoHistorial.setProperty("precioXUnidad", csvRecord.get("PrecioCompraxunidad"));
					productoHistorial.setProperty("PrecioVentaUnitarioxMenor", csvRecord.get("PrecioVentaUnitarioxMenor"));
					productoHistorial.setProperty("PrecioVentaUnitarioxMayor", csvRecord.get("PrecioVentaUnitarioxMayor"));
					productoHistorial.setProperty("cantidadParaPrecioUnitarioxMayor", csvRecord.get("cantidadParaPrecioUnitarioxMayor"));
					productoHistorial.setProperty("fecha", fecha);
					ds.put(productoHistorial);
					System.out.println(producto.getKey());
					System.out.println(producto.getKey().getId());
					System.out.println(producto.getKey().getAppId());
				    productoId = producto.getKey().getId();
					tx.commit();
				}catch(Exception e) {
					e.printStackTrace();
				} finally {
					if (tx.isActive()) {
						tx.rollback();
					}
					
					Entity precioPolitica = new Entity("PrecioPolitica", productoId);
				    precioPolitica.setProperty("lun", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("mar", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("mie", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("jue", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("vie", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("sab", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("dom", csvRecord.get("PrecioVentaUnitarioxMenor"));
				    precioPolitica.setProperty("fecha", fecha);
				    ds1.put(precioPolitica);
					
				}
			}
			resultado = "Exito";
		} catch (Exception e) {
			resultado = "Error: " + e;
		} 

		return "Exito";
	}

	@RequestMapping(value = { "/agregarProductoBarra" }, method = {
			org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public ModelAndView agregarProductoBarra(HttpServletRequest request, ModelMap model) {
		String tmpCodigoBarra = request.getParameter("tmpCodigoBarra");
		String tmpNombreBarra = request.getParameter("tmpNombreBarra");
		String tmpCodigoProducto = request.getParameter("tmpCodigoProducto");
		String tmpNombreProducto = request.getParameter("tmpNombreProducto");
		String tmpBarCode = request.getParameter("tmpBarCode");
		String tmpCajas = request.getParameter("tmpCajas");
		String tmpUnidades = request.getParameter("tmpUnidades");

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

		String[] codigoProducto = tmpCodigoProducto.split(",");
		String[] nombreProducto = tmpNombreProducto.split(",");
		String[] barCode = tmpBarCode.split(",");
		String[] cajas = tmpCajas.split(",");
		String[] unidades = tmpUnidades.split(",");

		// List productoBarraHistorialLista = new ArrayList();
		// List productoLista = new ArrayList();
		// List productoBarraLista = new ArrayList();

		List<Entity> productoBarraHistorialLista = new ArrayList<Entity>();
		List<Entity> productoLista = new ArrayList<Entity>();
		List<Entity> productoBarraLista = new ArrayList<Entity>();

		try {
			for (int i = 0; i < codigoProducto.length; ++i) {
				Key keyProducto = KeyFactory.createKey("Producto", Long.parseLong(codigoProducto[i]));
				Entity producto = ds.get(keyProducto);
				int totalCajasProducto = Integer.parseInt(producto.getProperty("nroCajasCompradas").toString())
						- Integer.parseInt(cajas[i]);
				int totalUnidadesProducto = Integer.parseInt(producto.getProperty("nroUnidadesCompradas").toString())
						- Integer.parseInt(unidades[i]);
				int totalUnidades = Integer.parseInt(cajas[i])
						* Integer.parseInt(producto.getProperty("unidadesXCaja").toString())
						+ Integer.parseInt(unidades[i]);
				producto.setProperty("nroCajasCompradas", Integer.valueOf(totalCajasProducto));
				producto.setProperty("nroUnidadesCompradas", Integer.valueOf(totalUnidadesProducto));
				productoLista.add(producto);

				Entity productoBarraHistorial = new Entity("ProductoBarraHistorial");
				productoBarraHistorial.setProperty("codigoBarra", tmpCodigoBarra);
				productoBarraHistorial.setProperty("nombreBarra", tmpNombreBarra);
				productoBarraHistorial.setProperty("codigoProducto", codigoProducto[i]);
				productoBarraHistorial.setProperty("nombreProducto", nombreProducto[i]);
				productoBarraHistorial.setProperty("barCode", barCode[i]);
				productoBarraHistorial.setProperty("cajas", cajas[i]);
				productoBarraHistorial.setProperty("unidades", unidades[i]);
				productoBarraHistorial.setProperty("totalUnidades", Integer.valueOf(totalUnidades));
				productoBarraHistorialLista.add(productoBarraHistorial);

				Key keyProductoBarra = KeyFactory.createKey("ProductoBarra", Long.parseLong(tmpCodigoBarra));
				Entity productoBarra = new Entity("ProductoBarra", Long.parseLong(codigoProducto[i]), keyProductoBarra);
				int totalCajasProductoBarra;
				int totalUnidadesProductoBarra;
				try {
					productoBarra = ds.get(productoBarra.getKey());
					totalCajasProductoBarra = Integer.parseInt(productoBarra.getProperty("cajas").toString())
							+ Integer.parseInt(cajas[i]);
					totalUnidadesProductoBarra = Integer.parseInt(productoBarra.getProperty("cajas").toString())
							+ Integer.parseInt(unidades[i]);
					totalUnidades += Integer.parseInt(productoBarra.getProperty("totalUnidades").toString());
					productoBarra.setProperty("cajas", Integer.valueOf(totalCajasProductoBarra));
					productoBarra.setProperty("unidades", Integer.valueOf(totalUnidadesProductoBarra));
					productoBarra.setProperty("totalUnidades", Integer.valueOf(totalUnidades));
				} catch (EntityNotFoundException e) {
					totalCajasProductoBarra = Integer.parseInt(cajas[i]);
					totalUnidadesProductoBarra = Integer.parseInt(unidades[i]);
					productoBarra.setProperty("codigoBarra", tmpCodigoBarra);
					productoBarra.setProperty("nombreBarra", tmpNombreBarra);
					productoBarra.setProperty("codigoProducto", codigoProducto[i]);
					productoBarra.setProperty("nombreProducto", nombreProducto[i]);
					productoBarra.setProperty("barCode", barCode[i]);
					productoBarra.setProperty("cajas", Integer.valueOf(totalCajasProductoBarra));
					productoBarra.setProperty("unidades", Integer.valueOf(totalUnidadesProductoBarra));
					productoBarra.setProperty("totalUnidades", Integer.valueOf(totalUnidades));
				}
				productoBarraLista.add(productoBarra);
			}
		} catch (EntityNotFoundException localEntityNotFoundException1) {
		} finally {
			ds.put(productoLista);
			ds.put(productoBarraHistorialLista);
			ds.put(productoBarraLista);
		}

		return new ModelAndView("redirect:list");
	}

}
