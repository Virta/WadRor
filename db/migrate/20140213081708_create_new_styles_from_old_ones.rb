class CreateNewStylesFromOldOnes < ActiveRecord::Migration
  def change
    styles_strings = Beer.all.map{ |b| b.old_style }.uniq
    styles_strings.each do |style|
      Style.create name:style, description:"Add a description for this style of beer!"
    end
  end
end
