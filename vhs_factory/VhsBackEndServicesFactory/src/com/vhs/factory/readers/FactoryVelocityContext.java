package com.vhs.factory.readers;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Velocity context
 * 
 * @author Alex Vicente Chacon Jimenez (av.chacon10@uniandes.edu.co)
 *
 */
public class FactoryVelocityContext 
{
	/**
	 * Reference features path
	 */
	private final static String _REFERECE_FEATURE_PATH = "features/referenceVHSFeatures.txt";
	
	/**
	 * Reference features
	 */
	private List<String> referenceFeatures;
	
	/**
	 * Reference features
	 */
	private List<String> presentFeatures;
	
	/**
	 * Reference features not presented in the final product
	 */
	private List<String> notPresentFeatures;
	
	/**
	 * Raw present features
	 */
	private String rawPresentFeatures;

	
	
	/**
	 * Default constructor
	 * @param rawPresentFeatures  Raw present features
	 */
	public FactoryVelocityContext(String rawPresentFeatures) 
	{
		this.rawPresentFeatures = rawPresentFeatures;
		this.presentFeatures = new ArrayList<String>();
		this.referenceFeatures = new ArrayList<String>();
		this.notPresentFeatures = new ArrayList<String>();
		
		loadReferenceFeatures();
		loadPresentFeatures();
		loadNotPresentFeatures();
	}

	/**
	 * Loads not present features
	 */
	private void loadNotPresentFeatures() 
	{
		for (String currenteReferenceFeature : this.referenceFeatures)
		{
			boolean featureNotFound = true;
			
			for (String currentPresentFeature: this.presentFeatures)
			{
				if (currenteReferenceFeature.trim().contains(currentPresentFeature.trim()))
				{
					featureNotFound = false;
				}
			}
			
			if (featureNotFound)
			{
				this.notPresentFeatures.add(currenteReferenceFeature);
			}
		}
	}

	/**
	 * Loads the presented features
	 */
	private void loadPresentFeatures() 
	{
		String[] featuresArray = this.rawPresentFeatures.split(",");
		
		for (String currentFeature : featuresArray)
		{
			this.presentFeatures.add(currentFeature);
		}
	}

	/**
	 * Loads the reference features
	 */
	private void loadReferenceFeatures() 
	{
		try(BufferedReader br = new BufferedReader(new FileReader(_REFERECE_FEATURE_PATH))) 
		{
			String feature = br.readLine();
			while (feature != null) 
			{
				//
				// Adding a new feature to the product feature array
				this.referenceFeatures.add(feature);
				feature = br.readLine();
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}

	/**
	 * @return the referenceFeatures
	 */
	public List<String> getReferenceFeatures() 
	{
		return referenceFeatures;
	}

	/**
	 * @return the presentFeatures
	 */
	public List<String> getPresentFeatures() 
	{
		return presentFeatures;
	}

	/**
	 * @return the rawPresentFeatures
	 */
	public String getRawPresentFeatures() 
	{
		return rawPresentFeatures;
	}

	/**
	 * @return the notPresentFeatures
	 */
	public List<String> getNotPresentFeatures() 
	{
		return notPresentFeatures;
	}
	
	

}
