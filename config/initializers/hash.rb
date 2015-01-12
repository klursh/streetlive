class Hash
  # see: http://jugyo.wordpress.com/2007/09/23/ruby-%E3%81%AE-hash-%E3%81%AB-array-%E3%81%BF%E3%81%9F%E3%81%84%E3%81%AA-join-%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89/
  def join(str1, str2)
    to_a.collect { |array|
      array.join(str1)
    }.join(str2)
  end
end
