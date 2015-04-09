module BuildingOregon
  class FileDistributor
    attr_accessor :base_path, :identifier, :depth, :extension, :source_site


    def initialize(identifier)
      @identifier = identifier.to_s
      @depth = 2
      @source_site = ""
      @base_path = "media/" + "medium-images/"
      @extension = ""
    end

    def identifier
      return @identifier.gsub(/\W/, '-')
    end

    def filename
      return identifier + extension
    end

    def source_site= (site)
      @source_site = site
    end

    def extension=(extension)
      @extension = extension
    end

    def bucket_path
      reversed = (identifier.rjust(@depth, "0")).reverse.split(//)
      bucket_path = (["%s"] * @depth).join("/") % reversed + "/"
      bucket_path
    end

    def path
      return @source_site + "media/medium-images/" + bucket_path + filename
    end
  end
end
