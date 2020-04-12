package com.github.bestheroz.sample.api.auth;

import com.github.bestheroz.sample.api.entity.samplemembermst.TableSampleMemberMstRepository;
import com.github.bestheroz.sample.api.entity.samplemembermst.TableSampleMemberMstVO;
import com.github.bestheroz.standard.common.response.ResponseVO;
import com.github.bestheroz.standard.common.util.SessionUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping(value = "/sample/auth")
public class AuthController {
    @Resource private AuthService authService;
    @Resource private TableSampleMemberMstRepository tableSampleMemberMstRepository;

    @PostMapping(value = "/login")
    public ResponseVO login(@RequestBody final TableSampleMemberMstVO tableSampleMemberMstVO) {
        System.out.println(tableSampleMemberMstVO.toString());
        return ResponseVO.getSuccessResponseVO(this.authService.login(tableSampleMemberMstVO.getId(), tableSampleMemberMstVO.getPassword()));
    }

    @PostMapping(value = "/verify")
    public ResponseVO verify(@RequestHeader(value = "Authorization", required = false) final String token) {
        final TableSampleMemberMstVO loginVO = SessionUtils.getLoginVO();
        this.authService.verify(token, loginVO.getId());
        return ResponseVO.getSuccessResponseVO(loginVO);
    }

    @DeleteMapping(value = "/logout")
    public void logout() {
        final TableSampleMemberMstVO loginVO = SessionUtils.getLoginVO();
        loginVO.setToken(null);
        this.tableSampleMemberMstRepository.save(loginVO);
        SessionUtils.logout();
    }
}
