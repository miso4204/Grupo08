package com.vhs.factory.finder;
import java.io.File;
import java.util.ArrayList;
import java.util.List;


/**
 * Spider directory special file finder
 * 
 * @author Alex Vicente Chacon Jimenez (av.chacon10@uniandes.edu.co)
 *
 */
public class Spider 
{
	/**
	 * Found paths to update
	 */
	private List <String> foundPaths;
	
	/**
	 * Extensions to filter 
	 */
	private String baseExtFiler;
	
	/**
	 * Base constructor
	 * @param baseExtFiler baseExtFilter
	 */
	public Spider(String baseExtFiler) 
	{
		this.foundPaths = new ArrayList<String>();
		this.baseExtFiler = baseExtFiler;
		
	}
	
	/**
	 * Find objects spider
	 * 
	 * @param basePath base path
	 */
	public void find (String basePath )
	{
		File baseFile = new File (basePath);
		
		File[] currentsFileArray = baseFile.listFiles();
		
		for (File currentFile : currentsFileArray)
		{
			if (!currentFile.isDirectory())
			{
				if (currentFile.getAbsolutePath().endsWith(baseExtFiler))
				{
					this.foundPaths.add(currentFile.getAbsolutePath());
				}
			}
			else
			{
				find(currentFile.getAbsolutePath());
			}
		}
	}
	
	/**
	 * @return the baseExtFiler
	 */
	public String getBaseExtFiler() 
	{
		return baseExtFiler;
	}


	/**
	 * @param baseExtFiler the baseExtFiler to set
	 */
	public void setBaseExtFiler(String baseExtFiler) 
	{
		this.baseExtFiler = baseExtFiler;
	}

	/**
	 * @return the foundPaths
	 */
	public List<String> getFoundPaths() 
	{
		return foundPaths;
	}

	/**
	 * @param foundPaths the foundPaths to set
	 */
	public void setFoundPaths(List<String> foundPaths) 
	{
		this.foundPaths = foundPaths;
	}
}
