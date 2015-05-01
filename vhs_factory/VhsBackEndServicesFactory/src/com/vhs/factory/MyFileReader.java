package com.vhs.factory;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;

public class MyFileReader {
	
	// Path to the file
	private String filePath;
	
	// ArrayList of features of the product to be created
	private ArrayList<String> productFeatures;
	
	public MyFileReader(String filePath){
		this.filePath = filePath;
		this.productFeatures = new ArrayList<String>();
	}
	
	// Read the file
	public void readFile(){
		
		try(BufferedReader br = new BufferedReader(new FileReader(filePath))) {
			
			String feature = br.readLine();
			
			while (feature != null) {
				
				// Adding a new feature to the product feature array
				productFeatures.add(feature);
				feature = br.readLine();
			}
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
	
	// Print all the lines of the file
	public void printFile(){
		for (String feature : productFeatures) {
			System.out.println(feature);
		}
	}
	
	// Obtain file path
	public String getFilePath() {
		return filePath;
	}

	// Setting file path
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	// Obtain ArrayList<String> of the product features
	public ArrayList<String> getProductFeatures() {
		return productFeatures;
	}

	// Set the ArrayList of the product features
	public void setProductFeatures(ArrayList<String> productFeatures) {
		this.productFeatures = productFeatures;
	}
	
}
