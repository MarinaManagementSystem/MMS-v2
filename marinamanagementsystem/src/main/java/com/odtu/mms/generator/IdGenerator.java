package com.odtu.mms.generator;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.dialect.Dialect;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.exception.JDBCExceptionHelper;
import org.hibernate.id.Configurable;
import org.hibernate.id.IdentifierGenerator;
import org.hibernate.id.PersistentIdentifierGenerator;
import org.hibernate.type.Type;

import com.odtu.mms.util.Constant;


public class IdGenerator implements IdentifierGenerator, Configurable {
	private String tableName;

	public Serializable generate(SessionImplementor sessionImplemetor,
			Object object) throws HibernateException {
		return getNextNumber(sessionImplemetor);
	}

	public synchronized void configure(Type type, Properties params, Dialect d)
	throws MappingException {
		tableName = params.getProperty(PersistentIdentifierGenerator.TABLE);
	}

	private synchronized Long getNextNumber(SessionImplementor session) {
		String sql = "select id from "+Constant.SCHEMA_ADI+".table_id where table_name=?";
		Long nextValue = null;
		boolean isValueReturn = false;
		try {
			PreparedStatement st = session.getBatcher().prepareStatement(sql);
			st.setString(1, tableName);
			try {
				ResultSet rs = st.executeQuery();
				try { 
					while (rs.next()) {
						nextValue = Long.parseLong(rs.getString(1));
						isValueReturn = true;
					}
				} finally {
					rs.close();
					if(!isValueReturn){
						nextValue=1L;
						String InsertSql = "insert into "+Constant.SCHEMA_ADI+".table_id (id,table_name) values(?,?)";
						try {
							PreparedStatement stInsert = session.getBatcher().prepareStatement(InsertSql);
							stInsert.setLong(1, 2L);
							stInsert.setString(2, tableName);
							try {
								stInsert.executeUpdate();
								
							} finally {
								session.getBatcher().closeStatement(stInsert);
								session.connection().commit();
							}
						} catch (SQLException sqle) {
							throw JDBCExceptionHelper.convert(session.getFactory()
									.getSQLExceptionConverter(), sqle,
									"could not fetch initial value for increment generator",
									sql);
						}
						
					}
					
				}
			} finally {
				session.getBatcher().closeStatement(st);
			}
		} catch (SQLException sqle) {
			throw JDBCExceptionHelper.convert(session.getFactory()
					.getSQLExceptionConverter(), sqle,
					"could not fetch initial value for increment generator",
					sql);
		}
		if(isValueReturn){
			String updateSql = "update "+Constant.SCHEMA_ADI+".table_id set id=? where table_name=?";
			try {
				PreparedStatement stUpdate = session.getBatcher().prepareStatement(updateSql);
				Long newValue = nextValue+1;
				stUpdate.setLong(1, newValue);
				stUpdate.setString(2, tableName);
				try {
					stUpdate.executeUpdate();

				} finally {
					session.getBatcher().closeStatement(stUpdate);
					session.connection().commit();
				}
			} catch (SQLException sqle) {
				throw JDBCExceptionHelper.convert(session.getFactory()
						.getSQLExceptionConverter(), sqle,
						"could not fetch initial value for increment generator",
						sql);
			}
		}
		return nextValue;
	}
}