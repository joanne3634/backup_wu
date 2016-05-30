package com.deelon.crowdfunding.controller.front;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiException;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ValidCode extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  private static String SessionName_Randcode = "randcode";

  public static long getSerialversionuid()
  {
    return 1L;
  }

  public static String getSessionName_Randcode()
  {
    return SessionName_Randcode;
  }

  public static void setSessionName_Randcode(String paramString)
  {
    SessionName_Randcode = paramString;
  }

  public void destroy()
  {
    super.destroy();
  }

  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    paramHttpServletResponse.setHeader("Pragma", "No-cache");
    paramHttpServletResponse.setHeader("Cache-Control", "no-cache");
    paramHttpServletResponse.setDateHeader("Expires", 0L);
    paramHttpServletResponse.setContentType("image/jpeg");
    int imageWidth = 60;
    int imageHeight = 20;
    BufferedImage localBufferedImage = new BufferedImage(imageWidth, imageHeight, 1);
    Graphics localGraphics = localBufferedImage.getGraphics();
    Random localRandom = new Random();
    localGraphics.setColor(getRandColor(155, 254));
    localGraphics.fillRect(0, 0, imageWidth, imageHeight);
    localGraphics.setFont(new Font("Times New Roman", 0, 18));
    localGraphics.setColor(getRandColor(160, 220));
    for (int k = 0; k < 155; k++)
    {
      int m = localRandom.nextInt(imageWidth);
      int n = localRandom.nextInt(imageHeight);
      int i1 = localRandom.nextInt(12);
      int i2 = localRandom.nextInt(12);
      localGraphics.drawLine(m, n, m + i1, n + i2);
    	 
    }
    String str1 = "";
    for (int k = 0; k < 4; k++)
    {
      //String str2 = String.valueOf(localRandom.nextInt(10));//0-9的数字
      char[] numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz" +
              "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
      String str2 = numbersAndLetters[localRandom.nextInt(71)] + "";
      str1 += str2;
      localGraphics.setColor(new Color(20 + localRandom.nextInt(110), 20 + localRandom.nextInt(110), 20 + localRandom.nextInt(110)));
      localGraphics.drawString(str2, 13 * k + 6, 16);
      //画几条干扰线
      if(k % 2 == 0){
    	  localGraphics.drawLine(localRandom.nextInt(10), localRandom.nextInt(imageHeight), localRandom.nextInt(imageWidth), localRandom.nextInt(imageHeight));
      }
    }
    localGraphics.drawOval(localRandom.nextInt(imageWidth), localRandom.nextInt(imageHeight), 50, 5);
    paramHttpServletRequest.getSession().setAttribute(SessionName_Randcode, str1);
    localGraphics.dispose();
    ServletOutputStream localServletOutputStream = paramHttpServletResponse.getOutputStream();
    try
    {
      Jimi.putImage("image/jpeg", localBufferedImage, localServletOutputStream);
    }
    catch (JimiException localJimiException)
    {
      localJimiException.printStackTrace();
    }
    localServletOutputStream.flush();
    localServletOutputStream.close();
    localServletOutputStream = null;
    paramHttpServletResponse.flushBuffer();
  }

  private Color getRandColor(int paramInt1, int paramInt2)
  {
    Random localRandom = new Random();
    if (paramInt1 > 255)
      paramInt1 = 255;
    if (paramInt2 > 255)
      paramInt2 = 255;
    int i = paramInt1 + localRandom.nextInt(paramInt2 - paramInt1);
    int j = paramInt1 + localRandom.nextInt(paramInt2 - paramInt1);
    int k = paramInt1 + localRandom.nextInt(paramInt2 - paramInt1);
    return new Color(i, j, k);
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
  }

  public void init()
    throws ServletException
  {
  }
}