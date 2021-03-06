package com.github.bestheroz.demo.api.admin.member;

import com.github.bestheroz.demo.api.entity.member.TableMemberEntity;
import com.github.bestheroz.demo.api.entity.member.TableMemberRepository;
import com.github.bestheroz.standard.common.response.ApiResult;
import com.github.bestheroz.standard.common.response.Result;
import java.util.Map;
import java.util.stream.Collectors;
import javax.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(value = "api/admin/members")
public class AdminMemberController {
  @Resource
  private TableMemberRepository tableMemberRepository;

  @GetMapping
  ResponseEntity<ApiResult> getItems() {
    return Result.ok(
      this.tableMemberRepository.getItems()
        .stream()
        .peek(item -> item.setPassword(null))
        .collect(Collectors.toList())
    );
  }

  @GetMapping(value = "{id}")
  ResponseEntity<ApiResult> getItem(
    @PathVariable(value = "id") final String id
  ) {
    return Result.ok(
      this.tableMemberRepository.getItemByKey(Map.of("id", id))
        .map(
          item -> {
            item.setPassword(null);
            return item;
          }
        )
    );
  }

  @PostMapping
  @CacheEvict(value = "memberCache", allEntries = true)
  public ResponseEntity<ApiResult> post(
    @RequestBody final TableMemberEntity tableMemberEntity
  ) {
    this.tableMemberRepository.insert(tableMemberEntity);
    return Result.created();
  }

  @PatchMapping(value = "{id}")
  @CacheEvict(value = "memberCache", allEntries = true)
  public ResponseEntity<ApiResult> patch(
    @PathVariable(value = "id") final String id,
    @RequestBody final TableMemberEntity tableMemberEntity
  ) {
    this.tableMemberRepository.updateMapByKey(
        Map.of(
          "name",
          tableMemberEntity.getName(),
          "authority",
          tableMemberEntity.getAuthority(),
          "expired",
          tableMemberEntity.getExpired(),
          "available",
          tableMemberEntity.isAvailable(),
          "timeout",
          tableMemberEntity.getTimeout()
        ),
        Map.of("id", id)
      );
    return Result.ok();
  }

  @DeleteMapping(value = "{id}")
  @CacheEvict(value = "memberCache", allEntries = true)
  public ResponseEntity<ApiResult> delete(
    @PathVariable(value = "id") final String id
  ) {
    this.tableMemberRepository.deleteByKey(Map.of("id", id));
    return Result.ok();
  }

  @PostMapping(value = "{id}/resetPassword")
  public ResponseEntity<ApiResult> resetPassword(
    @PathVariable(value = "id") final String id
  ) {
    this.tableMemberRepository.resetPassword(id);
    return Result.ok();
  }
}
