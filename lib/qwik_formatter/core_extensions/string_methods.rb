# Copyright (C) 2003-2006 Kouichirou Eto, All rights reserved.
# This is free software with ABSOLUTELY NO WARRANTY.
# You can redistribute it and/or modify it under the terms of the GNU GPL 2.

require 'digest/md5'
require 'base64'

module QwikFormatter
  module CoreExtensions
    module StringMethods
      def xchomp
        return self.chomp("\n").chomp("\r")
      end

      # Used from parser.rb
      def chompp
        return self.sub(/[\n\r]+\z/, '')
      end

      def normalize_eol
        return self.xchomp+"\n"
      end

      def normalize_newline
        return self.gsub("\r\n", "\n").gsub("\r", "\n")
      end

      def sub_str(pattern, replace)
        return sub(Regexp.new(Regexp.escape(pattern)), replace)
      end

      def md5
        return Digest::MD5.digest(self)
      end

      def md5hex
        return Digest::MD5.hexdigest(self)
      end

      def base64
        return Base64.encode64(self).chomp
      end

      # ============================== escape
      # Copied from cgi.rb
      def escape
        return dup.force_encoding('ASCII-8BIT').gsub(/([^ a-zA-Z0-9_.-]+)/n) {
          '%' + $1.unpack('H2' * $1.size).join('%').upcase
        }.tr(' ', "+")
      end

      def unescape
        return self.tr("+", ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) {
          [$1.delete('%')].pack('H*')
        }
      end

      def unescapeHTML
        return self.gsub(/&(.*?);/n) {
          match = $1.dup
          case match
          when /\Aamp\z/ni	then "&"
          when /\Aquot\z/ni	then "'"
          when /\Agt\z/ni	then ">"
          when /\Alt\z/ni	then "<"
          else
            "&#{match};"
          end
        }
      end

      def mb_length
        case self.charset || self.guess_charset
        when 'UTF-8';       return self.split(//u).length
        when 'Shift_JIS';   return self.split(//s).length
        when 'EUC-JP';      return self.split(//e).length
        end
        return self.length
      end

      def mb_substring(s,e)
        case self.charset || self.guess_charset
        when 'UTF-8';       return self.split(//u)[s...e].to_s
        when 'Shift_JIS';   return self.split(//s)[s...e].to_s
        when 'EUC-JP';      return self.split(//e)[s...e].to_s
        end
        return self[s...e]
      end

      # Copied from gonzui-0.1
      # Use this method instead of WEBrick::HTMLUtils.escape for performance reason.
      ESCAPE_TABLE = {
        "&" => "&amp;",
        '"' => "&quot;",
        '<' => "&lt;",
        '>' => "&gt;",
      }

      def escapeHTML
        string = self
        return string.gsub(/[&"<>]/n) {|x| ESCAPE_TABLE[x] }
      end
    end
  end
end
