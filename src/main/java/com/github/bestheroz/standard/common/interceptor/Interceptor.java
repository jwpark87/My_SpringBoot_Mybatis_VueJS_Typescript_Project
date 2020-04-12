package com.github.bestheroz.standard.common.interceptor;

import com.github.bestheroz.sample.api.auth.AuthService;
import com.github.bestheroz.sample.api.entity.samplemembermst.TableSampleMemberMstRepository;
import com.github.bestheroz.sample.api.entity.samplemembermst.TableSampleMemberMstVO;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.AccessBeanUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.commons.lang3.time.StopWatch;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.UrlPathHelper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@Slf4j
public class Interceptor extends HandlerInterceptorAdapter {
    private static final String REQUEST_COMPLETE_EXECUTE_TIME_INCLUDE_JSP = "{} ....... Request Complete Execute Time ....... : {}";
    private static final String STR_STOP_WATCH = "mi.stopWatch";

    @Override
    public boolean preHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler) {
        if (!request.getMethod().equalsIgnoreCase("OPTIONS")) {
            try {
                if (SessionUtils.isNotLoggedIn()) {
                    /**
                     * 개발시 domain 이 서로 다르기 때문에 session 이 유지 되지 않는다.(CORS)
                     */
                    final String authorization = request.getHeader("Authorization");
                    if (StringUtils.isEmpty(authorization)) {
                        throw BusinessException.FAIL_TRY_LOGIN_FIRST;
                    }
                    final Optional<TableSampleMemberMstVO> one = AccessBeanUtils.getBean(TableSampleMemberMstRepository.class).findByToken(authorization);
                    if (one.isPresent()) {
                        try {
                            AccessBeanUtils.getBean(AuthService.class).verify(authorization, one.get().getId());
                        } catch (final BusinessException e) {
                            throw BusinessException.FAIL_TRY_LOGIN_FIRST;
                        }
                        SessionUtils.setLoginVO(one.get());
                    }
                }
            } catch (final BusinessException e) {
                log.warn(ExceptionUtils.getStackTrace(e));
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                response.setStatus(HttpServletResponse.SC_OK);
                try {
                    response.getWriter().write(e.toString());
                } catch (final IOException ex) {
                    log.warn(ExceptionUtils.getStackTrace(ex));
                }
                return false;
            }
        }
        final StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        request.setAttribute(STR_STOP_WATCH, stopWatch);
        return true;
    }

    @Override
    // postHandle : controller 호출 후 view 페이지 출력전
    public void postHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler, final ModelAndView modelAndView) {
    }

    @Override
    // afterCompletion : controller + view 페이지 모두 출력 후
    public void afterCompletion(final HttpServletRequest request, final HttpServletResponse response, final Object handler, final Exception ex) {
        final StopWatch stopWatch = (StopWatch) request.getAttribute(STR_STOP_WATCH);
        stopWatch.stop();
        log.info(REQUEST_COMPLETE_EXECUTE_TIME_INCLUDE_JSP, new UrlPathHelper().getPathWithinApplication(request), stopWatch.toString());
        request.removeAttribute(STR_STOP_WATCH);
    }

    @Override
    // afterConcurrentHandlingStarted: 뭐 동시에 핸들링 해주는 메서드인대 정확히는 모르겠습니다
    public void afterConcurrentHandlingStarted(final HttpServletRequest request, final HttpServletResponse response, final Object handler) {
        //
    }
}
