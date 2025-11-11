package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberMapper = memberMapper;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
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
    public Member login(String memberId, String memberPwd) {
        // 로그인 전용 쿼리로 회원 정보 조회
        Member member = memberMapper.getMemberForLogin(memberId);
        
        // 회원이 존재하고 비밀번호가 일치하는지 확인
        // TODO: 더미 데이터 테스트용 - BCrypt 검증 주석처리 (평문 비교로 변경)
        // 원래 코드: if (member != null && bCryptPasswordEncoder.matches(memberPwd, member.getMemberPwd())) {
        if (member != null && memberPwd.equals(member.getMemberPwd())) {
            return member;
        }
        
        return null;
    }
}
import com.kh.spring.model.mapper.MemberMapper;
import com.kh.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service // @Component보다 더 구체화해서 service 객체에 알맞게 bean에 등록해준다.
public class MemberServiceImpl implements MemberService {

}
