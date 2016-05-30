package com.deelon.crowdfunding.common.util;

import com.deelon.core.encrypt.Base64;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.google.common.collect.Sets;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Created by jiang on 15/6/18.
 */
public class FileUtil {


    private static Log logger = LogFactory.getLog(FileUtil.class);

    public FileUtil() {
    }

    /**
     * 检查上传文件尺寸是否超过某限定值
     *
     * @param f              上传文件
     * @param sizeLimitation 尺寸限制
     * @return 返回布尔值
     */
    public static boolean isExceedSizeLimitation(MultipartFile f, Long sizeLimitation) {
        if (null == f || null == sizeLimitation) {
            throw new CrowdFundException("参数不可为空");
        } else {
            long size = f.getSize();
            return size > sizeLimitation;
        }
    }

    /**
     * 检查文件类型是否包含在给定的类型中
     *
     * @param f
     * @param fileTypes 给定的文件类型
     * @return 返回布尔值 true:包含
     */
    public static boolean isFileTypeMatched(MultipartFile f, String[] fileTypes) {
        if (null == f || null == fileTypes) {
            throw new CrowdFundException("参数不可为空");
        } else {
            Set<String> types = Sets.newHashSet(fileTypes);
            return (types.contains(getFileExt(f.getOriginalFilename().toLowerCase())));
        }
    }

    public static void writeFile(String var0, String var1) {
        writeFile(var0, var1, "utf-8");
    }

