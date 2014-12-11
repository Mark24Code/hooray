module Hooray
  # App settings
  class Settings
    CONFIG_DIR = ENV['HOME'] + '/.hooray/'

    class << self
      attr_accessor :all, :services, :devices, :macs

      def no_config_folder
        puts "No config folder, run `#{$PROGRAM_NAME} init`"
        puts
        exit 1
      end

      def load!
        no_config_folder unless Dir.exist?(CONFIG_DIR)
        @all = YAML.load_file(CONFIG_DIR + 'settings.yml')
        @services = YAML.load_file(CONFIG_DIR + 'services.yml')
        @devices  = YAML.load_file(CONFIG_DIR + 'devices.yml')
        @macs = {}
        File.read(CONFIG_DIR + 'nmap-mac-prefixes').each_line do |line|
          next if line =~ /^\s*#/
          prefix, *name = *line.split(/\s/)
          @macs.store(prefix, name.join(' '))
        end
      end

      def list
        out = 'SCAN: '
        out += ' SYN' if syn_scan
        out += ' SERVICE' if service_scan
        out += ' OS' if os_fingerprint
        out
      end

      def device(mac)
        devices ||= {}
        devices[mac.to_sym] || devices[mac.to_s]
      end

      def family(mac)
        prefix = mac.to_s.gsub(':', '')[0,6].upcase
        macs[prefix]
      end

      def all
        @all ||= {}
      end

      def method_missing(meth, *params)
        if meth =~ /=/
          all[meth.to_s.gsub('=', '')] = params.first
        else
          arg = meth.to_s.gsub('?', '')
          all[arg] || all[arg.to_sym]
        end
      end
    end # class << self
  end # Settings
end # Hooray
