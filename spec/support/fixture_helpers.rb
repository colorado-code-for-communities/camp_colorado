module FixtureHelpers
  def read_xml_fixture(file_name)
    File.read(File.expand_path("../../fixtures/#{file_name}", __FILE__))
  end
end
