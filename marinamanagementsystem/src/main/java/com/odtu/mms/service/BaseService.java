package com.odtu.mms.service;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.odtu.mms.model.Berth;
import com.odtu.mms.model.GeneralService;
import com.odtu.mms.model.Invoice;
import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Marina;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Reservation;
import com.odtu.mms.model.Role;
import com.odtu.mms.model.Yacht;
import com.odtu.mms.util.Constant;

@Service("baseService")
@Transactional
@Repository
public class BaseService {
	private static final Logger logger = LoggerFactory.getLogger(BaseService.class);

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;

	@Autowired
	private MessageSource messageSource;

	private String localDb = "royalcert_demo";

	// protected static Logger logger = Logger.getLogger("service");

	public Object get(Class clazz, Serializable id) { // try-catch koydum.
														// method her durumda
														// calisip bir sonuc
														// donmeli.
		try {
			Session session = sessionFactory.getCurrentSession();
			return session.get(clazz, id);
		} catch (Exception e) {
			return null;
		}
	}
	public Object getKisi(Class clazz, Long i) { // try-catch koydum.
		// method her durumda
		// calisip bir sonuc
		// donmeli.
				try {
						Session session = sessionFactory.getCurrentSession();
						return session.get(clazz, i);
					} catch (Exception e) 
					{
							return null;
					}
			}
	public void saveOrUpdate(Object obj) { // try-catch koymadim. bu islemi
											// yapmada bir sorun varsa uygulama
											// bir Exception firlatabilmeli,
											// yoksa mantiksal olarak kontrol
											// etmek guclesir.
		Session session = sessionFactory.getCurrentSession();
		// session.clear();
		session.saveOrUpdate(obj);
	}

	public void delete(Class clazz, Long id) { // try-catch koymadim. bu islemi
												// yapmada bir sorun varsa
												// uygulama bir Exception
												// firlatabilmeli, yoksa
												// mantiksal olarak kontrol
												// etmek guclesir.
		Session session = sessionFactory.getCurrentSession();
		session.delete(session.get(clazz, id));
	}

