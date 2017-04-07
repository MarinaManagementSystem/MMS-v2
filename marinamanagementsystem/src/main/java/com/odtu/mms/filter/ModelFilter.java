package com.odtu.mms.filter;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.Constant;

import mva.util.MVAUtil;

public class ModelFilter {

	public String modelName;
	public String connector;
	public List<Object[]> filterList;
	List<Object> parameters = new ArrayList();
	public String order ="";
	private Integer firstResult=null;
	private Integer maxResult=null;
	private String hql="";
	private String[] objectProperty;
	private String[] leftJoin;
	private String[] join;
	private boolean distinct=false;
	private boolean maxSum=false;
	Integer count = 1;
	Integer startCount=null;
	Integer endCount=null;
	Integer kayitSayisi = Constant.SAYFA_LISTLEME_ELEMAN_SAYISI;
	
	Map map = new HashMap ();
	
	public ModelFilter(String modelName,  List filterList, String connector,String order){
		this.modelName=modelName;
		this.filterList=filterList;
		this.connector=connector;
		this.order=order;
		
	}

	public ModelFilter(String modelName,  List filterList, String connector,String order,Integer startCount, Integer endCount){
		this.modelName=modelName;
		this.filterList=filterList;
		this.connector=connector;
		this.order=order;
		this.startCount=startCount;
		this.endCount=endCount;
		
	}

	
	public ModelFilter(String modelName,  List filterList, String connector,String order,String[] leftJoin,String []join){
		this.modelName=modelName;
		this.filterList=filterList;
		this.connector=connector;
		this.order=order;
		this.leftJoin=leftJoin;
		this.join = join;
	}
	
	public ModelFilter(String modelName,  List filterList, String connector,String order,String[] leftJoin,String []join,boolean distinct){
		this.modelName=modelName;
		this.filterList=filterList;
		this.connector=connector;
		this.order=order;
		this.leftJoin=leftJoin;
		this.join = join;
		this.distinct=distinct;
		
	}
	
	
	public ModelFilter(String modelName,  List filterList, String connector,String order,String[] objectProperty,boolean distinct,String[] leftJoin,boolean maxSum){
		this.modelName=modelName;
		this.filterList=filterList;
		this.connector=connector;
		this.order=order;
		this.objectProperty=objectProperty;
		this.distinct=distinct;
		this.leftJoin=leftJoin;
		this.maxSum=maxSum;
	}
	
	public void createHqlQuery(){
		hql = "";

		if(join != null){
			hql += "select ";
			if(distinct)
				hql += " distinct ";
			hql += " o ";
		}
		
		if( !MVAUtil.isEmpty(this.modelName) )
			hql += " from "+this.modelName+" o ";
		if(leftJoin != null){
			for(int i=0; i< leftJoin.length; i++){
				hql += " left join o."+leftJoin[i]+" ";
			}
		}
		if(join != null  ){
			for(int i=0; i< join.length; i++){
				if(!MVAUtil.isEmpty(join[i]))
					hql += " inner join o."+join[i]+" ";
			}
		}
		if(!filterList.isEmpty()){
			hql += " where ";
			Iterator<Object[]> it = filterList.iterator();
			while (it.hasNext()){
				Object[] objArr = it.next();
				String property = (String) objArr[0];
				String operator = (String) objArr[2];
				Object obj = objArr[1];
				
				if(operator.equals(Constant.IS_NULL) || operator.equals(Constant.IS_NOT_NULL))
					hql += "o."+property+" "+operator;
				else if( operator.equals(Constant.IN) || operator.equals(Constant.NOT_IN) ){
					hql += "o."+property+" "+operator+" ("+obj+") ";
				}else if (operator.equals(Constant.LIKE) || operator.equals(Constant.NOT_LIKE)){
					hql += "upper("+"o."+property+")  "+operator+" upper('%"+obj+"%') ";
				}else if (operator.equals(Constant.RIGHT_LIKE) ){
					hql += "nls_upper("+"o."+property+",'nls_sort=XTURKISH') "+operator+" nls_upper('"+obj+"%','nls_sort=xturkish') ";
				}
				else if(operator.equals(Constant.CUSTOM)){
					hql +=" o."+property+" ";
				}else if(operator.equals(Constant.JOIN)){
					hql +=" "+property+" ";
				}
				else {
					String param = property.replace(".", "");
					if(map.get(param) != null){
						param=param+count;
						count ++;
					}else
						map.put(param, param);
					
					hql += "o."+property+operator+":"+param.trim();
					Object o[]=new Object[2];
					o[0] = param.trim();
					o[1] = obj;
					parameters.add(o);
				}
				if(it.hasNext())
					hql += " and ";
			}
		}
		if(!MVAUtil.isEmpty(order))
			hql += " order by "+order+" ";
		
	}
	
