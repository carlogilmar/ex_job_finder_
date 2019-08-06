defmodule RemoteJobs.FileUtilTest do
  use ExUnit.Case
  alias RemoteJobs.FileUtil

  [
    {{:error, :enoent}, "No se encontró template"},
    {{:ok, "template>>>"}, "template>>>"},
    {{:ok, "template>!"}, "template>!"},
  ] |> Enum.each(fn {tuple, expected_result} ->
    @tuple tuple
    @expected_result expected_result
    test "Test validation tuple: #{expected_result}" do
      expected = FileUtil.verify_template.(@tuple)
      assert expected == @expected_result
    end
  end)

  [
    {"Hola <%= name %>",
      [name: "carlo"],
      "Hola carlo"},
    {"Hola <%= name %> <%= surname %>",
      [name: "carlo", surname: "gilmar"],
      "Hola carlo gilmar"},
    {"Hola <%= name %> <%= surname %> <%= age %>",
      [name: "carlo", surname: "gilmar", age: 10],
      "Hola carlo gilmar 10"}
  ] |> Enum.each(fn {str, attr, expected} ->
    @str str
    @attr attr
    @expected expected
    test "Test validation tuple: #{expected}" do
      expected = FileUtil.match_file_content(@str, @attr)
      assert expected == @expected
    end
  end)
end
