Forked from https://github.com/shlima/MaleOrFemale

_MaleOrFemale_ - gem для определения пола человека (male, female, unisex) по его имени. Гем также определяет тип имени (официальное или неформальное).

**На данный момент гем определяет только русскоязычные имена**

Пол определяется по справочнику

## Использование

    require 'male_or_female'
    name = MaleOrFemale::Detector.new('Дима')
    name.gender # => :male
    name.format # => :informal
    
## Параметры

    MaleOrFemale::Detector.new('Саша')

## Installation

Add this line to your application's Gemfile:

    gem 'male_or_female', :git => 'git://github.com/dizer/male_or_female.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install male_or_female

## Contributing

Имена хранятся в отдельных YAML файлах по первой букве алфавита в дирректории /lib/male_or_female/data_dource. 

При публикации гема все эти файлы собираются в один скопилированный yml командой rake data:build.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
