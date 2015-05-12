/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * http://www.java2s.com/Code/Java/File-Input-Output/Copyandoverwritefiles.htm
 * 
 * @author Alex Chacon (av.chacon10@uniandes.edu.co)
 */
public final class FileUtil 
{

    public static void copyFile(String from, String to) 
    {
        copyFile(from, to, Boolean.FALSE);
    }

    public static void copyFile(String from, String to, Boolean overwrite) 
    {

        try 
        {
            File fromFile = new File(from);
            File toFile = new File(to);

            if (!fromFile.exists()) 
            {
                throw new IOException("File not found: " + from);
            }
            if (!fromFile.isFile()) 
            {
                throw new IOException("Can't copy directories: " + from);
            }
            if (!fromFile.canRead()) 
            {
                throw new IOException("Can't read file: " + from);
            }

            if (toFile.isDirectory()) 
            {
                toFile = new File(toFile, fromFile.getName());
            }

            if (toFile.exists() && !overwrite) 
            {
                throw new IOException("File already exists.");
            } 
            else 
            {
                String parent = toFile.getParent();
                if (parent == null) 
                {
                    parent = System.getProperty("user.dir");
                }
                File dir = new File(parent);
                if (!dir.exists()) 
                {
                    throw new IOException("Destination directory does not exist: " + parent);
                }
                if (dir.isFile()) 
                {
                    throw new IOException("Destination is not a valid directory: " + parent);
                }
                if (!dir.canWrite()) 
                {
                    throw new IOException("Can't write on destination: " + parent);
                }
            }

            FileInputStream fis = null;
            FileOutputStream fos = null;
            
            try 
            {

                fis = new FileInputStream(fromFile);
                fos = new FileOutputStream(toFile);
                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = fis.read(buffer)) != -1) 
                {
                    fos.write(buffer, 0, bytesRead);
                }

            } 
            finally 
            {
                if (from != null) 
                {
                    try 
                    {
                        if (fos !=null)
                            fis.close();
                    } 
                    catch (IOException e) 
                    {
                      System.out.println(e);
                    }
                }
                if (to != null) 
                {
                    try 
                    {
                        if (fos !=null)
                            fos.close();
                    } 
                    catch (IOException e) 
                    {
                        System.out.println(e);
                    }
                }
            }

        }
        catch (Exception e) 
        {
            Logger.getLogger(FileUtil.class.getName()).log(Level.WARNING, "Problems trying to copy a file", e);
        }
    }

}

