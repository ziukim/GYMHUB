package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.mapper.MembershipMapper;
import com.kh.gymhub.model.mapper.PtReserveMapper;
import com.kh.gymhub.model.mapper.LockerMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final GymService gymService;
    private final MembershipMapper membershipMapper;
    private final PtReserveMapper ptReserveMapper;
    private final LockerMapper lockerMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper,
                             BCryptPasswordEncoder bCryptPasswordEncoder,
                             GymService gymService,
                             MembershipMapper membershipMapper,
                             PtReserveMapper ptReserveMapper,
                             LockerMapper lockerMapper) {
        this.memberMapper = memberMapper;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.gymService = gymService;
        this.membershipMapper = membershipMapper;
        this.ptReserveMapper = ptReserveMapper;
        this.lockerMapper = lockerMapper;
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
    public int updateProfileImage(int memberNo, String photoPath) {
        return memberMapper.updateProfileImage(memberNo, photoPath);
    }

    @Override
    public Member getMemberByIdForGymRegistration(String memberId) {
        return memberMapper.getMemberByIdForGymRegistration(memberId);
    }

    @Override
    @Transactional
    public int withdrawMember(int memberNo, String password) {
        // 회원 정보 조회
        Member member = memberMapper.getMemberByNo(memberNo);
        
        if (member == null) {
            return 0; // 회원이 존재하지 않음
        }
        
        // 비밀번호 확인
        if (!bCryptPasswordEncoder.matches(password, member.getMemberPwd())) {
            return -1; // 비밀번호 불일치
        }
        
        // 연관 데이터 처리
        try {
            // 1. 회원권 중단 처리 (일반 회원인 경우)
            if (member.getMemberType() == 1) {
                membershipMapper.suspendAllMembershipsByMemberNo(memberNo);
            }
            
            // 2. 예정된 PT 예약 취소 처리
            ptReserveMapper.cancelPtReservesByMemberNo(memberNo);
            
            // 3. 락커 이용권 만료 처리 (일반 회원인 경우)
            if (member.getMemberType() == 1) {
                lockerMapper.expireLockerPassesByMemberNo(memberNo);
            }
            
            // 4. 트레이너인 경우 헬스장 연결 해제 (GYM_NO를 NULL로 변경)
            if (member.getMemberType() == 2) {
                memberMapper.updateMemberGymNo(memberNo, null);
            }
            
            // 5. 회원 탈퇴 처리 (STATUS를 'N'으로 변경)
            return memberMapper.withdrawMember(memberNo);
        } catch (Exception e) {
            // 트랜잭션 롤백을 위해 예외를 다시 던짐
            throw new RuntimeException("회원 탈퇴 처리 중 오류가 발생했습니다.", e);
        }
    }
}