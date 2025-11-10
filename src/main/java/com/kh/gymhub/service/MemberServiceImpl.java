package com.kh.gymhub.service;

import com.kh.spring.model.mapper.MemberMapper;
import com.kh.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service // @Component보다 더 구체화해서 service 객체에 알맞게 bean에 등록해준다.
public class MemberServiceImpl implements MemberService {

}