    public static void writeFile(String var0, String var1, String var2) {
        try {
            createFolder(var0, true);
            BufferedWriter var3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(var0), var2));
            var3.write(var1);
            var3.close();
        } catch (IOException var4) {
            var4.printStackTrace();
        }

    }

    public static void writeFile(String var0, InputStream var1) throws IOException {
        FileOutputStream var2 = new FileOutputStream(var0);
        byte[] var3 = new byte[512];
        boolean var4 = false;

        int var5;
        while ((var5 = var1.read(var3)) != -1) {
            var2.write(var3, 0, var5);
        }

        var1.close();
        var2.close();
    }

    public static String readFile(String var0) throws IOException {
        try {
            File var1 = new File(var0);
            String var2 = getCharset(var1);
            StringBuffer var3 = new StringBuffer();
            BufferedReader var4 = new BufferedReader(new InputStreamReader(new FileInputStream(var0), var2));

            String var5;
            while ((var5 = var4.readLine()) != null) {
                var3.append(var5 + "\r\n");
            }

            var4.close();
            return var3.toString();
        } catch (IOException var6) {
            throw var6;
        }
    }

    public static boolean isExistFile(String var0) {
        boolean var1 = false;
        File var2 = new File(var0);
        if (var2.isDirectory()) {
            File[] var3 = var2.listFiles();
            if (var3 != null && var3.length != 0) {
                var1 = true;
            }
        }

        return var1;
    }

    public static String getCharset(File var0) {
        String var1 = "GBK";
        byte[] var2 = new byte[3];

        try {
            boolean var3 = false;
            BufferedInputStream var4 = new BufferedInputStream(new FileInputStream(var0));
            var4.mark(0);
            int var5 = var4.read(var2, 0, 3);
            if (var5 == -1) {
                return var1;
            }

            if (var2[0] == -1 && var2[1] == -2) {
                var1 = "UTF-16LE";
                var3 = true;
            } else if (var2[0] == -2 && var2[1] == -1) {
                var1 = "UTF-16BE";
                var3 = true;
            } else if (var2[0] == -17 && var2[1] == -69 && var2[2] == -65) {
                var1 = "UTF-8";
                var3 = true;
            }

            var4.reset();
            if (!var3) {
                int var6 = 0;

                label77:
                do {
                    while (true) {
                        do {
                            do {
                                if ((var5 = var4.read()) == -1) {
                                    break label77;
                                }

                                ++var6;
                            } while (var5 >= 240);
                        } while (128 <= var5 && var5 <= 191);

                        if (192 <= var5 && var5 <= 223) {
                            var5 = var4.read();
                            break;
                        }

                        if (224 <= var5 && var5 <= 239) {
                            var5 = var4.read();
                            if (128 <= var5 && var5 <= 191) {
                                var5 = var4.read();
                                if (128 <= var5 && var5 <= 191) {
                                    var1 = "UTF-8";
                                }
                            }
                        }
                    }
                } while (128 <= var5 && var5 <= 191);
            }

            var4.close();
        } catch (Exception var7) {
            var7.printStackTrace();
        }

        return var1;
    }

    public static byte[] readByte(InputStream var0) {
        try {
            byte[] var1 = new byte[var0.available()];
            var0.read(var1);
            return var1;
        } catch (FileNotFoundException var2) {
            logger.error("文件路径不存在：" + var2.getMessage());
        } catch (Exception var3) {
            var3.printStackTrace();
        }

        return null;
    }

    public static byte[] readByte(String var0) {
        try {
            FileInputStream var1 = new FileInputStream(var0);
            byte[] var2 = new byte[var1.available()];
            var1.read(var2);
            var1.close();
            return var2;
        } catch (FileNotFoundException var3) {
            logger.error("文件路径不存在：" + var0);
        } catch (Exception var4) {
            var4.printStackTrace();
        }

        return null;
    }

    public static boolean writeByte(String var0, byte[] var1) {
        try {
            BufferedOutputStream var2 = new BufferedOutputStream(new FileOutputStream(var0));
            var2.write(var1);
            var2.close();
            return true;
        } catch (Exception var3) {
            var3.printStackTrace();
            return false;
        }
    }

    public static boolean deleteDir(File var0) {
        if (var0.isDirectory()) {
            String[] var1 = var0.list();

            for (int var2 = 0; var2 < var1.length; ++var2) {
                boolean var3 = deleteDir(new File(var0, var1[var2]));
                if (!var3) {
                    return false;
                }
            }
        }

        return var0.delete();
    }

    public static void serializeToFile(Object var0, String var1) {
        try {
            ObjectOutputStream var2 = new ObjectOutputStream(new FileOutputStream(var1));
            var2.writeObject(var0);
            var2.close();
        } catch (IOException var3) {
            var3.printStackTrace();
        }

    }

    public static Object deserializeFromFile(String var0) {
        try {
            File var1 = new File(var0);
            ObjectInputStream var2 = new ObjectInputStream(new FileInputStream(var1));
            Object var3 = var2.readObject();
            var2.close();
            return var3;
        } catch (Exception var4) {
            var4.printStackTrace();
            return null;
        }
    }

    public static String inputStream2String(InputStream var0, String var1) throws IOException {
        BufferedReader var2 = new BufferedReader(new InputStreamReader(var0, var1));
        StringBuffer var3 = new StringBuffer();
        String var4 = "";

        while ((var4 = var2.readLine()) != null) {
            var3.append(var4 + "\n");
        }

        return var3.toString();
    }

    public static String inputStream2String(InputStream var0) throws IOException {
        return inputStream2String(var0, "utf-8");
    }

    public static File[] getFiles(String var0) {
        File var1 = new File(var0);
        return var1.listFiles();
    }

    public static void createFolderFile(String var0) {
        createFolder(var0, true);
    }

    public static void createFolder(String var0, boolean var1) {
        if (var1) {
            var0 = var0.substring(0, var0.lastIndexOf(File.separator));
        }

        File var2 = new File(var0);
        if (!var2.exists()) {
            var2.mkdirs();
        }

    }

    public static void createFolder(String var0, String var1) {
        var0 = StringUtil.trimSufffix(var0, File.separator) + File.separator + var1;
        File var2 = new File(var0);
        var2.mkdir();
    }

    public static void renameFolder(String var0, String var1) {
        File var2 = new File(var0);
        if (var2.exists()) {
            var2.renameTo(new File(var1));
        }

    }

    public static ArrayList<File> getDiretoryOnly(File var0) {
        ArrayList var1 = new ArrayList();
        if (var0 != null && var0.exists() && var0.isDirectory()) {
            File[] var2 = var0.listFiles(new FileFilter() {
                public boolean accept(File var1) {
                    return var1.isDirectory();
                }
            });

            for (int var3 = 0; var3 < var2.length; ++var3) {
                var1.add(var2[var3]);
            }
        }

        return var1;
    }

    public ArrayList<File> getFileOnly(File var1) {
        ArrayList var2 = new ArrayList();
        File[] var3 = var1.listFiles(new FileFilter() {
            public boolean accept(File var1) {
                return var1.isFile();
            }
        });

        for (int var4 = 0; var4 < var3.length; ++var4) {
            var2.add(var3[var4]);
        }

        return var2;
    }

    public static boolean deleteFile(String var0) {
        File var1 = new File(var0);
        return var1.delete();
    }

    public static boolean copyFile(String var0, String var1) {
        File var2 = new File(var0);
        File var3 = new File(var1);
        FileInputStream var4 = null;
        FileOutputStream var5 = null;

        try {
            var4 = new FileInputStream(var2);
            var5 = new FileOutputStream(var3);
            byte[] var6 = new byte[4096];

            int var7;
            while ((var7 = var4.read(var6)) != -1) {
                var5.write(var6, 0, var7);
            }

            var5.flush();
            var5.close();
            var4.close();
            return true;
        } catch (IOException var8) {
            var8.printStackTrace();
            return false;
        }
    }

    public static void backupFile(String var0) {
        String var1 = var0 + ".bak";
        File var2 = new File(var1);
        if (var2.exists()) {
            var2.delete();
        }

        copyFile(var0, var1);
    }

    public static String getFileExt(File var0) {
        return var0.isFile() ? getFileExt(var0.getName()) : "";
    }

    public static String getFileExt(String var0) {
        int var1 = var0.lastIndexOf(".");
        return var1 > -1 ? var0.substring(var1 + 1).toLowerCase() : "";
    }

    public static void copyDir(String var0, String var1) throws IOException {
        (new File(var1)).mkdirs();
        File[] var2 = (new File(var0)).listFiles();

        for (int var3 = 0; var3 < var2.length; ++var3) {
            if (var2[var3].isFile()) {
                String var4 = var2[var3].getAbsolutePath();
                String var5 = var1 + "/" + var2[var3].getName();
                copyFile(var4, var5);
            }

            if (var2[var3].isDirectory()) {
                copyDirectiory(var0 + "/" + var2[var3].getName(), var1 + "/" + var2[var3].getName());
            }
        }

    }

    private static void copyDirectiory(String var0, String var1) throws IOException {
        (new File(var1)).mkdirs();
        File[] var2 = (new File(var0)).listFiles();

        for (int var3 = 0; var3 < var2.length; ++var3) {
            if (var2[var3].isFile()) {
                String var4 = var2[var3].getAbsolutePath();
                String var5 = var1 + "/" + var2[var3].getName();
                copyFile(var4, var5);
            }

            if (var2[var3].isDirectory()) {
                copyDirectiory(var0 + "/" + var2[var3].getName(), var1 + "/" + var2[var3].getName());
            }
        }

    }

    public static String getFileSize(File var0) throws IOException {
        if (var0.isFile()) {
            FileInputStream var1 = new FileInputStream(var0);
            int var2 = var1.available();
            var1.close();
            return getSize((double) var2);
        } else {
            return "";
        }
    }

    public static String getSize(double var0) {
        DecimalFormat var2 = new DecimalFormat("0.00");
        double var3;
        if (var0 > 1048576.0D) {
            var3 = var0 / 1048576.0D;
            return var2.format(var3) + " M";
        } else if (var0 > 1024.0D) {
            var3 = var0 / 1024.0D;
            return var2.format(var3) + " KB";
        } else {
            return var0 + " bytes";
        }
    }

    public static void downLoadFile(HttpServletRequest var0, HttpServletResponse var1, String var2, String var3) throws IOException {
        ServletOutputStream var4 = var1.getOutputStream();
        File var5 = new File(var2);
        if (var5.exists()) {
            var1.setContentType("APPLICATION/OCTET-STREAM");
            String var7 = var0.getHeader("USER-AGENT");
            String var8;
            if (var7 != null && var7.indexOf("MSIE") == -1) {
                var8 = "=?UTF-8?B?" + new String(Base64.getBase64(var3)) + "?=";
                var1.setHeader("Content-Disposition", "attachment; filename=" + var8);
            } else {
                String var6 = URLEncoder.encode(var3, "utf-8");
                var1.addHeader("Content-Disposition", "attachment;filename=" + var6);
            }

            FileInputStream var17 = null;

            try {
                var4 = var1.getOutputStream();
                var17 = new FileInputStream(var2);
                byte[] var9 = new byte[1024];
                boolean var10 = false;

                int var16;
                while ((var16 = var17.read(var9)) > 0) {
                    var4.write(var9, 0, var16);
                }

                var4.flush();
            } catch (Exception var14) {
                var14.printStackTrace();
            } finally {
                if (var17 != null) {
                    var17.close();
                    var8 = null;
                }

                if (var4 != null) {
                    var4.close();
                    var4 = null;
                    var1.flushBuffer();
                }

            }
        } else {
            var4.write("文件不存在!".getBytes("utf-8"));
        }

    }

    public static String getParentDir(String var0, String var1) {
        File var2 = new File(var1);
        String var3 = var2.getParent();
        String var4 = var3.replace(var0, "");
        return var4.replace(File.separator, "/");
    }

    public static String getClassesPath() {
        String var0 = StringUtil.trimSufffix(AppUtil.getRealPath("/"), File.separator) + "\\WEB-INF\\classes\\".replace("\\", File.separator);
        return var0;
    }

    public static String getRootPath() {
        String var0 = StringUtil.trimSufffix(AppUtil.getRealPath("/"), File.separator) + File.separator;
        return var0;
    }

    public static String readFromProperties(String var0, String var1) {
        String var2 = "";
        BufferedInputStream var3 = null;

        try {
            var3 = new BufferedInputStream(new FileInputStream(var0));
            Properties var4 = new Properties();
            var4.load(var3);
            var2 = var4.getProperty(var1);
            String var5 = var2;
            return var5;
        } catch (Exception var15) {
            var15.printStackTrace();
        } finally {
            if (var3 != null) {
                try {
                    var3.close();
                } catch (IOException var14) {
                    var14.printStackTrace();
                }
            }

        }

        return var2;
    }

    public static boolean saveProperties(String var0, String var1, String var2) {
        StringBuffer var3 = new StringBuffer();
        boolean var4 = false;
        BufferedReader var5 = null;

        boolean var8;
        try {
            var5 = new BufferedReader(new InputStreamReader(new FileInputStream(var0), "utf-8"));

            String var6;
            while ((var6 = var5.readLine()) != null) {
                if (var6.startsWith(var1)) {
                    var3.append(var1 + "=" + var2 + "\r\n");
                    var4 = true;
                } else {
                    var3.append(var6 + "\r\n");
                }
            }

            if (!var4) {
                var3.append(var1 + "=" + var2 + "\r\n");
            }

            writeFile(var0, var3.toString(), "utf-8");
            boolean var7 = true;
            return var7;
        } catch (Exception var18) {
            var18.printStackTrace();
            var8 = false;
        } finally {
            if (var5 != null) {
                try {
                    var5.close();
                } catch (IOException var17) {
                    var17.printStackTrace();
                }
            }

        }

        return var8;
    }

    public static boolean delProperties(String var0, String var1) {
        StringBuffer var2 = new StringBuffer();
        BufferedReader var3 = null;

        boolean var6;
        try {
            var3 = new BufferedReader(new InputStreamReader(new FileInputStream(var0), "utf-8"));

            String var4;
            while ((var4 = var3.readLine()) != null) {
                if (!var4.startsWith(var1)) {
                    var2.append(var4 + "\r\n");
                }
            }

            writeFile(var0, var2.toString(), "utf-8");
            boolean var5 = true;
            return var5;
        } catch (Exception var16) {
            var16.printStackTrace();
            var6 = false;
        } finally {
            if (var3 != null) {
                try {
                    var3.close();
                } catch (IOException var15) {
                    var15.printStackTrace();
                }
            }

        }

        return var6;
    }

    public static List<Class<?>> getAllClassesByInterface(Class<?> var0, boolean var1) throws IOException, ClassNotFoundException, IllegalStateException {
        if (!var0.isInterface()) {
            throw new IllegalStateException("Class not a interface.");
        } else {
            ClassLoader var2 = var0.getClassLoader();
            String var3 = var1 ? var0.getPackage().getName() : "/";
            return findClasses(var0, var2, var3);
        }
    }

    private static List<Class<?>> findClasses(Class<?> var0, ClassLoader var1, String var2) throws IOException, ClassNotFoundException {
        ArrayList var3 = new ArrayList();
        String var4 = var2.replace(".", "/");
        if (!var4.equals("/")) {
            Enumeration var5 = var1.getResources(var4);

            while (var5.hasMoreElements()) {
                URL var6 = (URL) var5.nextElement();
                var3.addAll(findResources(var0, new File(var6.getFile()), var2));
            }
        } else {
            String var7 = var1.getResource("").getPath();
            var3.addAll(findResources(var0, new File(var7), var2));
        }

        return var3;
    }

    private static List<Class<?>> findResources(Class<?> var0, File var1, String var2) throws ClassNotFoundException {
        ArrayList var3 = new ArrayList();
        if (!var1.exists()) {
            return Collections.EMPTY_LIST;
        } else {
            File[] var4 = var1.listFiles();
            File[] var5 = var4;
            int var6 = var4.length;

            for (int var7 = 0; var7 < var6; ++var7) {
                File var8 = var5[var7];
                if (var8.isDirectory()) {
                    if (!var8.getName().contains(".")) {
                        if (!var2.equals("/")) {
                            var3.addAll(findResources(var0, var8, var2 + "." + var8.getName()));
                        } else {
                            var3.addAll(findResources(var0, var8, var8.getName()));
                        }
                    }
                } else if (var8.getName().endsWith(".class")) {
                    Class var9 = null;
                    if (!var2.equals("/")) {
                        var9 = Class.forName(var2 + "." + var8.getName().substring(0, var8.getName().length() - 6));
                    } else {
                        var9 = Class.forName(var8.getName().substring(0, var8.getName().length() - 6));
                    }

                    if (var0.isAssignableFrom(var9) && !var0.equals(var9)) {
                        var3.add(var9);
                    }
                }
            }

            return var3;
        }
    }

    public static Object cloneObject(Object var0) throws Exception {
        ByteArrayOutputStream var1 = new ByteArrayOutputStream();
        ObjectOutputStream var2 = new ObjectOutputStream(var1);
        var2.writeObject(var0);
        ByteArrayInputStream var3 = new ByteArrayInputStream(var1.toByteArray());
        ObjectInputStream var4 = new ObjectInputStream(var3);
        return var4.readObject();
    }

    public static boolean isFileType(String var0, String var1) {
        boolean var2 = false;
        if ("IMAGE".equals(var1) && (var0.toUpperCase().equals("JPG") || var0.toUpperCase().equals("PNG") || var0.toUpperCase().equals("GIF") || var0.toUpperCase().equals("JPEG"))) {
            var2 = true;
        }

        return var2;
    }

    public static boolean isFileType(String var0, String[] var1) {
        boolean var2 = false;
        if (var1 != null && var1.length > 0) {
            for (int var3 = 0; var3 < var1.length; ++var3) {
                if (var0.toUpperCase().equals(var1[var3].toUpperCase())) {
                    return true;
                }
            }
        }

        return var2;
    }
}
