<?php

//模板字段
function template($field, $value, $fieldinfo) {
    return \Form::select_template("", 'content', $value, 'name="info[' . $field . ']" id="' . $field . '"', 'show');
}
