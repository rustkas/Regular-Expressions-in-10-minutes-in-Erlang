<script>
function doSpellCheck(form, field) {
// Make sure not empty
if (field.value == '') {
return false;
}

// Init
var windowName='spellWindow';
var spellCheckURL='spell.cfm?formname=comment&fieldname='+field.name;

// ...

// Done
return false;
}
</script>