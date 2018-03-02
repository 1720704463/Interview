package com.interview.util;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

/**
 * DES 对称加密算法
 * <p>
 * =================================================================================================================
 * 对称加密算法就是能将数据加解密。加密的时候使用密钥对数据进行加密，解密的时候使用同样的密钥对数据进行解密
 * DES 是美国国家标准研究所提出的算法。由于加解密的数据安全性和密钥长度成正比，故 DES 的 56 位密钥已经形成安全隐患
 * 后来针对 DES 算法进行了改进，有了三重 DES 算法（也称 DESede 或 Triple-DES）。全名是 TDEA:Triple Data Encryption Algorithm
 * DESede 针对 DES 算法的密钥长度较短以及迭代次数偏少问题做了相应改进，提高了安全强度
 * 不过 DESede 算法处理速度较慢，密钥计算时间较长，加密效率不高等问题使得对称加密算法的发展不容乐观
 * =================================================================================================================
 * Java 和 BouncyCastle 针对 DES 算法的数据加密支持是不同的，主要体现在密钥长度,工作模式以及填充方式上
 * Java6 只支持 56 位密钥，而 BouncyCastle 支持 64 位密钥，它的官网是 http://www.bouncycastle.org/
 * 即便是在 DESede 算法上，BouncyCastle 的密钥长度也要比 Java 的密钥长度长
 * =================================================================================================================
 * 另外，Java 的 API 中仅仅提供了 DES,DESede,PBE 三种对称加密算法密钥材料实现类
 * =================================================================================================================
 * 关于 Java 加解密的更多算法实现，可以参考此爷的博客 http://blog.csdn.net/kongqz/article/category/800296
 * =================================================================================================================
 *
 * @author rxliuli
 */
public class DesCodec {
  /**
   * 算法名称
   */
  private static final String KEY_ALGORITHM = "DES";
  /**
   * 算法名称 / 加密模式 / 填充方式
   * DES 共有四种工作模式:
   * ECB:电子密码本模式,CBC:加密分组链接模式,CFB:加密反馈模式,OFB:输出反馈模式
   */
  private static final String CIPHER_ALGORITHM = "DES/ECB/PKCS5Padding";

  /**
   * 生成密钥
   */
  public static String initKey() throws NoSuchAlgorithmException {
    //实例化密钥生成器
    KeyGenerator kg = KeyGenerator.getInstance(KEY_ALGORITHM);
    //初始化密钥生成器
    kg.init(56);
    //生成密钥
    SecretKey secretKey = kg.generateKey();
    //获取二进制密钥编码形式
    return Base64.encodeBase64String(secretKey.getEncoded());
  }

  /**
   * 转换密钥
   */
  private static Key toKey(byte[] key) throws Exception {
    //实例化 Des 密钥
    DESKeySpec dks = new DESKeySpec(key);
    //实例化密钥工厂
    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(KEY_ALGORITHM);
    //生成密钥
    return keyFactory.generateSecret(dks);
  }

  /**
   * 加密数据
   *
   * @param data 待加密数据
   * @param key  密钥
   * @return 加密后的数据
   */
  public static String encrypt(String data, String key) throws Exception {
    //还原密钥
    Key k = toKey(Base64.decodeBase64(key));
    //实例化 Cipher 对象，它用于完成实际的加密操作
    Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
    //初始化 Cipher 对象，设置为加密模式
    cipher.init(Cipher.ENCRYPT_MODE, k);
    //执行加密操作。加密后的结果通常都会用 Base64 编码进行传输
    return Base64.encodeBase64String(cipher.doFinal(data.getBytes()));
  }

  /**
   * 解密数据
   *
   * @param data 待解密数据
   * @param key  密钥
   * @return 解密后的数据
   */
  public static String decrypt(String data, String key) throws Exception {
    Key k = toKey(Base64.decodeBase64(key));
    Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
    //初始化 Cipher 对象，设置为解密模式
    cipher.init(Cipher.DECRYPT_MODE, k);
    //执行解密操作
    return new String(cipher.doFinal(Base64.decodeBase64(data)));
  }
}