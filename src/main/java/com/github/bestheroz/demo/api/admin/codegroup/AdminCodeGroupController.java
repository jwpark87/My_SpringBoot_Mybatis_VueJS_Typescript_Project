package com.github.bestheroz.demo.api.admin.codegroup;

import com.github.bestheroz.demo.api.entity.code.group.TableCodeGroupEntity;
import com.github.bestheroz.demo.api.entity.code.group.TableCodeGroupRepository;
import com.github.bestheroz.standard.common.response.ApiResult;
import com.github.bestheroz.standard.common.response.Result;
import java.util.Map;
import javax.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(value = "api/admin/codeGroups")
public class AdminCodeGroupController {
  @Resource
  private TableCodeGroupRepository tableCodeGroupRepository;
  @Resource
  private AdminCodeGroupService adminCodeGroupService;

  @GetMapping
  ResponseEntity<ApiResult> getItems() {
    return Result.ok(this.tableCodeGroupRepository.getItems());
  }

  @GetMapping(value = "{codeGroup}")
  ResponseEntity<ApiResult> getItem(
    @PathVariable(value = "codeGroup", required = false) final String codeGroup
  ) {
    return Result.ok(
      this.tableCodeGroupRepository.getItemByKey(Map.of("codeGroup", codeGroup))
    );
  }

  @PostMapping
  ResponseEntity<ApiResult> post(
    @RequestBody final TableCodeGroupEntity tableCodeGroupEntity
  ) {
    this.tableCodeGroupRepository.insert(tableCodeGroupEntity);
    return Result.created();
  }

  @PatchMapping(value = "{codeGroup}")
  ResponseEntity<ApiResult> patch(
    @PathVariable(value = "codeGroup") final String codeGroup,
    @RequestBody final TableCodeGroupEntity tableCodeGroupEntity
  ) {
    this.tableCodeGroupRepository.updateByKey(
      tableCodeGroupEntity,
      Map.of("codeGroup", codeGroup)
    );
    return Result.ok();
  }

  @DeleteMapping(value = "{codeGroup}")
  ResponseEntity<ApiResult> delete(
    @PathVariable(value = "codeGroup") final String codeGroup
  ) {
    this.adminCodeGroupService.delete(codeGroup);
    return Result.ok();
  }
}
