class Person
  def self.is_git_valid?(git)
    return false if git.nil?
    git.match?(/^(https?:\/\/)?(www\.)?github\.com\/[a-zA-Z0-9_-]+$/)
  end

  def self_parse_fullname(info_string)
    info_string[/^[А-Яа-яёЁ\-]+ [А-Яа-я]\.[А-Яа-я]\./]
  end

  def self_parse_git(info_string)
    info_string[/Git: ([^,]+)/, 1]
  end

  def self_parse_contact(info_string)
    info_string[/(phone|email|telegram):\s?(\S+)/, 0]
  end
end