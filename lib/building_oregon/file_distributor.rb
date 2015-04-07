module BuildingOregon
  class FileDistributor
    attr_accessor :base_path, :identifier, :depth, :extension


    def initialize(identifier)
      @identifier = identifier.to_s
      @depth = 2
      @source_site = "http://oregondigital.library.oregonstate.edu/"
      @base_path = @source_site + "media/" + "medium-images/"
      @extension = ".jpg"
    end

    def identifier
      return @identifier.gsub(/\W/, '-')
    end

    def filename
      return identifier + extension
    end

    def bucket_path
      reversed = (identifier.rjust(@depth, "0")).reverse.split(//)
      bucket_path = (["%s"] * @depth).join("/") % reversed + "/"
      bucket_path
    end

    def path
      return @base_path + bucket_path + filename
    end
  end
end
