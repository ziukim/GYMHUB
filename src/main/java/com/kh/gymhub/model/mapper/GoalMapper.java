package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.MemberGoal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GoalMapper {
    List<MemberGoal> selectMemberGoals(@Param("memberNo") int memberNo);
    MemberGoal selectGoalByManageNo(@Param("goalManageNo") int goalManageNo);
    int insertGoal(MemberGoal memberGoal);
    int insertGoalManage(MemberGoal memberGoal);
    Integer selectGoalNoByManageNo(@Param("goalManageNo") int goalManageNo);
    int deleteGoalManage(@Param("goalManageNo") int goalManageNo, @Param("memberNo") int memberNo);
    int countGoalManageByGoalNo(@Param("goalNo") int goalNo);
    int deleteGoal(@Param("goalNo") int goalNo);
}

