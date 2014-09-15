class Hash
    def delete_blanks!
        delete_if { |k, v| v.nil? }
    end
end
