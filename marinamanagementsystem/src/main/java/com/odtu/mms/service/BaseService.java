package com.odtu.mms.service;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
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
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.odtu.mms.model.Berth;
import com.odtu.mms.model.Invoice;
import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Marina;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Role;
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
	public List find(String hql, List parameters, Integer firstResult, Integer dataCount) {
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
	public Object uniqueResult(String hql, List parameters) {
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
	
	public List<Invoice> findInvoices(Date fromDate, Date toDate) {
		
		String sql =	" SELECT * " +
						" FROM "+Constant.SCHEMA_ADI+".invoice i " +
						" WHERE i.cut_off_date BETWEEN '"+fromDate+"' AND '"+toDate+"'";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.addEntity("i" , Invoice.class);
		
		List list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;

	}
	
	public List<Invoice> findConsumptions(Long invoceId) {
		
		String sql =	" SELECT i.id, i.yacht_id, i.consumption, y_s.service_id, s.name, y_s.timestamp, y_s.price " +
						" FROM "+Constant.SCHEMA_ADI+".invoice i, "+Constant.SCHEMA_ADI+".invoice_yacht_service i_y_s, "+Constant.SCHEMA_ADI+".yacht_service y_s, "+Constant.SCHEMA_ADI+".service s " +
						" WHERE i.yacht_id=i_y_s.invoice_id AND i_y_s.yacht_service_id=y_s.id AND y_s.service_id=s.id AND " +
						" i.id=:invoceid";
		
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		query.setLong("invoceid", invoceId);	

		List list = query.list();

		if (list != null && !list.isEmpty()) {
			return list;
		}
		return null;

	}
	
}