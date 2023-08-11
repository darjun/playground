function digitButton (digit)
    return Button {
        label = tostring(digit),
        action = function ()
            add_to_display(digit)
        end
    }
end
