package com.odtu.mms.util;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Calendar;

import mva.util.MVAUtil;

public class CustomCalendarEditor extends PropertyEditorSupport {

    private final DateFormat dateFormat;
    private final boolean allowEmpty;
    private final int exactDateLength;

    public CustomCalendarEditor(DateFormat dateFormat, boolean allowEmpty) {
        this.dateFormat = dateFormat;
        this.allowEmpty = allowEmpty;
        this.exactDateLength = -1;
    }

    public CustomCalendarEditor(DateFormat dateFormat, boolean allowEmpty, int exactDateLength) {
        this.dateFormat = dateFormat;
        this.allowEmpty = allowEmpty;
        this.exactDateLength = exactDateLength;
    }

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (this.allowEmpty && (text == null || text.isEmpty() || MVAUtil.isEmpty(text))) {
            setValue(null);
        } else if (text != null && !MVAUtil.isEmpty(text) && this.exactDateLength >= 0 && text.length() != this.exactDateLength) {
            final String message = "Could not parse date: it is not exactly" + this.exactDateLength + "characters long";
            throw new IllegalArgumentException(message);
        } else {
            try {
                Calendar c = Calendar.getInstance();
                c.setTime(this.dateFormat.parse(text));
                setValue(c);
            } catch (ParseException ex) {
                
            }
        }
    }

    @Override
    public String getAsText() {
        Calendar c = (Calendar) getValue();
        return c != null ? this.dateFormat.format(c.getTime()) : "";
    }
}

