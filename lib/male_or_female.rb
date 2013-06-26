# encoding: UTF-8

require 'male_or_female/version'
require 'unicode_utils'
require 'yaml'

module MaleOrFemale

  COMPILED_DIR = File.expand_path('../male_or_female/data_compiled', __FILE__)
  SOURCE_DIR =  File.expand_path('../male_or_female/data_source', __FILE__)

  UNKNOWN = :unknown

  MALE, FEMALE, UNISEX = :male, :female, :unisex
  GENDERS = [FEMALE, MALE, UNISEX]
  FORMAL, INFORMAL = :formal, :informal
  FORMATS = [INFORMAL, UNISEX, FORMAL]

  class Detector
    def initialize(name, options = {})
      @name   = prepare_name(name)
      @data   = load_data!
      @result = detect
    end

    def gender
      result = nil
      GENDERS.each { |gender| result = gender if @result =~ /(\s|^)(#{gender})[_]/i  }
      result.nil? ? UNKNOWN : result
    end

    def format
      result = nil
      FORMATS.each { |format| return format if @result =~ /[_](#{format})/i }
      result.nil? ? UNKNOWN : result
    end

    def reset!
      @@data = nil
    end

    def reload!
      reset!
      load_data!
    end

    # PRIVATE
    private

    def load_data!
      @@data ||= YAML.load_file(File.open("#{COMPILED_DIR}/ru.yaml"))
    end

    # Проверет имя (возьмет первую букву от имени, проверит значение в
    # в хеше @data[:первая_буква]).
    #
    # Вернет: 'male_formal', 'female_formal', 'unisex' etc.
    def detect
      result = nil

      return result if @data.nil? || @data[@name[0]].nil?

      # ["male_formal", "Август Авдей Аверкий ... "]
      @data[@name[0]].each do |sex|
        next if sex[1].nil?
        result = sex[0] if sex[1] =~ /(\s|^)(#{@name})(\s|$)/i
      end
      result
    end

    def prepare_name(name)
      name = UnicodeUtils.downcase(name).strip
      name = name.gsub(/[ё]/i, 'е')
      name[0] = UnicodeUtils.upcase(name[0])
      name
    rescue
      raise ArgumentError.new('Name should be a string')
    end
  end
end
