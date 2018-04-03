package bleBeacon;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class LoginServer
 */
@WebServlet("/login")
public class LoginServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameterMap().containsKey("session")){
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		JSONObject ifSession = new JSONObject();
	 		PrintWriter out = response.getWriter();
	 		HttpSession session=request.getSession(false);
			if(session!=null){
				String username=(String)session.getAttribute("username");
				String password=(String)session.getAttribute("password");
				String role=(String)session.getAttribute("role");
				if(username==null || password==null){
					try {
						ifSession.append("exists", "false");
						out.print(ifSession);
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else{
					try {
						ifSession.append("exists", "true");
						JSONObject user = new JSONObject();
						ifSession.append("username", username);
						ifSession.append("password", password);
						ifSession.append("role", role);
						out.print(ifSession);
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	 			}
			}
			else{	
				try {
					ifSession.append("exists", "false");
					out.print(ifSession);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		else
			request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		if(request.getParameterMap().containsKey("setSession")){	
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		String username=request.getParameter("username");
			String password=request.getParameter("password");
			JSONObject json = new JSONObject();
			if(password.equals("admin") && username.equals("admin")){
				HttpSession session=request.getSession();
				session.setAttribute("username",username);
				session.setAttribute("password",password);
				session.setAttribute("role","superadmin");
				try {
					json.append("exists", "true");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				out.print(json);
			}
			else{
				response.setContentType("application/json");
		 		response.setHeader("cache-control", "no-cache");
		 		EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
				EntityManager em = emf.createEntityManager();
				Query query = em.createQuery("SELECT u FROM Member u where u.username_='"+username+"'and u.password_='"+password+"'");
				
				List<Member> resultList=query.getResultList();
				em.close();
				if(resultList.size()>0)
				{
					try {
						HttpSession session=request.getSession();
						session.setAttribute("username",username);
						session.setAttribute("password",password);
						session.setAttribute("role",resultList.get(0).getRole_());
						json.append("exists", "true");
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else{
					try {
						json.append("exists", "false");
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					}
				
				out.print(json);
			}
		}
		else if(request.getParameterMap().containsKey("logOut")){
			HttpSession session=request.getSession();
			String username=(String)request.getParameter("username");
			String password=(String)request.getParameter("password");
			session.invalidate();
		}
		out.close();
	}

}
