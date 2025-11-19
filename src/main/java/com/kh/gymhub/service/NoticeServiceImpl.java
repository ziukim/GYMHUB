package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.NoticeMapper;
import com.kh.gymhub.model.vo.GymNotice;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class NoticeServiceImpl implements NoticeService {

    private final NoticeMapper noticeMapper;
    private final ServletContext servletContext;

    @Autowired
    public NoticeServiceImpl(NoticeMapper noticeMapper, ServletContext servletContext) {
        this.noticeMapper = noticeMapper;
        this.servletContext = servletContext;
    }

    @Override
    public List<GymNotice> getNoticesByGymNo(int gymNo) {
        return noticeMapper.selectNoticesByGymNo(gymNo);
    }

    @Override
    public List<GymNotice> getLatestNoticesByGymNo(int gymNo) {
        return noticeMapper.selectLatestNoticesByGymNo(gymNo);
    }

    @Override
    public GymNotice getNoticeByNo(int noticeNo) {
        return noticeMapper.selectNoticeByNo(noticeNo);
    }

    @Override
    @Transactional
    public int updateNotice(GymNotice notice, MultipartFile file) {
        try {
            // 파일이 있으면 저장
            if (file != null && !file.isEmpty()) {
                // 웹 경로 (브라우저에서 접근할 경로) - 소문자로 통일
                String webPath = "/resources/uploadfiles/notice/";
                // 실제 서버 파일 시스템 경로
                String serverPath = servletContext.getRealPath(webPath);
                
                // 경로가 null이면 대체 경로 사용
                if (serverPath == null) {
                    // 웹앱 루트 경로를 직접 지정
                    String rootPath = servletContext.getRealPath("/");
                    if (rootPath != null) {
                        serverPath = rootPath + "resources/uploadfiles/notice/";
                    } else {
                        throw new RuntimeException("파일 저장 경로를 찾을 수 없습니다.");
                    }
                }
                
                // 파일 저장
                String changeName = saveFile(file, serverPath);
                
                // DB에 저장할 경로 설정 (웹 경로 + 변경된 파일명)
                String filePath = webPath + changeName;
                notice.setFilePath(filePath);
                
                System.out.println("=== 공지사항 파일 업데이트 정보 ===");
                System.out.println("원본 파일명: " + file.getOriginalFilename());
                System.out.println("변경된 파일명: " + changeName);
                System.out.println("서버 저장 경로: " + serverPath);
                System.out.println("웹 접근 경로 (DB 저장값): " + filePath);
            }
            // 파일이 없으면 기존 파일 경로 유지 (notice.filePath는 그대로)

            // 공지사항 수정
            int result = noticeMapper.updateNotice(notice);
            
            if (result > 0) {
                System.out.println("공지사항 수정 성공 - 공지사항 번호: " + notice.getNoticeNo());
                return result;
            } else {
                throw new RuntimeException("공지사항 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("공지사항 수정에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int updateNoticeFixStatus(int noticeNo, String fixStatus) {
        return noticeMapper.updateNoticeFixStatus(noticeNo, fixStatus);
    }

    @Override
    @Transactional
    public int deleteNotice(int noticeNo) {
        try {
            // 공지사항 정보 조회 (파일 경로 확인용)
            GymNotice notice = noticeMapper.selectNoticeByNo(noticeNo);
            
            if (notice == null) {
                throw new RuntimeException("공지사항을 찾을 수 없습니다.");
            }
            
            // 파일이 있으면 파일 삭제
            if (notice.getFilePath() != null && !notice.getFilePath().isEmpty()) {
                try {
                    String webPath = "/resources/uploadfiles/notice/";
                    String serverPath = servletContext.getRealPath(webPath);
                    
                    if (serverPath == null) {
                        String rootPath = servletContext.getRealPath("/");
                        if (rootPath != null) {
                            serverPath = rootPath + "resources/uploadfiles/notice/";
                        }
                    }
                    
                    if (serverPath != null) {
                        // 파일 경로에서 파일명 추출
                        String fileName = notice.getFilePath().substring(notice.getFilePath().lastIndexOf("/") + 1);
                        File file = new File(serverPath, fileName);
                        
                        if (file.exists()) {
                            boolean deleted = file.delete();
                            if (deleted) {
                                System.out.println("공지사항 첨부파일 삭제 완료: " + file.getAbsolutePath());
                            } else {
                                System.out.println("공지사항 첨부파일 삭제 실패: " + file.getAbsolutePath());
                            }
                        }
                    }
                } catch (Exception e) {
                    // 파일 삭제 실패해도 DB 삭제는 진행
                    System.out.println("파일 삭제 중 오류 발생 (무시하고 계속 진행): " + e.getMessage());
                }
            }
            
            // DB에서 공지사항 삭제
            int result = noticeMapper.deleteNotice(noticeNo);
            
            if (result > 0) {
                System.out.println("공지사항 삭제 성공 - 공지사항 번호: " + noticeNo);
                return result;
            } else {
                throw new RuntimeException("공지사항 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("공지사항 삭제에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int insertNotice(GymNotice notice, MultipartFile file) {
        try {
            // 파일이 있으면 저장
            if (file != null && !file.isEmpty()) {
                // 웹 경로 (브라우저에서 접근할 경로) - 소문자로 통일
                String webPath = "/resources/uploadfiles/notice/";
                // 실제 서버 파일 시스템 경로
                String serverPath = servletContext.getRealPath(webPath);
                
                // 경로가 null이면 대체 경로 사용
                if (serverPath == null) {
                    // 웹앱 루트 경로를 직접 지정
                    String rootPath = servletContext.getRealPath("/");
                    if (rootPath != null) {
                        serverPath = rootPath + "resources/uploadfiles/notice/";
                    } else {
                        throw new RuntimeException("파일 저장 경로를 찾을 수 없습니다.");
                    }
                }
                
                // 파일 저장
                String changeName = saveFile(file, serverPath);
                
                // DB에 저장할 경로 설정 (웹 경로 + 변경된 파일명)
                // NOTICE_FILE_PATH 컬럼에 저장될 값: /resources/uploadfiles/notice/20251111190838_6e7f9.jpg
                String filePath = webPath + changeName;
                notice.setFilePath(filePath);
                
                System.out.println("=== 공지사항 파일 업로드 정보 ===");
                System.out.println("원본 파일명: " + file.getOriginalFilename());
                System.out.println("변경된 파일명: " + changeName);
                System.out.println("서버 저장 경로: " + serverPath);
                System.out.println("웹 접근 경로 (DB 저장값): " + filePath);
                System.out.println("파일 크기: " + file.getSize() + " bytes");
            } else {
                // 파일이 없으면 null로 설정
                notice.setFilePath(null);
                System.out.println("첨부파일 없음 - NOTICE_FILE_PATH는 NULL로 저장됩니다.");
            }

            // 공지사항 등록
            int result = noticeMapper.insertNotice(notice);
            
            if (result > 0) {
                System.out.println("공지사항 등록 성공 - 공지사항 번호: " + notice.getNoticeNo());
                if (notice.getFilePath() != null) {
                    System.out.println("첨부파일 경로 DB 저장 완료: " + notice.getFilePath());
                }
                return result;
            } else {
                throw new RuntimeException("공지사항 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("공지사항 등록에 실패했습니다: " + e.getMessage(), e);
        }
    }

    private String saveFile(MultipartFile file, String savePath) {
        // 파일명 생성: 현재시간 + UUID + 원본파일확장자
        String originName = file.getOriginalFilename();
        
        // 파일명이 없거나 확장자가 없는 경우 처리
        if (originName == null || originName.isEmpty()) {
            originName = "image.jpg";
        }
        
        String ext = "";
        int lastDotIndex = originName.lastIndexOf(".");
        if (lastDotIndex > 0 && lastDotIndex < originName.length() - 1) {
            ext = originName.substring(lastDotIndex);
        } else {
            ext = ".jpg"; // 기본 확장자
        }

        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String uuid = UUID.randomUUID().toString().substring(0, 5);
        String changeName = currentTime + "_" + uuid + ext;

        try {
            // 저장 경로 디렉토리 생성
            File dir = new File(savePath);
            if (!dir.exists()) {
                boolean created = dir.mkdirs();
                if (!created) {
                    throw new RuntimeException("디렉토리 생성에 실패했습니다: " + savePath);
                }
                System.out.println("디렉토리 생성 완료: " + savePath);
            }

            // 파일 저장
            File saveFile = new File(savePath, changeName);
            file.transferTo(saveFile);
            
            System.out.println("파일 저장 완료: " + saveFile.getAbsolutePath());
            System.out.println("파일 크기: " + file.getSize() + " bytes");

        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("파일 저장에 실패했습니다: " + e.getMessage(), e);
        }

        return changeName;
    }

    @Override
    public List<GymNotice> getNoticesByGymNoPaged(int gymNo, int startRow, int endRow) {
        if (gymNo <= 0) {
            return new java.util.ArrayList<>();
        }
        return noticeMapper.selectNoticesByGymNoPaged(gymNo, startRow, endRow);
    }

    @Override
    public Integer getNoticeCountByGymNo(int gymNo) {
        if (gymNo <= 0) {
            return 0;
        }
        return noticeMapper.selectNoticeCountByGymNo(gymNo);
    }
}

