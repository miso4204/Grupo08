package com.vhs.factory.core;

import java.io.File;
import java.io.FileWriter;
import java.util.Properties;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import com.vhs.factory.finder.Spider;
import com.vhs.factory.readers.FactoryVelocityContext;

/**
 * Source code generator
 * 
 * @author Alex Vicente ChaconJimenez (av.chacon10@uniandes.edu.co)
 *
 */
public class SourceCodeGenerator 
{
	/**
	 * Base extension
	 */
	private final static String _BASE_EXT = ".vm";
	
	/**
	 * PostgreSQL JPA
	 */
	private final static String _POSTGRESQL_JPA = "java:/jboss/datasources/PostgreSQLDS";
	
	/**
	 * Oracle JPA
	 */
	private final static String _ORACLE_JPA = "java:/jboss/datasources/OracleDS";
	
	/**
	 * Persistence XML file
	 */
	private final static String _PERSISTENCE_XML = "persistence.xml";
	
	
	
	/**
	 * Base feature extension
	 */
	private final static String _BASE_ASPECT = "@com.vhs.annotations.VHSFeature(featurePresent = false, name = \"NAME\", type = com.vhs.annotations.VHSFeature.Type.OPTIONAL)";
	
	
	/**
	 * Current project spider
	 */
	private Spider spider;
	
	/**
	 * Application context
	 */
	private FactoryVelocityContext context;
	
	/**
	 * Project path
	 */
	private String projectPath;
	
	/**
	 * Raw present features
	 */
	private String rawPresentFeatures;

	/**
	 * @param projectPath project path
	 * @param rawPresentFeatures raw present features
	 */
	public SourceCodeGenerator(String projectPath, String rawPresentFeatures) 
	{
		this.projectPath = projectPath;
		this.rawPresentFeatures = rawPresentFeatures;
		this.spider = new Spider(_BASE_EXT);
	}
	
	/**
	 * Code generation business logic
	 * @throws Exception current exception
	 */
	public void generateCode () throws Exception
	{
		this.context = new FactoryVelocityContext(this.rawPresentFeatures);
		this.context.loadFeatures();
		
		this.spider.find(this.projectPath);
		
		for (String current: this.spider.getFoundPaths())
		{
			File file = new File (current);
			Properties prop = new Properties();
			prop.put("file.resource.loader.path", file.getParent());
			 
			VelocityEngine ve = new VelocityEngine();
	        ve.init(prop);
	        Template template = ve.getTemplate( file.getName() );
	        
	        VelocityContext context = new VelocityContext();
	        
	        boolean scalabilityEnable = false;
	        boolean scalabilityFound = false;
	        for (String presentFeatures : this.context.getPresentFeatures())
	        {
	        	//
	        	// Quality Attributes: Go to Oracle Data base
	        	if (current.contains(_PERSISTENCE_XML))
        		{
	        		if (presentFeatures.contains("Scalability"))
	        		{
	        			context.put(presentFeatures, _ORACLE_JPA);
	        			scalabilityEnable = true;
	        			scalabilityFound = true;
	        		}
        		}
	        	
	        	//
	        	// Quality Attributes: Go to two Jboss nodes
	        	else if (presentFeatures.contains("Performance"))
	        	{
	        		
	        	}
	        	else
	        	{
	        		context.put(presentFeatures, "");
	        	}
	        }
	        
	        if (!scalabilityEnable && current.contains(_PERSISTENCE_XML))
	        {
	        	context.put("Scalability", _POSTGRESQL_JPA);
	        	scalabilityFound = true;
	        }
	        
	        for (String notPresentFeatures : this.context.getNotPresentFeatures())
	        {
	        	if (!scalabilityFound)
	        		context.put(notPresentFeatures, _BASE_ASPECT.replaceFirst("NAME", notPresentFeatures));
	        }
	        
	        FileWriter writer = new FileWriter(current.replaceAll(_BASE_EXT, ""));
	        
	        template.merge( context, writer );
	        
	        writer.close();
	        System.out.println(current);
		}
	}
}