	public void createCountHqlQuery(){
		hql = "select count(*) ";
		//20120815@ali join ekledigimizde bize asil nesne ve sonradan eklenen nesnelerin
		//tumunun oldugu bir obcejt array donuyor, bunu engellemek icin en azindan 
		//asil nesne select ile alinmali, simdilik join bos degilse select o ekledim.
		//baska bir method dusunulebilir. 
		
		if( !MVAUtil.isEmpty(this.modelName) )
			hql += " from "+this.modelName+" o ";
		if(leftJoin != null){
			for(int i=0; i< leftJoin.length; i++){
				hql += " left join o."+leftJoin[i]+" ";
			}
		}
		if(join != null  ){
			for(int i=0; i< join.length; i++){
				if(!MVAUtil.isEmpty(join[i]))
					hql += " inner join o."+join[i]+" ";
			}
		}
		if(!filterList.isEmpty()){
			hql += " where ";
			Iterator<Object[]> it = filterList.iterator();
			while (it.hasNext()){
				Object[] objArr = it.next();
				String property = (String) objArr[0];
				String operator = (String) objArr[2];
				Object obj = objArr[1];
				
				if(operator.equals(Constant.IS_NULL) || operator.equals(Constant.IS_NOT_NULL))
					hql += "o."+property+" "+operator;
				else if( operator.equals(Constant.IN) || operator.equals(Constant.NOT_IN) ){
					hql += "o."+property+" "+operator+" ("+obj+") ";
				}else if (operator.equals(Constant.LIKE) || operator.equals(Constant.NOT_LIKE)){
					hql += "nls_upper("+"o."+property+",'nls_sort=XTURKISH') "+operator+" nls_upper('%"+obj+"%','nls_sort=xturkish') ";
				}else if (operator.equals(Constant.RIGHT_LIKE) ){
					hql += "nls_upper("+"o."+property+",'nls_sort=XTURKISH') "+operator+" nls_upper('"+obj+"%','nls_sort=xturkish') ";
				}else if(operator.equals(Constant.CUSTOM)){
					hql +=" o."+property+" ";
				}else if(operator.equals(Constant.JOIN)){
					hql +=" "+property+" ";
				}
				else {
					String param = property.replace(".", "");
					if(map.get(param) != null){
						param=param+count;
						count ++;
					}else
						map.put(param, param);
					
					hql += "o."+property+operator+":"+param.trim();
					Object o[]=new Object[2];
					o[0] = param.trim();
					o[1] = obj;
					parameters.add(o);
				}
				if(it.hasNext())
					hql += " and ";
			}
		}
		if(!MVAUtil.isEmpty(order))
			hql += " order by "+order+" ";
	}
	
	public void createObjectArrayHqlQuery(){
		hql = "";
		if(objectProperty != null ){
			hql += "select ";
			if(distinct)
				hql += " distinct ";
			for(int i=0; i< objectProperty.length; i++){
				if(!this.maxSum)
					hql += "o."+objectProperty[i]+" ";
				else
					hql+=objectProperty[i]+" ";
				if(i <objectProperty.length-1)
					hql += ",";
			}
		}
		if( !MVAUtil.isEmpty(this.modelName) )
			hql += " from "+this.modelName+" o ";

		if(leftJoin != null){
			for(int i=0; i< leftJoin.length; i++){
				hql += " left join o."+leftJoin[i]+" ";
			}
		}
		
		if(!filterList.isEmpty()){
			hql += " where ";
			Iterator<Object[]> it = filterList.iterator();
			while (it.hasNext()){
				Object[] objArr = it.next();
				String property = (String) objArr[0];
				String operator = (String) objArr[2];
				Object obj = objArr[1];
				
				if(operator.equals(Constant.IS_NULL) || operator.equals(Constant.IS_NOT_NULL))
					hql +="o."+property+" "+operator;
				else if( operator.equals(Constant.IN) || operator.equals(Constant.NOT_IN) ){
					hql += "o."+property+" "+operator+" ("+obj+") ";
				}else if(operator.equals(Constant.CUSTOM)){
					hql +=" o."+property+" ";
				}else if(operator.equals(Constant.JOIN)){
					hql +=" "+property+" ";
				}
				else {
					String param = property.replace(".", "");
					if(map.get(param) != null){
						param=param+count;
						count ++;
					}else
						map.put(param, param);
			
					
					hql += "o."+property+operator+":"+param;
					Object o[]=new Object[2];
					o[0] = param;
					o[1] = obj;
					parameters.add(o);
				}
				if(it.hasNext())
					hql += " and ";
			}
		}
		if(!MVAUtil.isEmpty(order))
			hql += " order by "+order+" ";
	}	
	
	
	public Integer getCount(BaseService bus){
		parameters = new ArrayList();
		createCountHqlQuery();
		List<Long> l = bus.find(hql, parameters, null, null);
		if(l != null && !l.isEmpty())
			return l.get(0).intValue();
		
		return 0;
	}
	
	public List runHql(BaseService bus){
		createHqlQuery();
		return bus.find(hql, parameters,startCount,Constant.LIST_SIZE);
	}
	
	public List runObjectArrayHql(BaseService bus){
		createObjectArrayHqlQuery();
		return bus.find(hql, parameters,startCount,endCount);
	}	
}
