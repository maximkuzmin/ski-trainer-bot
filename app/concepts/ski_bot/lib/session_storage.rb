module SkiBot
  class SessionStorage
    class << self
      @@storage = {}

      def set(key, value)
        @@storage[key.to_s] = value
      end

      def get(key)
        result = @@storage[key.to_s]
        set(key, {}) if !result
        @@storage[key.to_s]
      end

      def [](key)
        get(key)
      end

      def []=(*args)
        key, value = args
        set(key, value)
      end

      def clean_previous(id)
        get(id)
        @@storage[id.to_s][:previous] = nil
      end
    end
  end
end
