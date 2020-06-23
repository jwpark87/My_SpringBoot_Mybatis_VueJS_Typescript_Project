package com.github.bestheroz.sample.api.auth;

import com.github.bestheroz.sample.api.entity.member.TableMemberRepository;
import com.github.bestheroz.sample.api.entity.member.TableMemberVO;
import com.github.bestheroz.standard.common.authenticate.JwtTokenProvider;
import com.github.bestheroz.standard.common.response.ApiResult;
import com.github.bestheroz.standard.common.response.Result;
import com.github.bestheroz.standard.common.util.AuthenticationUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping(value = "/api/auth")
public class AuthController {
    @Resource private AuthService authService;
    @Resource private TableMemberRepository tableMemberRepository;

    @PostMapping(value = "/login")
    @ResponseBody
    ResponseEntity<ApiResult> login(@RequestBody final TableMemberVO tableMemberVO) {
        return Result.ok(this.authService.login(tableMemberVO.getId(), tableMemberVO.getPassword()));
    }

    @GetMapping(value = "/me")
    public ResponseEntity<ApiResult> getMyData(@RequestHeader(value = "Authorization") final String token) {
        return Result.ok(JwtTokenProvider.getAuthentication(token).getPrincipal());
    }

    @DeleteMapping(value = "/logout")
    public void logout() {
        AuthenticationUtils.logout();
    }
}
