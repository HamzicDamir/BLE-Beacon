package bleBeacon;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class MainServer
 */
@WebServlet("/main")
public class MainServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainServer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameterMap().containsKey("username")){
			String username=request.getParameter("username");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query query = em.createQuery("SELECT u FROM Member u where u.username_='"+username+"'");
			List<Member> resultList=query.getResultList();
			em.close();
			JSONObject json=new JSONObject();
			try { 
				if(resultList.isEmpty()){
					json.append("exists", "false");
				}
				else{
					json.append("exists", "true");
				}
			}
			catch (JSONException e) {
					e.printStackTrace();
			}
			
			out.println(json.toString());
			return;
		}
		else if(request.getParameterMap().containsKey("role")){
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			HttpSession session=request.getSession(false);
			String role=(String)session.getAttribute("role");
			JSONObject json=new JSONObject();
			try {
				json.put("role", role);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.println(json.toString());
			return;
		}
		else if(request.getParameterMap().containsKey("BLEs")){
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
	 		EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			HttpSession session=request.getSession(false);
			String role=(String)session.getAttribute("role");
			
			if(role.equals("admin") || role.equals("superadmin")){
				Query query = em.createQuery("SELECT u FROM Object u");
				List<Object> resultList=query.getResultList();
				JSONArray BLEs=new JSONArray();
				try {
				for(int i = 0;i < resultList.size();++i){
					JSONObject BLE = new JSONObject();
					BLE.append("id",resultList.get(i).getId_());
					BLE.append("nameOfObject",resultList.get(i).getName_());
					BLE.append("type",resultList.get(i).getType_());
					BLEs.put(BLE);
				}
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				out.println(BLEs.toString());
			}
			else{
				String username=(String)session.getAttribute("username");
				{
					Query query = em.createQuery("SELECT u FROM Object u inner join u.members_ e where e.username_='"+username+"'");
					List<Object> resultList=query.getResultList();
					JSONArray BLEs=new JSONArray();
					try {
					for(int i = 0;i < resultList.size();++i){
						JSONObject BLE = new JSONObject();
						BLE.append("id",resultList.get(i).getId_());
						BLE.append("nameOfObject",resultList.get(i).getName_());
						BLE.append("type",resultList.get(i).getType_());
						BLEs.put(BLE);
					}
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					out.println(BLEs.toString());
				}
			}
		}
		else if(request.getParameterMap().containsKey("objectName")){
			String objectName=request.getParameter("objectName");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query query = em.createQuery("SELECT u FROM Object u where u.name_='"+objectName+"'");
			List<Object> resultList=query.getResultList();
			em.close();
			JSONObject json=new JSONObject();
			try { 
				if(resultList.isEmpty()){
					json.append("exists", "false");
				}
				else{
					json.append("exists", "true");
				}
			}
			catch (JSONException e) {
					e.printStackTrace();
			}
			
			out.println(json.toString());
			return;
		}
		
		else if(request.getParameterMap().containsKey("uuid")){
			String uuid=request.getParameter("uuid");
			String major=request.getParameter("major");
			String minor=request.getParameter("minor");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query query = em.createQuery("SELECT u FROM Device u where u.uuid_='"+uuid+"' and u.minor_='"+minor+"' and u.major_='"+major+"'");
			List<Device> resultList=query.getResultList();
			JSONObject BLE = new JSONObject();
			
			if(resultList.size()>0){
			try {
				Object obj =(Object) em.createQuery("SELECT u FROM Object u where u.device_.id_='"+resultList.get(0).getId_()+"'").getSingleResult();
				BLE.put("nameOfObject",obj.getName_());
				BLE.put("type",obj.getType_());
				BLE.put("city", obj.getCity_());
				BLE.put("address", resultList.get(0).getAddress_());
				BLE.put("information", obj.getAbout_());
				BLE.put("link", obj.getLink_());
				BLE.put("uuid", uuid);
				BLE.put("major", major);
				BLE.put("minor", minor);
				BLE.put("successful", "true");
				Query query1 = em.createQuery("SELECT u FROM Information u where u.object_.id_='"+obj.getId_()+"'");
				List<Information> resultList2=query1.getResultList();
				if(resultList2.size()>0){
					BLE.put("hasInformations", "true");
					JSONArray informations = new JSONArray();
					for(int i = 0; i <resultList2.size(); ++i){
						JSONObject information = new JSONObject();
						information.put("date", resultList2.get(i).getDate_());
						information.put("type", resultList2.get(i).getType_());
						information.put("text", resultList2.get(i).getText_());
						information.put("link", resultList2.get(i).getLink_());
						informations.put(information);
					}
				BLE.put("informations", informations);	
				}
				else{
					BLE.put("hasInformations", "false");
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
			else{
				try {
					BLE.put("successful", "false");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			out.println(BLE.toString());
			return;				
		}
		
		else if(request.getParameterMap().containsKey("deviceUUID")){
			String deviceUUID=request.getParameter("deviceUUID");
			String deviceMajor=request.getParameter("deviceMajor");
			String deviceMinor=request.getParameter("deviceMinor");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query query = em.createQuery("SELECT u FROM Device u where u.uuid_='"+deviceUUID+"' and u.minor_='"+deviceMinor+"' and u.major_='"+deviceMajor+"'");
			List<Device> resultList=query.getResultList();
			em.close();
			JSONObject json=new JSONObject();
			try { 
				if(resultList.isEmpty()){
					json.append("exists", "false");
				}
				else{
					if(resultList.get(0).getObject_().getName_().equals(request.getParameter("updatenameOfObject")))
						json.append("exists", "false");
					else
						json.append("exists", "true");
				}
			}
			catch (JSONException e) {
					e.printStackTrace();
			}
			out.println(json.toString());
			return;
		}
		else if(request.getParameterMap().containsKey("BLE")){
			String ObjectID=request.getParameter("BLE");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Object obj =(Object) em.createQuery("SELECT u FROM Object u where u.id_='"+ObjectID+"'").getSingleResult();
			JSONObject json=new JSONObject();
			HttpSession session=request.getSession(false);
			String role=(String)session.getAttribute("role");
			try {
				if(role.equals("superadmin") || role.equals("admin")){
				json.append("role", "admin");
				json.append("nameOfObject", obj.getName_());
				json.append("type", obj.getType_());
				json.append("city", obj.getCity_());
				Device dev =(Device) em.createQuery("SELECT u FROM Device u where u.object_.id_='"+ObjectID+"'").getSingleResult();
				json.append("address", dev.getAddress_());
				json.append("devUUID", dev.getUuid_());
				json.append("devMajor", dev.getMajor_());
				json.append("devMinor", dev.getMinor_());
				json.append("information", obj.getAbout_());
				json.append("link", obj.getLink_());
				}
				else{
					json.append("role", "user");
					json.put("nameOfObject", obj.getName_());
					Query q = em.createQuery("SELECT u FROM Information u where u.object_.id_='"+ObjectID+"'");
					List<Information> resultList = q.getResultList();
					JSONArray Informations = new JSONArray();
					if(resultList.size()==0){
						json.append("list", "empty");
					}
					else{
						json.append("list", "notEmpty");
					
						for(int i=0;i<resultList.size();++i){
							JSONObject information=new JSONObject();
							information.put("link_", resultList.get(i).getLink_());
							information.put("date_", resultList.get(i).getDate_());
							information.put("text_", resultList.get(i).getText_());
							information.put("type_", resultList.get(i).getType_());
							Informations.put(information);
						}
					}
					
					json.append("informations", Informations);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.println(json.toString());
			return;
		}	
		else if(request.getParameterMap().containsKey("members")){
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
	 		EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			HttpSession session=request.getSession(false);
			String role=(String)session.getAttribute("role");
			if(role.equals("superadmin")){
				Query q = em.createQuery("SELECT u FROM Member u");
				List<Member> resultList = q.getResultList();
				JSONArray json=new JSONArray();
				try {
				for(int i=0;i<resultList.size();++i){
					JSONObject member=new JSONObject();
					member.append("id_", resultList.get(i).getId_());
					member.append("first_name_", resultList.get(i).getFirst_name_());
					member.append("last_name_", resultList.get(i).getLast_name_());
					member.append("email_", resultList.get(i).getEmail_());
					member.append("role_", resultList.get(i).getRole_());
					json.put(member);
					} 
				}
				catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				out.println(json.toString());
				em.close();
		 		return;
			}
			else{
				Query q = em.createQuery("SELECT u FROM Member u where u.role_='user'");
				List<Member> resultList = q.getResultList();
				JSONArray json=new JSONArray();
				try {
				for(int i=0;i<resultList.size();++i){
					JSONObject member=new JSONObject();
					member.append("id_", resultList.get(i).getId_());
					member.append("first_name_", resultList.get(i).getFirst_name_());
					member.append("last_name_", resultList.get(i).getLast_name_());
					member.append("email_", resultList.get(i).getEmail_());
					member.append("role_", resultList.get(i).getRole_());
					json.put(member);
					} 
				}
				catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				out.println(json.toString());
				em.close();
		 		return;
			}
			
		}
		else if(request.getParameterMap().containsKey("users")){
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
	 		EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query q = em.createQuery("SELECT u FROM Member u where u.role_='user'");
			List<Member> resultList = q.getResultList();
			JSONArray json=new JSONArray();
			try {
			for(int i=0;i<resultList.size();++i){
				JSONObject user=new JSONObject();
				user.append("id_", resultList.get(i).getId_());
				user.append("first_name_", resultList.get(i).getFirst_name_());
				user.append("last_name_", resultList.get(i).getLast_name_());
				json.put(user);
				} 
			}
			catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			out.println(json.toString());
			em.close();
	 		return;
		}
		else if(request.getParameterMap().containsKey("member")){
			String memberID=request.getParameter("member");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Member member = (Member) em.createQuery("SELECT u FROM Member u where u.id_='"+memberID+"'").getSingleResult();
			em.close();
			JSONObject json=new JSONObject();
			try {
				json.append("id_", member.getId_());
				json.append("first_name_", member.getFirst_name_());
				json.append("last_name_", member.getLast_name_());
				json.append("username_", member.getUsername_());
				json.append("password_", member.getPassword_());
				json.append("email_", member.getEmail_());
				json.append("role_", member.getRole_());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.println(json.toString());
			return;
		}
		else if(request.getParameterMap().containsKey("memberSession")){
			HttpSession session=request.getSession(false);
			String username=(String)session.getAttribute("username");
			response.setContentType("application/json");
	 		response.setHeader("cache-control", "no-cache");
	 		PrintWriter out = response.getWriter();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Member member = (Member) em.createQuery("SELECT u FROM Member u where u.username_='"+username+"'").getSingleResult();
			em.close();
			JSONObject json=new JSONObject();
			try {
				json.append("id_", member.getId_());
				json.append("first_name_", member.getFirst_name_());
				json.append("last_name_", member.getLast_name_());
				json.append("username_", member.getUsername_());
				json.append("password_", member.getPassword_());
				json.append("email_", member.getEmail_());
				json.append("role_", member.getRole_());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.println(json.toString());
			return;
		}
		
		else{
			request.getRequestDispatcher("/main.jsp").forward(request, response);
			return;
			}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameterMap().containsKey("newMember")){
			String a=request.getParameter("newMember");
			JSONObject obj = null;
			try {
				obj = new JSONObject(a);
				String firstName=obj.getString("firstname");
				String lastname=obj.getString("lastname");
				String userName=obj.getString("username");
				String password=obj.getString("password");
				String email=obj.getString("email");
				String role=obj.getString("role");
				Member member=new Member();
				member.setMember(firstName,lastname,userName,password,email,role);
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
				EntityManager em = emf.createEntityManager();
				em.getTransaction().begin();
				em.persist(member);
				em.getTransaction().commit();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}    
				return;

		}
		else if(request.getParameterMap().containsKey("updateBLEBeacon")){
			String json=request.getParameter("updateBLEBeacon");
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			HttpSession session=request.getSession(false);
			String role=(String)session.getAttribute("role");
			JSONObject jsonObj = null;
			try {
				jsonObj = new JSONObject(json);
				if(role.equals("superadmin") || role.equals("admin")){
					JSONObject BLEObject = jsonObj.getJSONObject("BLEObject");
					Object obj =(Object) em.createQuery("SELECT u FROM Object u where u.id_='"+BLEObject.getString("id")+"'").getSingleResult();
					obj.setCity_(BLEObject.getString("city"));
					Device dev =(Device) em.createQuery("SELECT u FROM Device u where u.object_.id_='"+BLEObject.getString("id")+"'").getSingleResult();
					JSONObject BLEInformation = jsonObj.getJSONObject("Information");
					obj.setAbout_(BLEInformation.getString("information"));
					obj.setLink_(BLEInformation.getString("link"));
					JSONObject BLEDevice = jsonObj.getJSONObject("Device");
					dev.setAddress_(BLEDevice.getString("address"));
					dev.setUuid_(BLEDevice.getString("UUID"));
					dev.setMajor_(BLEDevice.getString("Major"));
					dev.setMinor_(BLEDevice.getString("Minor"));
					em.getTransaction().begin();
					em.persist(dev);
					em.persist(obj);
					em.getTransaction().commit();
				}
				else{
					System.out.println(json);
					String nameOfObject=jsonObj.getString("nameOfObject");
					String update=jsonObj.getString("update");
					Object obj =(Object) em.createQuery("SELECT u FROM Object u where u.name_='"+nameOfObject+"'").getSingleResult();
					Query query = em.createQuery("SELECT u FROM Information u where u.object_.id_='"+obj.getId_()+"'");
					List<Information> resultList = query.getResultList();
					obj.setInformations_(null);
					em.getTransaction().begin();
					em.persist(obj);
					em.getTransaction().commit();
					for(int i = 0; i < resultList.size(); ++i){
						resultList.get(i).setObject_(null);
						em.getTransaction().begin();
						em.persist(resultList.get(i));
						em.createQuery("Delete from Information u where u.id_='"+resultList.get(i).getId_()+"'").executeUpdate();
						em.getTransaction().commit();
					}
					if(update.equals("yes")){	
						JSONArray informations = jsonObj.getJSONArray("Informations");
						for(int i = 0; i <informations.length();++i){
							JSONObject infObject = informations.getJSONObject(i);
							Information inf = new Information();
							inf.setText_(infObject.getString("text"));
							inf.setType_(infObject.getString("type"));
							if(infObject.getJSONObject("date").getString("exists").equals("true"))
								inf.setDate_(infObject.getJSONObject("date").getString("date"));
							else
								inf.setDate_("\\");
							System.out.println(inf.getDate_());
							if(infObject.getJSONObject("link").getString("exists").equals("true"))
								inf.setLink_(infObject.getJSONObject("link").getString("link"));
							else
								inf.setLink_("\\");
							obj.addInformationToObject(inf);
							inf.setObject_(obj);
							em.getTransaction().begin();
							em.persist(inf);
							em.persist(obj);
							em.getTransaction().commit();
						}
					}	
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return;
		}	
		
		else if(request.getParameterMap().containsKey("newBLEBeacon")){
			String json=request.getParameter("newBLEBeacon");
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			JSONObject jsonObj = null;
				try {
					jsonObj = new JSONObject(json);
					JSONObject BLEObject = jsonObj.getJSONObject("BLEObject");
					Object obj = new Object();
					obj.setName_(BLEObject.getString("name"));
					obj.setCity_(BLEObject.getString("city"));
					obj.setType_(BLEObject.getString("type"));
					JSONObject BLEInformation = jsonObj.getJSONObject("Information");
					obj.setAbout_(BLEInformation.getString("information"));
					obj.setLink_(BLEInformation.getString("link"));
					JSONObject BLEDevice = jsonObj.getJSONObject("Device");
					Device dev = new Device();
					dev.setAddress_(BLEDevice.getString("address"));
					dev.setUuid_(BLEDevice.getString("UUID"));
					dev.setMajor_(BLEDevice.getString("Major"));
					dev.setMinor_(BLEDevice.getString("Minor"));
					obj.setDevice_(dev);
					dev.setObject_(obj);
					em.getTransaction().begin();
					em.persist(dev);
					em.persist(obj);
					em.getTransaction().commit();
					JSONArray users = jsonObj.getJSONArray("users");
					for(int i = 0;i < users.length(); ++i){
						String memberId = (String) users.getJSONObject(i).get("id");
						Member member = (Member) em.createQuery("SELECT u FROM Member u where u.id_='"+memberId+"'").getSingleResult();
						obj.addMemberToObject(member);
						member.addObjectToMember(obj);
						em.getTransaction().begin();	
						em.persist(obj);
						em.persist(member);
						em.getTransaction().commit();
					}
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			return;
		}
		
		else if(request.getParameterMap().containsKey("UpdateMember")){
			String json=request.getParameter("UpdateMember");
			JSONObject UpdateMember;
			try {
				UpdateMember=new JSONObject(json);
				String username=UpdateMember.getString("username");
				String firstname=UpdateMember.getString("firstname");
				String lastname=UpdateMember.getString("lastname");
				String email=UpdateMember.getString("email");
				String password=UpdateMember.getString("password");
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
				EntityManager em = emf.createEntityManager();
				em.getTransaction().begin();
				em.createQuery("Update Member e set e.password_='"+password+"', e.email_='"+email+"', e.first_name_='"+firstname+"',e.last_name_='"+lastname+"' where e.username_='"+username+"'").executeUpdate();
				em.getTransaction().commit();
				em.close();
				emf.close();
			} catch (JSONException e) {
				e.printStackTrace();
			}
				return;
			
		}
		else if(request.getParameterMap().containsKey("DeleteMember")){
			String parameter=request.getParameter("DeleteMember");
			int idMember=Integer.parseInt(parameter);
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Query query = em.createQuery("SELECT u FROM Object u inner join u.members_ e where e.id_='"+idMember+"'");
			Member member =(Member) em.createQuery("SELECT u FROM Member u where u.id_='"+idMember+"'").getSingleResult();
			List<Object> resultList=query.getResultList();
			for(int i = 0;i < resultList.size();++i){
				Iterator<Member>iterator = resultList.get(i).getObjects_().iterator();
				while(iterator.hasNext())
				{
					Member mbr=iterator.next();
					if(member.getId_()==mbr.getId_()){
						iterator.remove();
					}
				}
				em.getTransaction().begin();
				em.persist(resultList.get(i));
				em.getTransaction().commit();
			}
			member.setObjects_(null);
			em.getTransaction().begin();
			em.persist(member);
			em.getTransaction().commit();
			em.getTransaction().begin();
	        em.createQuery("Delete from Member e where e.id_='"+idMember+"'").executeUpdate();
	        em.getTransaction().commit();
	        return;
		}
		else if(request.getParameterMap().containsKey("DeleteBLEBeacon")){
			String parameter=request.getParameter("DeleteBLEBeacon");
			int idBLEBeacon=Integer.parseInt(parameter);
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("BLEBeacon");
			EntityManager em = emf.createEntityManager();
			Object obj =(Object) em.createQuery("SELECT u FROM Object u where u.id_='"+idBLEBeacon+"'").getSingleResult();
			obj.setInformations_(null);
			obj.setDevice_(null);
			obj.setMembers_(null);
			
			Query query = em.createQuery("SELECT u FROM Member u inner join u.objects_ e where e.id_='"+obj.getId_()+"'");
			List<Member> resultList=query.getResultList();
			for(int i = 0;i < resultList.size();++i){
				Iterator<Object>iterator = resultList.get(i).getObjects_().iterator();
				while(iterator.hasNext())
				{
					Object b=iterator.next();
					if(obj.getName_().equals(b.getName_())){
						iterator.remove();
					}
				}
				em.getTransaction().begin();
				em.persist(resultList.get(i));
				em.getTransaction().commit();
			}
			Query query1 = em.createQuery("SELECT u FROM Information u  where u.object_.id_='"+obj.getId_()+"'");
			List<Information> resultList2 = query1.getResultList();
			for(int i = 0; i < resultList2.size(); ++i){
				resultList2.get(i).setObject_(null);
				em.getTransaction().begin();
				em.persist(resultList2.get(i));
				em.createQuery("Delete from Information u where u.id_='"+resultList2.get(i).getId_()+"'").executeUpdate();
				em.getTransaction().commit();
			}
			Device dev =(Device) em.createQuery("SELECT u FROM Device u where u.object_.id_='"+idBLEBeacon+"'").getSingleResult();
			dev.setObject_(null);
			em.getTransaction().begin();
			em.persist(dev);
			em.persist(obj);
			em.createQuery("Delete from Device u where u.id_='"+dev.getId_()+"'").executeUpdate();
			em.createQuery("Delete from Object u where u.id_='"+idBLEBeacon+"'").executeUpdate();
	        em.getTransaction().commit();
			return;
		}
	}

}
