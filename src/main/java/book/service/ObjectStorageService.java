package book.service;

import org.springframework.web.multipart.MultipartFile;

public interface ObjectStorageService {

	String uploadFile(String bucketName, String string, MultipartFile img);

	void deleteFile(String bucketName, String string, String imageFileName);

	boolean doesFileExist(String bucketName, String string, String newImageFileName);

}
