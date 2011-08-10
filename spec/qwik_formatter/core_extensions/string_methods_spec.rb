# -*- coding: UTF-8 -*-
require 'spec_helper'
require 'qwik_formatter/core_extensions/string_extensions'

module QwikFormatter
  module CoreExtensions
    String.class_eval { include StringMethods }

    describe "String including StringMethods" do
      describe "#xchomp" do
        specify '"".xchomp == ""' do
          "".xchomp.should eq ""
        end

        specify '"\n".xchomp == ""' do
          "\n".xchomp.should eq ""
        end

        specify '"\r".xchomp == ""' do
          "\r".xchomp.should eq ""
        end

        specify '"\r\n".xchomp == ""' do
          "\r\n".xchomp.should eq ""
        end

        specify '"\n\r".xchomp == "\n"' do
          "\n\r".xchomp.should eq "\n"
        end

        specify '"t".xchomp == "t"' do
          "t".xchomp.should eq "t"
        end

        specify '"t\r".xchomp == "t"' do
          "t\r".xchomp.should eq "t"
        end

        specify '"t\n".xchomp == "t"' do
          "t\n".xchomp.should eq "t"
        end
      end

      describe "#chompp" do
        specify '"\n\r".chompp == ""' do
          "\n\r".chompp.should eq ""
        end

        specify '"\n\r\n\r".chompp == ""' do
          "\n\r\n\r".chompp.should eq ""
        end
      end

      describe "#normalize_eol" do
        specify '"".normalize_eol == "\n"' do
          "".normalize_eol.should eq "\n"
        end
        specify '"\n".normalize_eol == "\n"' do
          "\n".normalize_eol.should eq "\n"
        end

        specify '"t".normalize_eol == "t\n"' do
          "t".normalize_eol.should eq "t\n"
        end

        specify '"t\n".normalize_eol == "t\n"' do
          "t\n".normalize_eol.should eq "t\n"
        end
      end

      describe "#normalize_newline" do
        specify '"\n".normalize_newline == "\n"' do
          "\n".normalize_newline.should eq "\n"
        end

        specify '"\r".normalize_newline == "\n"' do
          "\r".normalize_newline.should eq "\n"
        end

        specify '"\r\n".normalize_newline == "\n"' do
          "\r\n".normalize_newline.should eq "\n"
        end

        specify '"\n\r".normalize_newline == "\n\n"' do
          "\n\r".normalize_newline.should eq "\n\n"
        end

        specify '"\ra\r".normalize_newline == "\na\n"' do
          "\ra\r".normalize_newline.should eq "\na\n"
        end

        specify '"\r\na\r\n".normalize_newline == "\na\n"' do
          "\r\na\r\n".normalize_newline.should eq "\na\n"
        end

        specify '"\n\ra\n\r".normalize_newline == "\n\na\n\n"' do
          "\n\ra\n\r".normalize_newline.should eq "\n\na\n\n"
        end
      end

      describe "#sub_str" do
        specify '"a*b".sub_str("*", ":") == "a:b"' do
          "a*b".sub_str("*", ":").should eq "a:b"
        end
      end

      describe "#md5" do
        specify '"t".md5 is a String' do
          't'.md5.should be_an_instance_of(String)
        end

        specify '"t".md5.length == 16' do
          "t".md5.length.should eq 16
        end

        specify '"t".md5 == "\343X\357\244\211\365\200b\361\r\3271ked\236" in ASCII-8BIT' do
          "t".md5.should eq "\343X\357\244\211\365\200b\361\r\3271ked\236".force_encoding("ASCII-8BIT")
        end
      end

      describe "#md5hex" do
        specify '"t".md5hex is a String' do
          't'.md5hex.should be_an_instance_of(String)
        end

        specify '"t".md5hex.length == 32' do
          "t".md5hex.length.should eq 32
        end

        specify '"t".md5hex "e358efa489f58062f10dd7316b65649e"' do
          "t".md5hex.should eq "e358efa489f58062f10dd7316b65649e"
        end
      end

      describe "#base64" do
        specify '"t".base64 == "dA=="' do
          "t".base64.should eq "dA=="
        end
      end

      describe "#escape" do
        specify '"A".escape == "A"' do
          "A".escape.should eq "A"
        end

        specify '" ".escape == "+"' do
          " ".escape.should eq "+"
        end

        specify '"+".escape == "%2B"' do
          "+".escape.should eq "%2B"
        end

        specify '"!".escape == "%21"' do
          "!".escape.should eq "%21"
        end

        # TODO: encoding issues
        specify '"ABCあいう +#".encode("SJIS").escape == "ABC%82%A0%82%A2%82%A4+%2B%23"' do
          "ABCあいう +#".encode("SJIS").escape.should eq "ABC%82%A0%82%A2%82%A4+%2B%23"
        end
      end

      describe "#unescape" do
        specify '"%41".unescape == "A"' do
          "%41".unescape.should eq "A"
        end

        specify '"+".unescape == " "' do
          "+".unescape.should eq " "
        end

        specify '"%21".unescape == "!"' do
          "%21".unescape.should eq "!"
        end

        # TODO: encoding issues
        specify '"ABC%82%A0%82%A2%82%A4+%2B%23".unescape == "ABCあいう +#".encode("SJIS")' do
          "ABC%82%A0%82%A2%82%A4+%2B%23".unescape.force_encoding("SJIS").should eq "ABCあいう +#".encode("SJIS")
        end
      end

      describe "#escapeHTML" do
        specify '"<".escapeHTML == "&lt;"' do
          "<".escapeHTML.should eq "&lt;"
        end

        specify '">".escapeHTML == "&gt;"' do
          ">".escapeHTML.should eq "&gt;"
        end

        specify '"&".escapeHTML == "&amp;"' do
          "&".escapeHTML.should eq "&amp;"
        end

        specify '"<a href=\"http://e.com/\">e.com</a>".escapeHTML == "&lt;a href=&quot;http://e.com/&quot;&gt;e.com&lt;/a&gt;"' do
          "<a href=\"http://e.com/\">e.com</a>".escapeHTML.
            should eq "&lt;a href=&quot;http://e.com/&quot;&gt;e.com&lt;/a&gt;"
        end
      end

      describe "#unescapeHTML" do
        specify '"&lt;".unescapeHTML == "<"' do
          "&lt;".unescapeHTML.should eq "<"
        end

        specify '"&gt;".unescapeHTML == ">"' do
          "&gt;".unescapeHTML.should eq ">"
        end

        specify '"&amp;".unescapeHTML == "&"' do
          "&amp;".unescapeHTML.should eq "&"
        end

        specify '"&lt;a href=&quot;http://e.com/&quot;&gt;e.com&lt;/a&gt;".unescapeHTML == "<a href=\'http://e.com/\'>e.com</a>"' do
          "&lt;a href=&quot;http://e.com/&quot;&gt;e.com&lt;/a&gt;".unescapeHTML.
            should eq "<a href='http://e.com/'>e.com</a>"
        end
      end

      describe "#mb_length" do
        specify '"日本語文字列".mb_length == 6', charset:true do
          "日本語文字列".mb_length.should eq 6
        end

        specify '"English".mb_length == 7', charset:true do
          "English".mb_length.should eq 7
        end
      end

      describe "#mb_substring" do
        specify '"日本語文字列".mb_substring(1,4) == "本語文"', charset:true do
          "日本語文字列".mb_substring(1,4).should eq "本語文"
        end

        specify '"English".mb_substring(1,4) == "ngl"', charset:true do
          "English".mb_substring(1,4).should eq "ngl"
        end
      end
    end
  end
end
