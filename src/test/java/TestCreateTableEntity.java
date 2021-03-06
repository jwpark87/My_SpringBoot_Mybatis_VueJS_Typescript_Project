import com.github.bestheroz.standard.context.db.checker.DbTableVOCheckerContext;
import com.github.bestheroz.standard.context.web.WebConfiguration;
import com.google.common.base.CaseFormat;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import javax.annotation.Resource;
import javax.sql.DataSource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.AutoConfigureMybatis;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest(classes = {WebConfiguration.class})
@AutoConfigureMybatis
public class TestCreateTableEntity {
  private final String tableName = "code_group";
  private final String javaPackageEndPoint =
    this.tableName.replaceAll("_", ".").toLowerCase();
  private final String javaProjectRootPackageName = "com.github.bestheroz.";
  private final String javaPackageName =
    this.javaProjectRootPackageName + "demo.api.entity.";
  private final String javaFilePath =
    "src/main/java/" + this.javaPackageName.replaceAll("\\.", "/");
  private final String tsFilePath = "vue/src/common/types.ts";
  @Qualifier("dataSource")
  @Resource
  private DataSource dataSource;

  @Test
  public void makeEntityRepositoryFilesAuto() {
    try (
      final Statement stmt = this.dataSource.getConnection().createStatement()
    ) {
      try (
        final ResultSet rs = stmt.executeQuery(
          "SELECT * FROM " + this.tableName + " LIMIT 0"
        )
      ) {
        final String tableEntityName =
          "Table" +
            CaseFormat.LOWER_UNDERSCORE.to(
              CaseFormat.UPPER_CAMEL,
              this.tableName
            ) +
            "Entity";

        final ResultSetMetaData metaInfo = rs.getMetaData();
        System.out.println(tableEntityName);
        // 1. VO만들기
        final StringBuilder javaString = new StringBuilder();
        final StringBuilder tsString = new StringBuilder();
        for (int i = 0; i < metaInfo.getColumnCount(); i++) {
          final String fieldType;
          final String tsType;
          final String columnTypeName = metaInfo.getColumnTypeName(i + 1);
          final String columnName = metaInfo.getColumnName(i + 1);
          final String camelColumnName = CaseFormat.LOWER_UNDERSCORE.to(
            CaseFormat.LOWER_CAMEL,
            columnName
          );
          if (
            DbTableVOCheckerContext.STRING_JDBC_TYPE_SET.contains(
              columnTypeName
            )
          ) {
            fieldType = "String";
            tsType = "string";
          } else if (
            StringUtils.equalsAny(
              columnTypeName,
              "NUMBER",
              "DECIMAL",
              "BIGINT UNSIGNED",
              "BIGINT",
              "SMALLINT UNSIGNED",
              "SMALLINT"
            )
          ) {
            if (metaInfo.getScale(i + 1) > 0) { // 소수점이 있으면
              fieldType = "Double";
            } else {
              final int columnDisplaySize = metaInfo.getColumnDisplaySize(
                i + 1
              ); // 실제 자리수보다 한자리 더 나옴(소수점 "." 때문일까?)
              if (columnDisplaySize <= 5) { // 5자리 보장못함, 4자리 보장
                fieldType = "Short"; // –32,768 ~ 32,767
              } else if (columnDisplaySize <= 10) { // 10자리 보장못함, 9자리 보장
                fieldType = "Integer"; // –2,147,483,648 ~ 2,147,483,647
                // } else if (columnDisplaySize < 19) {
                // 19자리 보장못함, 18자리 보장, 하지만 (오라클) NUMBER형 기본형이 39다.. Long 으로 처리가자.
                // fieldType = "Long"; // -9223372036854775808 ~ 9223372036854775807
              } else { // 19자리 보장못함, 18자리 보장, 하지만 (오라클) NUMBER형 기본형이 39다.. Long 으로 처리가자.
                fieldType = "Long";
                // fieldType = "Double";
              }
            }
            tsType = "number";
          } else if (
            DbTableVOCheckerContext.NUMBER_JDBC_TYPE_SET.contains(
              columnTypeName
            )
          ) {
            fieldType = "Integer";
            tsType = "number";
          } else if (
            DbTableVOCheckerContext.DATETIME_JDBC_TYPE_SET.contains(
              columnTypeName
            )
          ) {
            fieldType = DbTableVOCheckerContext.DEFAULT_DATE_TYPE;
            tsType = "Date | string";
          } else if (
            DbTableVOCheckerContext.BOOLEAN_JDBC_TYPE_SET.contains(
              columnTypeName
            )
          ) {
            fieldType = "Boolean";
            tsType = "boolean";
          } else if (
            DbTableVOCheckerContext.BYTE_JDBC_TYPE_SET.contains(columnTypeName)
          ) {
            fieldType = "Byte[];";
            tsType = "any[]";
            log.debug(
              "private Byte[] {}{}",
              camelColumnName,
              "; // XXX: spotbugs 피하기 : Arrays.copyOf(value, value.length)"
            );
          } else {
            fieldType = "Unknown";
            tsType = "unknown";
            log.warn("케이스 빠짐 {} : {}", columnName, columnTypeName);
          }
          javaString
            .append("private ")
            .append(fieldType)
            .append(" ")
            .append(camelColumnName)
            .append(";\n");
          tsString
            .append(camelColumnName)
            .append("?: ")
            .append(tsType)
            .append(" | null;\n");
        }
        this.writeToFile(tableEntityName, javaString, tsString);
      }
    } catch (final Throwable e) {
      log.warn(ExceptionUtils.getStackTrace(e));
    }
  }

