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
	private final static String _BASE_EXT = ".java.vm";
	
	/**
	 * Base Java extension
	 */
	private final static String _BASE_EXT_JAVA = ".java";
	
	/**
	 * Base feature extension
	 */
	private final static String _BASE_ASPECT = "@VHSFeature(featurePresent = false, name = \"NAME\", type = VHSFeature.Type.OPTIONAL)";
	
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
	        
	        for (String presentFeatures : this.context.getPresentFeatures())
	        {
	        	context.put(presentFeatures, "");
	        }
	        
	        for (String notPresentFeatures : this.context.getNotPresentFeatures())
	        {
	        	context.put(notPresentFeatures, _BASE_ASPECT.replaceFirst("NAME", notPresentFeatures));
	        }
	        
	        FileWriter writer = new FileWriter(current.replaceAll(_BASE_EXT, _BASE_EXT_JAVA));
	        
	        template.merge( context, writer );
	        
	        writer.close();
	        System.out.println(current);
		}
	}
}
