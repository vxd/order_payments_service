# frozen_string_literal: true

module JsonHelper
  def json_data(filename:)
    file_content = file_fixture("#{filename}.json").read
    JSON.parse(file_content, symbolize_names: true)
  end

  private

  def file_fixture(fixture_name)
    file_fixture_path = './spec/fixtures'
    path = Pathname.new(File.join(file_fixture_path, fixture_name))

    if path.exist?
      path
    else
      msg = "the directory '%s' does not contain a file named '%s'"
      raise ArgumentError, format(msg, file_fixture_path, fixture_name)
    end
  end
end
