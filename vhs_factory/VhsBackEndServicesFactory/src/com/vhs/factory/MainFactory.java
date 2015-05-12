package com.vhs.factory;

import com.vhs.factory.core.SourceCodeGenerator;

/**
 * Source code generator
 * 
 * @author Alex Vicente Chacon Jimenez (av.chacon10@uniandes.edu.co)
 *
 */
public class MainFactory
{

	/**
	 * Main class entry point
	 * @param args current class arguments
	 * @throws Exception current exception
	 */
	public static void main(String[] args) throws Exception
	{
		String projectBasePath = args[0];
		String rawPresentFeatures = args[1];
		
		SourceCodeGenerator sourceCodeGenerator = new SourceCodeGenerator(projectBasePath, rawPresentFeatures);
		sourceCodeGenerator.generateCode();
	}

}