	public void delete(Object obj) { // try-catch koymadim. bu islemi yapmada
										// bir sorun varsa uygulama bir
										// Exception firlatabilmeli, yoksa
										// mantiksal olarak kontrol etmek
										// guclesir.
		Session session = sessionFactory.getCurrentSession();
		session.delete(obj);
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List find(String hql, List<Object[]> parameters, Integer firstResult, Integer dataCount) {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.createQuery(hql);
		if (firstResult != null && dataCount != null) {
			query.setFirstResult((firstResult - 1) * dataCount);
			query.setMaxResults(dataCount);
		}

		addParametersToQuery(parameters, query);

		return query.list();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object uniqueResult(String hql, List<Object[]> parameters) {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.createQuery(hql);

		addParametersToQuery(parameters, query);

		return query.uniqueResult();
	}

	@SuppressWarnings({ "rawtypes" })
	private void addParametersToQuery(List<Object[]> parameters, Query query) {
		if (parameters != null && !parameters.isEmpty()) {
			Iterator<Object[]> it = parameters.iterator();
			while (it.hasNext()) {
				Object[] obj = it.next();
				String property = (String) obj[0];

				if (obj[1] instanceof Integer)
					query.setInteger(property, (Integer) obj[1]);
				else if (obj[1] instanceof Double)
					query.setDouble(property, (Double) obj[1]);
				else if (obj[1] instanceof Long)
					query.setLong(property, (Long) obj[1]);
				else if (obj[1] instanceof Calendar)
					query.setCalendar(property, (Calendar) obj[1]);
				else if (obj[1] instanceof Date)
					query.setDate(property, (Date) obj[1]);
				else if (obj[1] instanceof String)
					query.setString(property, (String) obj[1]);
				else if (obj[1] instanceof Float)
					query.setFloat(property, (Float) obj[1]);
				else if (obj[1] instanceof BigDecimal)
					query.setBigDecimal(property, (BigDecimal) obj[1]);
				else if (obj[1] instanceof Boolean)
					query.setBoolean(property, (Boolean) obj[1]);
				else if (obj[1] instanceof Collection)
					query.setParameterList(property, (Collection) obj[1]);
			}

		}
	}

	public Calendar getBugun() {
		
		return Calendar.getInstance();
	}
	public String getIp(){
		String ipAddr = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes())
        .getRequest().getRemoteAddr();
		return ipAddr;
	}
	


	public Kullanici findKullaniciByKullaniciAdi(String username) {
		
		String sql =	" select * " +
						" from Kullanici k " +
						" where k.user_name=:username";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.setString("username", username);	
		query.addEntity("k", Kullanici.class);
		List list = query.list();

		if (list != null && !list.isEmpty()) {
			Kullanici person = (Kullanici) list.get(0);
			return person;
		}
		return null;

	}
	
	public String yeniParolaOlustur(){
		String validChars="qazxswedcvfrtbnhyujmkolp1234567890!^+%&/?*";
		String createdString="";
		Random generator = new Random();
		for (int i = 0; i <8; i++){
			char ch = validChars.charAt(generator.nextInt(validChars.length()));
			String s = ""+ch;
			createdString += s;
		}
		return createdString;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public List listSBFStokKalanLog() {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.getNamedQuery("listSBFStokKalanLog");
		List list = new ArrayList();
		list = query.list();
		
		return list;
	}

	public List listKullanici() {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.getNamedQuery("listKullanici");
		List list = new ArrayList();
		list = query.list();
		
		return list;
	}
	
	public List<Kullanici> listKullaniciById(Long id){
		
		String sql =	" select * " +
						" from Kullanici k " +
						" where k.id="+id;
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.addEntity("k", Kullanici.class);

		return query.list();
		
	}
	
	public List<Person> listPerson(){
		
		String sql =	" select * " +
						" from person p ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.addEntity("p", Person.class);

		return query.list();
		
	}
	
	public List<Role> listTumRoller() {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.getNamedQuery("listTumRoller");
		List list = new ArrayList();
		list = query.list();
		
		return list;
	}
	
	public boolean kullaniciAdiUygunMu(String kullaniciAdi){
		
		String sql =	" select * " +
						" from kullanici k " +
						" where k.user_name =:username";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		
		query.setString("username", kullaniciAdi);	
		query.addEntity("k", Kullanici.class);
		List list = query.list();
		
		if (list != null && !list.isEmpty())
			return false;
		return true;
				
	}
	
	public List<Berth> listBerthByMarinaId(Long marinaid){
		
		String sql = 	" select * " + 
						" from "+Constant.SCHEMA_ADI+".berth b " + 
						" where b.marina_id =:marinaid" + 
						" ";
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		
		query.setLong("marinaid", marinaid);
		query.addEntity("b", Berth.class);
		List<Berth> list = query.list();
		
		if(list != null && !list.isEmpty())
			return list;
		return null;
	}

	
	
	public List<Berth> listBerthByFilteringCriterias(HashMap<String, String> filterMap)
	{
		String criterias = "";
		String queryStr = "";
		String criteriasDate = "";
		Integer counterCriteria = 0;
		
		if(filterMap.isEmpty() == false)
		{ 
			if(filterMap.containsKey("status") == true)
			{
				criterias += " b.status='" + filterMap.get("status") + "'";
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("electricity_capacity") == true)
			{
				criterias += " b.electricity_capacity=" + filterMap.get("electricity_capacity");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("water_capacity") == true)
			{
				criterias += " b.water_capacity=" +filterMap.get("water_capacity");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("fuel_capacity") == true)
			{
				criterias += " b.fuel_capacity=" + filterMap.get("fuel_capacity");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			/*
			 * MAX & MIN WIDTH  
			 *
			 */
			if(filterMap.containsKey("min_width") == true && filterMap.containsKey("max_width") == false)
			{
				criterias += " b.min_width>=" + filterMap.get("min_width");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("max_width") == true && filterMap.containsKey("min_width") == false)
			{
				criterias += " b.max_width<=" + filterMap.get("max_width");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("max_width") == true && filterMap.containsKey("min_width") == true)
			{
				criterias += " b.min_width BETWEEN " + filterMap.get("min_width") + " AND " + filterMap.get("max_width") + " OR " +
						 " b.max_width BETWEEN " + filterMap.get("min_width") + " AND " + filterMap.get("max_width") + " OR " +
						 " b.min_width >= " + filterMap.get("min_width") + " AND b.max_length <= " + filterMap.get("max_width");
				
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			
			/*
			 *  
			 *  MAX & MIN LENGTH
			 * 
			 */
			if(filterMap.containsKey("min_length") == true && filterMap.containsKey("max_length") == false)
			{
				criterias += " b.min_length>=" + filterMap.get("min_length");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("max_length") == true && filterMap.containsKey("min_length") == false)
			{
				
				criterias += " b.max_length<=" + filterMap.get("max_length");
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			if(filterMap.containsKey("max_length") == true && filterMap.containsKey("min_length") == true)
			{
				criterias += " b.min_length BETWEEN " + filterMap.get("min_length") + " AND " + filterMap.get("max_length") + " OR " +
				 " b.max_length BETWEEN " + filterMap.get("min_length") + " AND " + filterMap.get("max_length") + " OR " +
				 " b.min_length >= " + filterMap.get("min_length") + " AND b.max_length <= " + filterMap.get("max_length");
				
				counterCriteria++;
				if(counterCriteria < filterMap.size())
					criterias += " AND ";
			}
			

			if(filterMap.containsKey("reservation_start_date") == true && filterMap.containsKey("reservation_end_date") == true)
			{
				
				// List all reservations with status APPLIED or APPROVED with respect to the given date range
				criteriasDate += " b.id NOT IN " + 
								 " (SELECT DISTINCT r.berth_id " +
								 " FROM dbo.reservation r " +
								 " WHERE (r.status = 0 " + // Meaning that the reservations is on APPLIED status
								 " OR r.status = 100) AND "+ // Meaning that the reservation is on APPROVED status
								 " r.reservation_start_date BETWEEN CONVERT(Datetime, '"+filterMap.get("reservation_start_date")+"', 120) AND CONVERT(Datetime, '"+filterMap.get("reservation_end_date")+"', 120) OR " +
								 " r.reservation_end_date BETWEEN CONVERT(Datetime, '"+filterMap.get("reservation_start_date")+"', 120) AND CONVERT(Datetime, '"+filterMap.get("reservation_end_date")+"', 120) OR " +
								 " r.reservation_start_date <= CONVERT(Datetime, '"+filterMap.get("reservation_start_date")+"', 120) AND r.reservation_end_date >= CONVERT(Datetime, '"+filterMap.get("reservation_end_date")+"', 120)) ";
			}
		}
		
		// If any of the filtering options are typed, process the related query
		if(criterias != "")
		{
			queryStr = " SELECT * FROM " + Constant.SCHEMA_ADI + ".berth b " +
					   " WHERE " + criterias;
						
						// If date range is also specified in the filtering options, add it to the query
						if(criteriasDate != "") {
							queryStr += criteriasDate;
						}
						
		}
		// If only the date range is specified in the filtering options, only process the date range to the query
		else if (criteriasDate != "") {
			
			queryStr = " SELECT * FROM " + Constant.SCHEMA_ADI + ".berth b " +
					   " WHERE " + criteriasDate;
		}
		// If nothing is specified in the filtering options, run a default query to gather everything
		else
		{
			queryStr = " SELECT * FROM " + Constant.SCHEMA_ADI + ".berth";
			//return null;
		}
		
		System.out.println("Filter Query: "+ queryStr);
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(queryStr);
		
		query.addEntity("b", Berth.class);
		List<Berth> list = query.list();
		
		if(list != null && !list.isEmpty()) {
			return list;
		}
		
		return null;		
	}
	
	public List<Invoice> findInvoices(String fromDate, String toDate) {
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".invoice i " +
						" WHERE i.cut_off_date BETWEEN CONVERT(Datetime, '"+fromDate+"', 120) AND CONVERT(Datetime, '"+toDate+"', 120)";
		
		
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.addEntity("i" , Invoice.class);
		
		List<Invoice> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;

	}
	
	public List<Object[]> findConsumptions(Long invoceId) {
		
		String sql =	" SELECT i.id, i.yacht_id, y.name as yachtname, i.consumption, ys.service_id, s.name as servicename, CONVERT(VARCHAR(10), ys.timestamp, 104) as ys_timestamp, ys.price " +
						" FROM "+Constant.SCHEMA_ADI+".invoice i, " +
						" "+Constant.SCHEMA_ADI+".invoice_yactht_service iys, "+
						" "+Constant.SCHEMA_ADI+".yacht_service ys, "+
						" "+Constant.SCHEMA_ADI+".service s, "+
						" "+Constant.SCHEMA_ADI+".yacht y " +
						" WHERE i.id=iys.invoice_id " + 
						" AND iys.yacht_service_id=ys.id " + 
						" AND ys.service_id=s.id " + 
						" AND ys.yacht_id=y.id " + 
						" AND i.id="+invoceId+" " + 
						" ORDER BY ys.timestamp DESC";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		//query.setLong("invoceid", invoceId);

		List<Object[]> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;

	}
	
	public List<GeneralService> listService(){
		
		String sql =	" select * " +
						" from "+Constant.SCHEMA_ADI+".service p ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.addEntity("p", GeneralService.class);
		
		List<GeneralService> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;
		
	}
	
	public List<Object[]> findReservations(String fromDate, String toDate, Long userId, String userRole, Long userRoleId) {
		
		String sql ="";
		
		if (userRoleId.equals(Role.ROLE_SYSTEM_ADMINISTRATOR_ID)) {
			
			/*
			sql =	" SELECT * " +
					" FROM "+Constant.SCHEMA_ADI+".reservation r " +
					" WHERE r.reservation_start_date >= CONVERT(Datetime, '"+fromDate+"', 120) " +
					" AND r.reservation_end_date <= CONVERT(Datetime, '"+toDate+"', 120)";
			*/
			
			
			sql =	" SELECT r.id as reservation_id, r.status, CONVERT(VARCHAR(10), r.reservation_start_date, 104) as r_start_date, CONVERT(VARCHAR(10), r.reservation_end_date, 104) as r_end_date, y.name as yacht_name, b.name as berth_name, m.name as marina_name, r.reservation_status, r.time_status " +
					" FROM "+Constant.SCHEMA_ADI+".reservation r, " +
					" "+Constant.SCHEMA_ADI+".person p, "+
					" "+Constant.SCHEMA_ADI+".kullanici k, "+
					" "+Constant.SCHEMA_ADI+".yacht y, " +
					" "+Constant.SCHEMA_ADI+".berth b, " +
					" "+Constant.SCHEMA_ADI+".marina m " +
					" WHERE k.person_id=p.id " +
					" AND r.yacht_id=y.id " +
					" AND r.berth_id=b.id " +
					" AND y.owner_id=p.id " +
					" AND b.marina_id=m.id " +
					" AND r.reservation_start_date >= CONVERT(Datetime, '"+fromDate+"', 120) " +
					" AND r.reservation_end_date <= CONVERT(Datetime, '"+toDate+"', 120) " +
					" ORDER BY r.reservation_end_date DESC";
			
		} else if (userRoleId.equals(Role.ROLE_MARINA_OWNER_ID)) {
			
			sql =	" SELECT r.id as reservation_id, r.status, CONVERT(VARCHAR(10), r.reservation_start_date, 104) as r_start_date, CONVERT(VARCHAR(10), r.reservation_end_date, 104) as r_end_date, y.name as yacht_name, b.name as berth_name, m.name as marina_name, r.reservation_status, r.time_status " +
					" FROM "+Constant.SCHEMA_ADI+".reservation r, " +
					" "+Constant.SCHEMA_ADI+".person p, "+
					" "+Constant.SCHEMA_ADI+".person_role pr, "+ //Additional part for role check
					" "+Constant.SCHEMA_ADI+".role role, "+ //Additional part for role check
					" "+Constant.SCHEMA_ADI+".kullanici k, "+
					" "+Constant.SCHEMA_ADI+".yacht y, " +
					" "+Constant.SCHEMA_ADI+".berth b, " +
					" "+Constant.SCHEMA_ADI+".marina m " +
					" WHERE k.person_id=p.id " +
					" AND p.id=pr.person_id " + //Additional part for role check
					" AND pr.role_id=role.id " + //Additional part for role check
					" AND r.yacht_id=y.id " +
					" AND r.berth_id=b.id " +
					" AND y.owner_id=p.id " +
					" AND b.marina_id=m.id " +
					" AND role.id="+userRoleId+" " + //Additional part for role check
					" AND r.reservation_start_date >= CONVERT(Datetime, '"+fromDate+"', 120) " +
					" AND r.reservation_end_date <= CONVERT(Datetime, '"+toDate+"', 120) " +
					" ORDER BY r.reservation_end_date DESC";
			
		} else {
			
			sql =	" SELECT r.id as reservation_id, r.status, CONVERT(VARCHAR(10), r.reservation_start_date, 104) as r_start_date, CONVERT(VARCHAR(10), r.reservation_end_date, 104) as r_end_date, y.name as yacht_name, b.name as berth_name, m.name as marina_name, r.reservation_status, r.time_status " +
					" FROM "+Constant.SCHEMA_ADI+".reservation r, " +
					" "+Constant.SCHEMA_ADI+".person p, "+
					" "+Constant.SCHEMA_ADI+".kullanici k, "+
					" "+Constant.SCHEMA_ADI+".yacht y, " +
					" "+Constant.SCHEMA_ADI+".berth b, " +
					" "+Constant.SCHEMA_ADI+".marina m " +
					" WHERE k.person_id=p.id " +
					" AND r.yacht_id=y.id " +
					" AND r.berth_id=b.id " +
					" AND y.owner_id=p.id " +
					" AND b.marina_id=m.id " +
					" AND k.id="+userId+" " +
					" AND r.reservation_start_date >= CONVERT(Datetime, '"+fromDate+"', 120) " +
					" AND r.reservation_end_date <= CONVERT(Datetime, '"+toDate+"', 120) " +
					" ORDER BY r.reservation_end_date DESC";
			
		}
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		
		List<Object[]> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;

	}
	
	public Person getPersonByEmail(String email){
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".person p " +
						" WHERE p.email LIKE '"+email+"' AND status = 1" + 
						" ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
//		query.setString("email", email);	
		query.addEntity("p" , Person.class);
		
		List<Person> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}
	
	public Kullanici findKullaniciByPersonId(Long personid){
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".kullanici k " +
						" WHERE k.person_id =:personid AND k.status = 1" + 
						" ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.setLong("personid", personid);	
		query.addEntity("k" , Kullanici.class);

		List<Kullanici> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}
	
	public void deletePersonByPersonId(Long personId) {
		String hql = "update Person set status=0 where id="+personId;
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	public Boolean getWaitingReservationByPerson(Person person){
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".reservation r " + 
						" INNER JOIN "+Constant.SCHEMA_ADI+".person p on p.id =:personid" +
						" INNER JOIN "+Constant.SCHEMA_ADI+".yacht y on y.owner_id = p.id" +
						" WHERE r.yacht_id = y.id AND r.status = 0 AND r.reservation_status ="+Reservation.RESERVATION_STATUS_APPLIED + 
						" ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.setLong("personid", person.getId());	
		query.addEntity("r" , Reservation.class);

		List<Reservation> list = query.list();

		if (list != null && !list.isEmpty()) {
			return true;
		}
		return false;
	}
	
	public Yacht getYachtByPerson(Person person){
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".yacht y " +
						" WHERE y.owner_id =:personid" + 
						" ";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.setLong("personid", person.getId());	
		query.addEntity("y" , Yacht.class);

		List<Yacht> list = query.list();

		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}
	
	@Scheduled(cron = "0 02 08 * * *")
	public void updateReservationtoActive(){
		String hql = "update Reservation set status=1 where reservation_start_date=CONVERT (date, SYSDATETIME()) and reservation_status="+Reservation.RESERVATION_STATUS_APPROVED;
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	@Scheduled(cron = "0 58 23 * * *")
	public void updateReservationtoPassive(){
		String hql = "update Reservation set status=0 where reservation_end_date=CONVERT (date, SYSDATETIME()) ";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	@Scheduled(cron = "0 55 23 * * *")
	public void updateTimeStatustoPassed(){
		String hql = "update Reservation set time_status=0 where reservation_end_date=CONVERT (date, SYSDATETIME()) ";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
}