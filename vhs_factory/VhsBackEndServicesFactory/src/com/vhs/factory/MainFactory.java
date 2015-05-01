package com.vhs.factory;

/**
 * Main factory builder entry point
 * 
 * @author Camilo Baquero (c.baquero10@uniandes.edu.co)
 * @author Ernesto Nobmann (ef.nobmann@uniandes.edu.co)
 * @author Andres Vargas (ja.vargas1477@uniandes.edu.co)
 * @author Ivan Garcia (if.garcia11@uniandes.edu.co)
 */
public class MainFactory
{

	/**
	 * Main class entry point
	 * @param args current class arguments
	 */
	public static void main(String[] args)
	{
		// Reading the file
		
		MyFileReader mfr = new MyFileReader("data/testFile.txt");
		mfr.readFile();
		mfr.printFile();
		
		//
		// Velocity variability implementation
		
		//
		// Aspects variability implementation
		
		//
		// Software patterns variability implementation
		
		//
		// Spoon variability implementation
		
	}

}
