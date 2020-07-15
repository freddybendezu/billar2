package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.datastore.TransactionOptions;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"/caja"})
public class CajaController
{
  @RequestMapping(value={"/principal"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getAddCustomerPage(ModelMap model)
  {
    return "frmCaja";
  }

  @RequestMapping(value={"/list"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String listaProductoBarra(HttpServletRequest request, ModelMap model, HttpServletResponse response)
  {
    Calendar fecha = Calendar.getInstance();
    int diaSemana = fecha.get(7);
    String dia = null;

    if (diaSemana == 1)
      dia = "dom";
    else if (diaSemana == 2)
      dia = "lun";
    else if (diaSemana == 3)
      dia = "mar";
    else if (diaSemana == 4)
      dia = "mie";
    else if (diaSemana == 5)
      dia = "jue";
    else if (diaSemana == 6)
      dia = "vie";
    else if (diaSemana == 7) {
      dia = "sab";
    }

    Cookie[] cookies = request.getCookies();
    String barra = null;
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if (cookie.getName().equals("responsabilidad")) {
          barra = cookie.getValue();
        }

      }

    }

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("ProductoBarra");
    query.addFilter("codigoBarra", Query.FilterOperator.EQUAL, barra);
    PreparedQuery pq = datastore.prepare(query);
    List<Entity> results = pq.asList(FetchOptions.Builder.withDefaults());
	List<Entity> listaProducto = new ArrayList<Entity>();
    try
    {
      for (Entity e : results) {
        Entity temporal = new Entity("Temporal");
        temporal.setProperty("codigoProducto", e.getProperty("codigoProducto"));
        temporal.setProperty("barCode", e.getProperty("barCode"));
        temporal.setProperty("nombreProducto", e.getProperty("nombreProducto"));
        temporal.setProperty("totalUnidades", e.getProperty("totalUnidades"));
        Key key = KeyFactory.createKey("PrecioPolitica", Long.parseLong(e.getProperty("codigoProducto").toString()));
        Entity precioPolitica = datastore.get(key);
        temporal.setProperty("precioProducto", precioPolitica.getProperty(dia));
        listaProducto.add(temporal);
      }
    }
    catch (EntityNotFoundException localEntityNotFoundException) {
    }
    model.addAttribute("productoBarraList", listaProducto);

    return "frmPV";
  }

  @RequestMapping(value={"/registrarVenta"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  @ResponseBody
  public List<String> registrarVenta(HttpServletRequest request, ModelMap model)
  {
    Cookie[] cookies = request.getCookies();
    String barra = null;
    String tienda = null;
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if (cookie.getName().equals("responsabilidad")) {
          barra = cookie.getValue();
        }
        if (cookie.getName().equals("tienda")) {
            tienda = cookie.getValue();
          }
      }
    }
    
    HttpSession sesion = request.getSession();
	Object usuario = (String) sesion.getAttribute("usuario");
	
    
    DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    DateTimeFormatter formatoHora = DateTimeFormatter.ofPattern("HH:mm:ss");
	ZonedDateTime fechaActual = ZonedDateTime.now(ZoneId.of("America/Lima"));
	
    String tmpCodigoBarra = barra;
    String tmpTienda= tienda;
    String tmpCodigoProducto = request.getParameter("tmpCodigoProducto");
    String tmpNombreProducto = request.getParameter("tmpNombreProducto");
    String tmpPrecioProducto = request.getParameter("tmpPrecioProducto");
    String tmpCantidadProducto = request.getParameter("tmpCantidadProducto");
    String tmpTotal = request.getParameter("tmpTotal");
    String[] codigoProducto = tmpCodigoProducto.split(",");
    String[] nombreProducto = tmpNombreProducto.split(",");
    String[] precioProducto = tmpPrecioProducto.split(",");
    String[] cantidadProducto = tmpCantidadProducto.split(",");
    
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

    List<Entity> productoVentaDetallelLista = new ArrayList<Entity>();
    List<Entity> productoBarraLista = new ArrayList<Entity>();
    TransactionOptions txn = TransactionOptions.Builder.withXG(true);
    Transaction tx = ds.beginTransaction(txn);
    try
    {
      Entity productoVenta = new Entity("ProductoVenta");
      productoVenta.setProperty("codigoBarra", tmpCodigoBarra);
      productoVenta.setProperty("tienda", tmpTienda);      
      productoVenta.setProperty("fechaventa", fechaActual.format(formatoFecha));
      productoVenta.setProperty("horaventa", fechaActual.format(formatoHora));
      productoVenta.setProperty("usuarioventa", usuario);
      productoVenta.setProperty("total", tmpTotal);
      ds.put(productoVenta);

      for (int i = 0; i < codigoProducto.length; ++i)
      {
        Query query = new Query("ProductoBarra");
        query.addFilter("codigoBarra", Query.FilterOperator.EQUAL, tmpCodigoBarra);
        query.addFilter("codigoProducto", Query.FilterOperator.EQUAL, codigoProducto[i]);
        PreparedQuery pq = ds.prepare(query);
        Entity productoBarra = pq.asSingleEntity();
        int totalUnidades = Integer.parseInt(productoBarra.getProperty("totalUnidades").toString()) - Integer.parseInt(cantidadProducto[i]);
        productoBarra.setProperty("totalUnidades", Integer.valueOf(totalUnidades));
        ds.put(productoBarra);
        Entity productoVentaDetalle = new Entity("ProductoVentaDetalle", productoVenta.getKey());
        productoVentaDetalle.setProperty("codigoVenta", productoVenta.getKey().getId());
        productoVentaDetalle.setProperty("codigoProducto", codigoProducto[i]);
        productoVentaDetalle.setProperty("nombreProducto", nombreProducto[i]);
        productoVentaDetalle.setProperty("cantidadProducto", cantidadProducto[i]);
        productoVentaDetalle.setProperty("precioProducto", precioProducto[i]);

        productoVentaDetallelLista.add(productoVentaDetalle);
        productoBarraLista.add(productoBarra);
      }

      ds.put(productoVentaDetallelLista);
      tx.commit();
    } catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      if (tx.isActive()) {
        tx.rollback();
      }
    }
    List<String> response = new ArrayList<String>();
    response.add("exito");
    return response;
  }
}