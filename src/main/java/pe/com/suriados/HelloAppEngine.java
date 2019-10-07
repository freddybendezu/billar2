package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name="HelloAppEngine", urlPatterns={"/hello"})
public class HelloAppEngine extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException
  {
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

    Entity categoria = new Entity("Categoria");
    categoria.setProperty("codigo", "Uno");
    categoria.setProperty("descripcion", "categoria");
    ds.put(categoria);

    Entity producto = new Entity("Producto", 11L);
    producto.setProperty("codigo", "Uno");
    producto.setProperty("producto", "Producto");
    ds.put(producto);

    Key key = KeyFactory.createKey("Producto", 10L);
    try
    {
      Entity res = ds.get(key);
      System.out.println("Respuesta: " + res);
    } catch (EntityNotFoundException e) {
      e.printStackTrace();
    }

    ds.delete(new Key[] { key });

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().print("Hello App Engine!\r\n");
  }
}