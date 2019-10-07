package pe.com.suriados;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import java.io.PrintStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({"/"})
public class LoginController
{
  @RequestMapping(method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String getAddCustomerPage(ModelMap model)
  {
    return "frmLogin";
  }

  @RequestMapping(value={"/login"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public String login(HttpServletRequest request, ModelMap model, HttpServletResponse response)
  {
    String dni = request.getParameter("dni");
    String contrasena = request.getParameter("contrasena");

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key key = KeyFactory.createKey("Persona", Long.parseLong(dni));
    try
    {
      Entity persona = datastore.get(key);
      String contrasena1 = (String)persona.getProperty("contrasena");
      String responsabilidad = (String)persona.getProperty("responsabilidad");

      if (contrasena.equals(contrasena1))
      {
        Cookie cookie = new Cookie("responsabilidad", responsabilidad);
        response.addCookie(cookie);
        
        //Registro de sesion
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
            System.out.println("vivo");
        }
        //generate a new session
        HttpSession newSession = request.getSession(true);

        //setting session to expiry in 5 mins
        newSession.setMaxInactiveInterval(5*60);
        newSession.setAttribute("usuario", dni);
        newSession.setAttribute("validado", true);
        
        //-----------------
        
        return "frmBillarMesaAdd";
      }
      System.out.println("Password incorrecto");
    }
    catch (EntityNotFoundException e)
    {
      System.out.println("No existe");
      e.printStackTrace();
    }

    return "frmLogin";
  }
  
  @RequestMapping(value={"/logout"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String logout(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
      System.out.println("muerto");

	  HttpSession session = request.getSession(false);
      if(session != null){
          session.invalidate();
      }
	  return "frmLogin";
  }
}