package com.jian.sys.utils;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class ChineseToPinYinUtils {
    /**
     * 将字符串中的中文转化为拼音,其他字符不变
     * @param inputString
     * @return 汉语拼音
     */
    public static String getPingYin(String inputString) {

        //创建转换对象
        HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
        //转换类型（大写or小写）
        format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        //定义中文声调的输出格式
        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        //定义字符的输出格式
        format.setVCharType(HanyuPinyinVCharType.WITH_U_AND_COLON);

        //转换为字节数组
        char[] input = inputString.trim().toCharArray();
        // 用StringBuffer（字符串缓冲）来接收处理的数据
        StringBuffer output = new StringBuffer();

        try {
            for (int i = 0; i < input.length; i++) {
                //判断是否是一个汉子字符
                if (Character.toString(input[i]).matches("[\\u4E00-\\u9FA5]+")) {
                    String[] temp = PinyinHelper.toHanyuPinyinStringArray(input[i], format);
                    output.append(temp[0]);
                } else {
                    // 如果不是汉字字符，直接拼接
                    output.append(Character.toString(input[i]));
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            e.printStackTrace();
        }
        return output.toString();
    }
}