  private void writeToFile(
    final String tableEntityName,
    final StringBuilder javaString,
    final StringBuilder tsString
  )
    throws IOException {
    final boolean hasAbstractCreatedUpdateEntity =
      StringUtils.contains(javaString, " createdBy") &&
        StringUtils.contains(javaString, " created") &&
        StringUtils.contains(javaString, " updatedBy") &&
        StringUtils.contains(javaString, " updated");
    final String javaHeader =
      "package " +
        this.javaPackageName +
        this.javaPackageEndPoint +
        ";\n" +
        "\n" +
        (
          hasAbstractCreatedUpdateEntity
            ? "import " + this.javaPackageName + "AbstractCreatedUpdateEntity;\n"
            : ""
        ) +
        "import lombok.Data;\n" +
        "import lombok.EqualsAndHashCode;\n" +
        "\n" +
        "import java.io.Serializable;\n" +
        "\n" +
        (
          hasAbstractCreatedUpdateEntity
            ? "@EqualsAndHashCode(callSuper = true)\n"
            : ""
        ) +
        "@Data\n" +
        "public class " +
        tableEntityName +
        (
          hasAbstractCreatedUpdateEntity
            ? " extends AbstractCreatedUpdateEntity"
            : ""
        ) +
        " implements Serializable {\n";
    final String javaBody = hasAbstractCreatedUpdateEntity
      ? javaString
      .toString()
      .replace("private String createdBy;\n", "")
      .replace("private Instant created;\n", "")
      .replace("private String updatedBy;\n", "")
      .replace("private Instant updated;\n", "")
      : javaString.toString();
    if (
      Files
        .notExists(Paths.get(this.javaFilePath + this.javaPackageEndPoint.replaceAll("\\.", "/")))
    ) {
      FileUtils.forceMkdir(
        Paths.get(this.javaFilePath + this.javaPackageEndPoint.replaceAll("\\.", "/")).toFile()
      );
    }
    final Path javaEntityFilePath = Paths.get(
      this.javaFilePath +
        this.javaPackageEndPoint.replaceAll("\\.", "/") +
        "/" +
        tableEntityName +
        ".java"
    );
    Files.write(
      javaEntityFilePath,
      (javaHeader + javaBody + "}").getBytes(),
      Files.notExists(javaEntityFilePath)
        ? StandardOpenOption.CREATE_NEW
        : StandardOpenOption.TRUNCATE_EXISTING
    );
    final String repositoryHeader =
      "package " +
        this.javaPackageName +
        this.javaPackageEndPoint +
        ";\n" +
        "\n" +
        "import " +
        this.javaProjectRootPackageName +
        "standard.common.mybatis.SqlRepository;\n" +
        "import org.apache.ibatis.annotations.Mapper;\n" +
        "import org.springframework.stereotype.Repository;\n" +
        "\n" +
        "@Mapper\n" +
        "@Repository\n" +
        "public interface " +
        tableEntityName.replace("Entity", "Repository") +
        " extends SqlRepository<" +
        tableEntityName +
        "> {\n" +
        "}\n";
    final Path javaRepositoryFilePath = Paths.get(
      this.javaFilePath +
        this.javaPackageEndPoint.replaceAll("\\.", "/") +
        "/" +
        tableEntityName.replace("Entity", "Repository") +
        ".java"
    );
    Files.write(
      javaRepositoryFilePath,
      repositoryHeader.getBytes(),
      Files.notExists(javaRepositoryFilePath)
        ? StandardOpenOption.CREATE_NEW
        : StandardOpenOption.TRUNCATE_EXISTING
    );
    final String tsHeader = "export interface " + tableEntityName + " {\n";
    Files.write(
      Paths.get(this.tsFilePath),
      (tsHeader + tsString + "}\n").getBytes(),
      StandardOpenOption.APPEND
    );
  }
}
