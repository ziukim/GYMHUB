package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final GymService gymService;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper,
                             BCryptPasswordEncoder bCryptPasswordEncoder,
                             GymService gymService) {
        this.memberMapper = memberMapper;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.gymService = gymService;
    }

    @Override
    public Member getMemberById(String memberId) {
        return memberMapper.getMemberById(memberId);
    }

    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    @Override
    @Transactional
    public int addMember(Member member) {
        return memberMapper.addMember(member);
    }

    @Override
    @Transactional
    public int addGymOwner(Member member, Gym gym) {
        // 1. GYM 테이블에 먼저 INSERT (GYM_NO 생성)
        int gymResult = gymService.addGym(gym);

        if (gymResult > 0) {
            // 2. 생성된 GYM_NO를 Member에 설정
            member.setGymNo(gym.getGymNo());

            // 3. MEMBER 테이블에 INSERT
            int memberResult = memberMapper.addMember(member);

            return memberResult;
        }

        return 0;
    }

    @Override
    public Member login(String memberId, String memberPwd) {
        // 로그인 전용 쿼리로 회원 정보 조회
        Member member = memberMapper.getMemberForLogin(memberId);

        // 회원이 존재하고 비밀번호가 일치하는지 확인
        if (member != null && bCryptPasswordEncoder.matches(memberPwd, member.getMemberPwd())) {
            return member;
        }

        return null;
    }

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    @Transactional
    public int updatePassword(int memberNo, String newPassword) {
        return memberMapper.updatePassword(memberNo, newPassword);
    }

    @Override
    @Transactional
    public int updateProfilePhoto(int memberNo, MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return 0;
        }

        try {
            // 로컬 개발용 경로 설정
            String uploadPath = "src/main/webapp/resources/uploadfiles/Member/";
            String webPath = "resources/uploadfiles/Member/";

            // 파일명 생성
            String originName = file.getOriginalFilename();
            String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
            int randomNumber = (int)(Math.random() * 90000) + 10000;
            String ext = originName.substring(originName.lastIndexOf("."));
            String changeName = currentTime + randomNumber + ext;

            // 디렉터리가 없으면 생성
            File directory = new File(uploadPath);
            if (!directory.exists()) {
                directory.mkdirs();
                System.out.println("디렉터리 생성: " + directory.getAbsolutePath());
            }

            // 파일 저장
            File destFile = new File(uploadPath + changeName);
            file.transferTo(destFile);

            System.out.println("=== 파일 업로드 성공 ===");
            System.out.println("저장 경로: " + destFile.getAbsolutePath());
            System.out.println("파일 존재: " + destFile.exists());
            System.out.println("파일 크기: " + destFile.length() + " bytes");

            // DB에 웹 경로 저장
            String photoPath = webPath + changeName;
            System.out.println("DB 저장 경로: " + photoPath);

            int result = memberMapper.updateProfilePhoto(memberNo, photoPath);
            System.out.println("DB 업데이트 결과: " + result);

            return result;

        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("파일 업로드 실패: " + e.getMessage());
            throw new RuntimeException("파일 업로드 실패", e);
        }
    }
}